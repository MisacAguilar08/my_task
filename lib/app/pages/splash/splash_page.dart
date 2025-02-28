import 'package:flutter/material.dart';
import 'package:my_task/app/pages/task_list/task_list_page.dart';

import '../../widgtes/images_task_list.dart';
import '../../widgtes/title_task_list.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
          SizedBox(height: 79),
          ImagesTaskList(
            nameImages: "onboarding-image",
            imageWidth: 180,
            imageHeight: 168,
          ),
          SizedBox(height: 99),
          TitleTaskList(
            text: 'Lista de Tareas',
          ),
          SizedBox(height: 21),
          GestureDetector(
            onTap: () {
              print("Click navegator");
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return TaskList();
              }));
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                  textAlign: TextAlign.center,
                  'La mejor forma para que no se te olvide nada es anotarlo. Guardar tus tareas y ve completando poco a poco para aumentar tu productividad'),
            ),
          ),
        ],
      ),
    );
  }
}
