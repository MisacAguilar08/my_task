import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../model/task.dart';
import '../../utils/app_texts.dart';
import '../task_list/task_list_page.dart';
import '../task_list/task_provider.dart';

class TaskPage extends StatelessWidget {
  final Task? task;
  TaskPage({super.key, this.task});

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController(
      text: task?.title ?? "",
    );

    final taskProvider = Provider.of<TaskProvider>(context, listen: false);

    void addTask() async {
      try {
        final taskTitle = _controller.text.trim();
        var uuid = Uuid();
        if (taskTitle.isNotEmpty) {
          String timeStamp = task?.date ?? DateTime.timestamp().toString();
          bool status = task?.done ?? false;
          String id = task?.id ?? uuid.v4();
          final newTask = Task(timeStamp, taskTitle, done: status, id: id);

          if (task == null) {
            taskProvider.addTask(newTask);
          } else {
            taskProvider.editTask(newTask);
          }
        }
      } catch (e) {}
    }

    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (bool didPop, dynamic result) async {
        if (didPop) {
          addTask();
        }
      },
      child: Scaffold(
        primary: true,
        appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.save_as)),
          actions: [
            IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () {

              },
            ),
            PopupMenuButton<String>(
              onSelected: (value) {

              },
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                    value: 'Eliminar',
                    child: Text('Eliminar'),
                  ),
                ];
              },
            ),
          ],
            ),

        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  maxLines: null,
                  expands: true,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: AppTexts.taskListModalInputDescription),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
