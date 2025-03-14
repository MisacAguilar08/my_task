import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../model/task.dart';
import '../../services/notifications.dart';
import '../../utils/app_text_style.dart';
import '../../utils/app_texts.dart';
import '../task_list/task_provider.dart';

class TaskPage extends StatelessWidget {
  final Task? task;
  TaskPage({super.key, this.task});

  late RepeatInterval repeatInterval;

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController(
      text: task?.title ?? "",
    );

    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    NotificationService notificationService = new NotificationService();

    void addTask() async {
      try {
        final taskTitle = _controller.text.trim();
        var uuid = Uuid();
        if (taskTitle.isNotEmpty) {
          int idNotification = task?.notification ?? Random().nextInt(127000);
          String timeStamp = task?.date ?? DateTime.timestamp().toString();
          bool status = task?.done ?? false;
          String id = task?.id ?? uuid.v4();
          final newTask = Task(timeStamp, taskTitle,
              done: status, id: id, notification: idNotification);

          if (task == null) {
            taskProvider.addTask(newTask);
          } else {
            taskProvider.editTask(newTask);
          }

          List<int> index = [0,1,2,3];
          if (index.contains(repeatInterval.index)) {
            await notificationService.periodicallyNotification(
                newTask.notification, newTask.title, repeatInterval);
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
              icon: Icon(Icons.notification_add),
              onPressed: () {
                _showNotificationModal(context);
              },
            ),
            PopupMenuButton<String>(
              onSelected: (value) {},
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

  void _showNotificationModal(BuildContext context) {
    showModalBottomSheet(
      // isScrollControlled: true,
      context: context,
      builder: (_) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: NotificationOption(context),
        );
      },
    );
  }

  Widget NotificationOption(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(21)),
          color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Recordarme mas tarde",
              style: AppTextStyle.text_normal_16,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Divider(),
          NotificationOptionTask(
            texto: "Cada minuto",
            onTap: () {
              repeatInterval = RepeatInterval.everyMinute;
              Navigator.pop(context);
            },
          ),
          NotificationOptionTask(
            texto: "Cada hora",
            onTap: () {
              repeatInterval = RepeatInterval.hourly;
              Navigator.pop(context);
            },
          ),
          NotificationOptionTask(
            texto: "Cada dia",
            onTap: () {
              repeatInterval = RepeatInterval.daily;
              Navigator.pop(context);
            },
          ),
          NotificationOptionTask(
            texto: "Cada semana",
            onTap: () {
              repeatInterval = RepeatInterval.weekly;
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

class NotificationOptionTask extends StatelessWidget {
  final String texto;
  final VoidCallback onTap;
  const NotificationOptionTask({
    super.key,
    required this.texto,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        child: SizedBox(
          width: double.infinity,
          height: 40,
          child: Text(texto),
        ),
      ),
    );
  }
}
