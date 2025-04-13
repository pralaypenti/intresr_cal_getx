import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoveController extends GetxController {
  final firstNameController = TextEditingController();
  final secoundNameController = TextEditingController();
  var result = ''.obs;

  List<String> flames = [
    "Siblings",
    "Friends",
    "Love",
    "Affection",
    "Marriage",
    "Enemies",
  ];

  void loveCalResult() {
    String name1 = firstNameController.text.toLowerCase().replaceAll('', '');
    String name2 = secoundNameController.text.toLowerCase().replaceAll('', '');

    for (int i = 0; i < name1.length - 1; i++) {
      String char = name1[i];
      if (name2.contains(char)) {
        name1 = name1.replaceFirst(char, '');
        name2 = name2.replaceFirst(char, '');
        i--;
      }
      int count = name1.length + name2.length;
      int index = (count % flames.length) - 1;
      if (index < 0) index = flames.length - 1;

      result.value = 'Result:${flames[index]}';
    }
  }
}

class LoveCal extends StatefulWidget {
  const LoveCal({super.key});

  @override
  State<LoveCal> createState() => _LoveCalState();
}

class _LoveCalState extends State<LoveCal> {
  final controller = Get.put(LoveController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Love Flames Calculator'),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('❤️ Love Flames Calculator ❤️'),
            SizedBox(height: 15),
            TextField(
              controller: controller.firstNameController,
              decoration: InputDecoration(
                hintText: 'Enter First Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 15),
            TextField(
              controller: controller.secoundNameController,
              decoration: InputDecoration(
                hintText: 'Enter Secound Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                controller.loveCalResult();
              },
              style: ElevatedButton.styleFrom(
                textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              child: Text(
                'Calculate Love',
                style: TextStyle(color: Colors.pinkAccent),
              ),
            ),

            SizedBox(height: 15),
            Obx(() {
              return Text(
                controller.result.value,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.pink,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
