import 'package:flutter/material.dart';
import 'package:my_task/app/model/task.dart';
import 'package:my_task/app/widgtes/title_task_list.dart';

import '../../widgtes/images_task_list.dart';

class TaskList extends StatelessWidget {
  const TaskList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _Header(),
          Expanded(child: _TaskList()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showNewTaskModal(context),
        child: Icon(Icons.add),
      ),
    );
  }

  void _showNewTaskModal(BuildContext context) {
    showModalBottomSheet(context: context, builder: (_) => _NewTaskModal());
  }
}

class _NewTaskModal extends StatelessWidget {
  const _NewTaskModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TitleTaskList(text: 'Nueva Tarea'),
          TextField(),
          ElevatedButton(onPressed: (){}, child: Text('Guardar'))
        ],
      ),
    );
  }
}


class _TaskList extends StatefulWidget {
  const _TaskList({
    super.key,
  });

  @override
  State<_TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<_TaskList> {
  final taskList = <Task>[
    Task("Sacar al perro"),
    Task("Hacer la compra"),
    Task("Ir al partido")
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleTaskList(text: "Tareas"),
          Expanded(
            child: ListView.separated(
                itemBuilder: (_, index) => _taskItem(
                      task: taskList[index],
                      onTap: () {
                        taskList[index].done = !taskList[index].done;
                        setState(() {});
                      },
                    ),
                separatorBuilder: (_, __) => const SizedBox(
                      height: 16,
                    ),
                itemCount: taskList.length),
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
  const _taskItem({super.key, required this.task, this.onTap});

  final Task task;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(21)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 21.0, vertical: 18),
            child: Row(
              children: [
                Icon(
                  task.done
                      ? Icons.check_box_rounded
                      : Icons.check_box_outline_blank,
                  color: Theme.of(context).colorScheme.primary,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(task.title),
              ],
            ),
          )),
    );
  }
}
