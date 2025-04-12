import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IntrestController extends GetxController {
  var amount = ''.obs;
  var rate = ''.obs;
  var years = ''.obs;
  var result = 0.0.obs;

  void calculateInterest() {
    double a = double.tryParse(amount.value) ?? 0;
    double r = double.tryParse(rate.value) ?? 0;
    double y = double.tryParse(years.value) ?? 0;

    result.value = (a * r * y) / 100;
  }
}

class IntrestCalView extends StatefulWidget {
  const IntrestCalView({super.key});

  @override
  State<IntrestCalView> createState() => _IntrestCalViewState();
}

class _IntrestCalViewState extends State<IntrestCalView> {
  final controller = Get.put(IntrestController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Intrest Cal App', textAlign: TextAlign.center),
        ),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                onChanged: (value) {
                  controller.amount.value = value;
                },
                keyboardType: TextInputType.number,

                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Amount',
                ),
              ),
              SizedBox(height: 25),
              TextFormField(
                onChanged: (value) {
                  controller.rate.value = value;
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'per%',
                ),
              ),
              SizedBox(height: 25),

              TextFormField(
                onChanged: (value) {
                  controller.years.value = value;
                },
                keyboardType: TextInputType.number,

                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Years',
                ),
              ),
              SizedBox(height: 25),

              Center(
                child: Padding(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: ElevatedButton(
                    onPressed: () {
                      controller.calculateInterest();
                    },
                    child: Text(
                      'Calculate',
                      style: TextStyle(
                        color: Colors.pinkAccent,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 25),

              Obx(() {
                return Center(
                  child: Text(
                    'result: ${controller.result.value.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
