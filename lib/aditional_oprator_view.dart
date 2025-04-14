import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdditonalController extends GetxController {
  final value1 = TextEditingController();
  final value2 = TextEditingController();
  var result = 0.obs;
  void addValue() {
    int? val1 = int.tryParse(value1.text);
    int? val2 = int.tryParse(value2.text);

    result.value = val1! + val2!;
  }

  @override
  void onClose() {
    value1.dispose();
    value2.dispose();
    super.onClose();
  }
}

class AditionalOparator extends StatefulWidget {
  const AditionalOparator({super.key});

  @override
  State<AditionalOparator> createState() => _AditionalOparatorState();
}

class _AditionalOparatorState extends State<AditionalOparator> {
  final controller = Get.put(AdditonalController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Aditional oparator Screen'),
        backgroundColor: Colors.limeAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              controller: controller.value1,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Add Value',
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: controller.value2,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Add Value',
              ),
            ),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                controller.addValue();
              },
              style: ElevatedButton.styleFrom(
                textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              child: Text(
                'Add Value',
                style: TextStyle(color: Colors.pinkAccent),
              ),
            ),

            SizedBox(height: 25),
            Obx(
              () => Text(
                'Result:${controller.result}',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
