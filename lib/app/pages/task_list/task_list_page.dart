import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_task/app/model/task.dart';
import 'package:my_task/app/pages/task_list/task_provider.dart';
import 'package:my_task/app/repository/task_repository.dart';
import 'package:my_task/app/widgtes/title_task_list.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgtes/images_task_list.dart';

class TaskList extends StatelessWidget {
  const TaskList({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TaskProvider()..fetchTasks(),
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _Header(),
            Expanded(child: _TaskList()),
          ],
        ),
        floatingActionButton: Builder(
            builder: (context) => FloatingActionButton(
                  onPressed: () => _showNewTaskModal(context),
                  child: Icon(Icons.add),
                )),
      ),
    );
  }

  void _showNewTaskModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) => ChangeNotifierProvider.value(
              value: context.read<TaskProvider>(),
              child: _NewTaskModal(),
            ));
  }
}

class _NewTaskModal extends StatelessWidget {
  _NewTaskModal({super.key});

  final _controller = TextEditingController();

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
            text: 'Nueva Tarea',
          ),
          SizedBox(
            height: 26,
          ),
          TextField(
            controller: _controller,
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                hintText: "Descripcion de la tarea"),
          ),
          SizedBox(
            height: 26,
          ),
          ElevatedButton(
              onPressed: () {
                if (_controller.text.isNotEmpty &&
                    _controller.text.toString().trim().length != 0) {
                  final idTask = DateTime.timestamp();
                  final task = Task(idTask.toString(), _controller.text);
                  context.read<TaskProvider>().addTask(task);
                  Navigator.of(context).pop();
                }
              },
              child: Text('Guardar'))
        ],
      ),
    );
  }
}

class _TaskList extends StatelessWidget {
  const _TaskList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleTaskList(text: "Tareas"),
          Expanded(
            child: Consumer<TaskProvider>(
              builder: (_, provider, __) {
                if (provider.taskList.isEmpty) {
                  return Center(
                    child: Text('No hay tareas'),
                  );
                }

                return ListView.separated(
                    itemBuilder: (_, index) => _taskItem(
                          task: provider.taskList[index],
                          onTap: (_) => {
                            provider.onTaskDoneChange(provider.taskList[index])
                          },
                          onDelete: () {
                            provider.deleteTask(provider.taskList[index]);
                          },
                        ),
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
                nameImages: "shape",
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
                nameImages: "tasks-list-image",
                imageWidth: 120,
                imageHeight: 120,
              ),
              SizedBox(
                height: 16,
              ),
              TitleTaskList(
                text: "Completa tus tareas",
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
  const _taskItem({super.key, required this.task, this.onTap, this.onDelete});

  final Task task;
  final ValueChanged? onTap;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(21)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 21.0, vertical: 18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Checkbox(value: task.done, onChanged: onTap),
              SizedBox(
                width: 10,
              ),
              Text(task.title),
              MaterialButton(
                onPressed: onDelete,
                child: Icon(
                  Icons.delete_outline,
                  color: Colors.red,
                ),
              ),
              // MaterialButton(onPressed: (){},
              //   child: Icon(Icons.edit, color: Colors.red,),),
            ],
          ),
        ));
  }
}
