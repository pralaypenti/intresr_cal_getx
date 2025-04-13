import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intresr_cal_getx/resend_page.dart';
import 'package:otpless_flutter/otpless_flutter.dart';

class LoginController extends GetxController {
  final mobileController = TextEditingController();

  final _otplessFlutterPlugin = Otpless();

  @override
  void onInit() {
    _otplessFlutterPlugin.initHeadless("GYAZZUKY316G1H8ZOGFC");
    _otplessFlutterPlugin.setHeadlessCallback(onHeadlessResult);
    super.onInit();
  }

  void onHeadlessResult(dynamic result) {
  }

  void sendOtp(context) {
    if (mobileController.text.isEmpty) {
    } else {
      Map<String, dynamic> arg = {};
      arg["phone"] = mobileController.text;
      arg["countryCode"] = "+91";
      _otplessFlutterPlugin.startHeadless(onHeadlessResult, arg);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ResendPageView( phoneNumber: mobileController.text,),
        ),
      );
    }
  }

  void socialLogin(String channel) {
    Map<String, dynamic> arg = {'channelType': channel};
    _otplessFlutterPlugin.startHeadless(onHeadlessResult, arg);
  }
}

class LoginScreenPage extends StatefulWidget {
  const LoginScreenPage({super.key});

  @override
  State<LoginScreenPage> createState() => _LoginScreenPageState();
}

class _LoginScreenPageState extends State<LoginScreenPage> {
  final controller = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(' Login Page Screen'),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              controller: controller.mobileController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Mobile Number',
              ),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
               controller.sendOtp(context);
              },
              child: Text(
                'Send',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
