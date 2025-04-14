import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedController extends GetxController {
  final nameTextController = TextEditingController();
  var saveName = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadSavedName();
  }

  void loadSavedName() async {
    final prefs = await SharedPreferences.getInstance();
    saveName.value = prefs.getString('name') ?? '';
    nameTextController.text = saveName.value;
  }

  void saveNameToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', nameTextController.text);
    saveName.value = nameTextController.text;
    nameTextController.clear();
  }
}

class SharedPreference extends StatelessWidget {
  const SharedPreference({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SharedController());

    return Scaffold(
      appBar: AppBar(
        title: Text('Shared Preference'),
        backgroundColor: Colors.lightGreenAccent,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 19, vertical: 19),
        child: Column(
          children: [
            TextFormField(
              controller: controller.nameTextController,
              decoration: InputDecoration(hintText: 'Please enter a name'),
              // Add text input action
              textInputAction: TextInputAction.done,
            ),
            SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
                FocusScope.of(context).unfocus();
                controller.saveNameToPrefs();
              },
              child: Text('Save The Name'),
            ),
            SizedBox(height: 25),
            Obx(
              () => Text(
                'Saved Name: ${controller.saveName.value.isEmpty ? "No name saved" : controller.saveName.value}',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
