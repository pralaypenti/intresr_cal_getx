import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IntrestController extends GetxController {
  var amountController = TextEditingController();
  var rateController = TextEditingController();
  var yearsController = TextEditingController();
  var result = 0.0.obs;
  var selectedCurrency = 'Rupees'.obs;
  final conversionRates = {
    'Rupees': 1.0,
    'Dollars': 1 / 83.0,
    'Pounds': 1 / 103.0,
  };

  void calculateInterest() {
    double a = double.tryParse(amountController.text) ?? 0;
    double r = double.tryParse(rateController.text) ?? 0;
    double y = double.tryParse(yearsController.text) ?? 0;

    double interestInRupees = (a * r * y) / 100;

    double rateFactor = conversionRates[selectedCurrency.value] ?? 1.0;
    result.value = interestInRupees * rateFactor;
  }

  void resetFields() {
    amountController.clear();
    rateController.clear();
    yearsController.clear();
    selectedCurrency.value = 'Rupees';
    result.value = 0.0;
  }

  @override
  void onClose() {
    amountController.dispose();
    rateController.dispose();
    yearsController.dispose();
    super.onClose();
  }
}

class IntrestCalView extends StatefulWidget {
  const IntrestCalView({super.key});

  @override
  State<IntrestCalView> createState() => _IntrestCalViewState();
}

class _IntrestCalViewState extends State<IntrestCalView> {
  final controller = Get.put(IntrestController());

  List<String> iteams = ['Rupees', 'Dollars', 'Pounds'];
  final formKey = GlobalKey<FormState>();

  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Intrest Cal App', textAlign: TextAlign.center),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Enter amount';
                    if (double.tryParse(value) == null) {
                      return 'Enter valid number';
                    }
                    return null;
                  },
                  controller: controller.amountController,
                  keyboardType: TextInputType.number,

                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Amount',
                     errorStyle: TextStyle(
                            color: Colors.cyan,
                            fontSize: 15.0
                          ),
                  ),
                ),
                SizedBox(height: 25),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter persentage';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Enter valid percentage';
                    }
                    return null;
                  },
                  controller: controller.rateController,

                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'per%',
                    errorStyle: TextStyle(
                      color: Colors.cyan,
                      fontSize: 15.0,
                    ),
                  ),
                ),
                SizedBox(height: 25),

                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Enter year';
                    if (double.tryParse(value) == null) {
                      return 'Enter valid year';
                    }
                    return null;
                  },
                  controller: controller.yearsController,
                  keyboardType: TextInputType.number,

                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Years',
                     errorStyle: TextStyle(
                            color: Colors.cyan,
                            fontSize: 15.0
                          ),
                  ),
                ),
                SizedBox(height: 25),
                Center(
                  child: Obx(() {
                    return DropdownButton<String>(
                      value: controller.selectedCurrency.value,
                      items:
                          controller.conversionRates.keys.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          controller.selectedCurrency.value = newValue;
                          newValue;
                        }
                      },
                    );
                  }),
                ),
                SizedBox(height: 25),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          controller.calculateInterest();
                        }
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
                    SizedBox(width: 25),
                    ElevatedButton(
                      onPressed: () {
                        controller.resetFields();
                        formKey.currentState!.reset();
                      },
                      child: Text(
                        'Reset',
                        style: TextStyle(
                          color: Colors.pinkAccent,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 25),

                Obx(() {
                  return Center(
                    child: Text(
                      'result: ${controller.result.value}',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
