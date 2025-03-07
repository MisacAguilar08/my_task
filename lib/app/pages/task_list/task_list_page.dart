import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_task/app/model/task.dart';
import 'package:my_task/app/pages/task_list/task_provider.dart';
import 'package:my_task/app/utils/app_images.dart';
import 'package:my_task/app/utils/app_texts.dart';
import 'package:my_task/app/widgtes/title_task_list.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../../services/note_service.dart';
import '../../widgtes/images_task_list.dart';
import 'offline_sync_provider.dart';

class TaskList extends StatefulWidget {
  const TaskList({super.key});

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TaskProvider()..fetchTasks(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _Header(),
            Expanded(child: _TaskList()),
          ],
        ),
        floatingActionButton: buildModalTaskList(),
      ),
    );
  }

  Builder buildModalTaskList() {
    return Builder(
        builder: (context) => SizedBox(
              width: 45,
              height: 45,
              child: FloatingActionButton(
                onPressed: () => _showNewTaskModal(context),
                child: Icon(Icons.add),
              ),
            ));
  }
}

void _showNewTaskModal(BuildContext context, {Task? editTask}) {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (_) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom, // Ajuste dinámico
        ),
        child: ChangeNotifierProvider.value(
          value: context.read<TaskProvider>(),
          child: _NewTaskModal(editTask: editTask),
        ),
      );
    },
  );
}

class _NewTaskModal extends StatefulWidget {
  _NewTaskModal({super.key, this.editTask});

  final Task? editTask;

  @override
  State<_NewTaskModal> createState() => _NewTaskModalState();
}

class _NewTaskModalState extends State<_NewTaskModal> {
  final NotesService notesService = NotesService();
  late TextEditingController _controller;

  bool isSave = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.editTask?.title ?? "",
    );
  }

  Future<void> addNote(String id, String date, bool statusDone) async {
    String title = _controller.text;
    if (title.isNotEmpty) {
      isSave = await notesService.addNote(id, title, statusDone, date);
      _controller.clear();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(21)),
          color: Colors.white),
      padding: EdgeInsets.symmetric(horizontal: 33, vertical: 23),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          TitleTaskList(
            text: AppTexts.taskListModalTitle,
          ),
          SizedBox(
            height: 26,
          ),
          TextField(
            controller: _controller,
            decoration: InputDecoration(
                hintMaxLines: 8,
                filled: true,
                fillColor: Colors.white,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                hintText: AppTexts.taskListModalInputDescription),
          ),
          SizedBox(
            height: 26,
          ),
          ElevatedButton(
              onPressed: () async {
                final taskTitle = _controller.text.trim();
                var uuid = Uuid();
                if (taskTitle.isNotEmpty) {
                  String timeStamp =
                      widget.editTask?.date ?? DateTime.timestamp().toString();
                  bool status = widget.editTask?.done ?? false;
                  String id = widget.editTask?.id ?? uuid.v4();
                  final newTask =
                      Task(timeStamp, taskTitle, done: status, id: id);

                  if (widget.editTask == null) {
                    await addNote(id, timeStamp, status);
                    context.read<TaskProvider>().addTask(newTask);
                  } else {
                    context.read<TaskProvider>().editTask(newTask);
                    await addNote(id, timeStamp, status);
                  }

                  if (!isSave) {
                    context
                        .read<OfflineSyncProvider>()
                        .addPendingOperation("create", newTask);
                    isSave = false;
                  }

                  Navigator.of(context).pop();
                }
              },
              child: Text(AppTexts.taskListModalButton))
        ],
      ),
    );
  }
}

class _TaskList extends StatelessWidget {
  final NotesService notesService = NotesService();
  late bool isDelete = false;
  _TaskList({
    super.key,
  });

  Future<void> deleteNote(String id) async {
    isDelete = await notesService.deleteNote(id);
  }

  void updateNoteCheck(String id, bool check) async {
    await notesService.updateNoteDone(id, check);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleTaskList(text: AppTexts.taskListBody),
          Expanded(
            child: Consumer<TaskProvider>(
              builder: (_, provider, __) {
                if (provider.taskList.isEmpty) {
                  return Center(
                    child: Text(AppTexts.taskListEmpty),
                  );
                }

                return ListView.separated(
                    itemBuilder: (_, index) => _taskItem(
                        task: provider.taskList[index],
                        onTap: (_) async {
                          provider.onTaskDoneChange(provider.taskList[index]);
                          updateNoteCheck(provider.taskList[index].id,
                              provider.taskList[index].done);
                        },
                        onDelete: () async {
                          Task idTemporal = provider.taskList[index];
                          provider.deleteTask(provider.taskList[index]);
                          await deleteNote(provider.taskList[index].id);
                          if (!isDelete) {
                            context
                                .read<OfflineSyncProvider>()
                                .addPendingOperation(
                                    "delete", idTemporal);
                            isDelete = false;
                          }
                        },
                        onEdit: () {
                          _showNewTaskModal(context,
                              editTask: provider.taskList[index]);
                        }),
                    separatorBuilder: (_, __) => const SizedBox(
                          height: 16,
                        ),
                    itemCount: provider.taskList.length);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.primary,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Row(
            children: [
              ImagesTaskList(
                nameImages: AppImages.shape,
                imageWidth: 141,
                imageHeight: 129,
              ),
            ],
          ),
          Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              ImagesTaskList(
                nameImages: AppImages.taskList,
                imageWidth: 120,
                imageHeight: 120,
              ),
              SizedBox(
                height: 16,
              ),
              TitleTaskList(
                text: AppTexts.taskListHeader,
                color: Colors.white,
              ),
              SizedBox(
                height: 24,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _taskItem extends StatelessWidget {
  const _taskItem(
      {super.key, required this.task, this.onTap, this.onDelete, this.onEdit});

  final Task task;
  final ValueChanged? onTap;
  final VoidCallback? onDelete;
  final VoidCallback? onEdit;

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(21)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  width: 30,
                  child: Checkbox(value: task.done, onChanged: onTap)),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text(task.title),
              ),
              GestureDetector(
                onTap: onEdit,
                child: Container(
                  child: Icon(
                    Icons.edit,
                    color: Colors.blue,
                  ),
                ),
              ),
              SizedBox(
                width: 15,
              ),
              GestureDetector(
                onTap: onDelete,
                child: Container(
                  child: Icon(
                    Icons.delete_outline,
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
