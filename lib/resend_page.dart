import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intresr_cal_getx/empty_screen.dart';
import 'package:otp_resend_timer/otp_resend_timer.dart';
import 'package:otpless_flutter/otpless_flutter.dart';

class ResendController extends GetxController {
  late OtpResendTimerController _controller;

  final TextEditingController _otpController = TextEditingController();
  final List<FocusNode> _focusNodes = List.generate(4, (index) => FocusNode());
  final List<TextEditingController> _digitControllers = List.generate(
    4,
    (index) => TextEditingController(),
  );

  RxInt remainingTime = 10.obs;

  @override
  void onInit() {
    super.onInit();
    _controller = OtpResendTimerController(initialTime: remainingTime.value);
    _controller.start();
  }

  @override
  void dispose() {
    _controller.dispose();
    _otpController.dispose();
    for (var node in _focusNodes) {
      node.dispose();
    }
    for (var controller in _digitControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void onResendClicked() {
    for (var controller in _digitControllers) {
      controller.clear();
    }

    remainingTime.value = 10;
    _controller.reset();
    _controller.start();
  }

  String getOtp() {
    return _digitControllers.map((c) => c.text).join();
  }

  void onDigitInput(String value, int index) {
    if (value.length == 1) {
      if (index < _focusNodes.length - 1) {
        _focusNodes[index + 1].requestFocus();
      } else {
        FocusManager.instance.primaryFocus?.unfocus();
      }
    }
  }

  List<FocusNode> get focusNodes => _focusNodes;
  List<TextEditingController> get digitControllers => _digitControllers;

  final _otplessFlutterPlugin = Otpless();
  void verifyOtp(String phoneNumber, BuildContext context) {
    final enteredOtp = getOtp();

    if (enteredOtp.length < 4) {
      Get.snackbar("Error", "Please enter the full 4-digit OTP.");
      return;
    }

    Map<String, dynamic> arg = {
      "phone": phoneNumber,
      "countryCode": "+91",
      "otp": enteredOtp,
    };

    _otplessFlutterPlugin.startHeadless(
      (result) => onHeadlessResult(result, context),
      arg,
    );
  }

  void onHeadlessResult(dynamic result, BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const EmptyScreen()),
    );
  }
}

class ResendPageView extends StatefulWidget {
  const ResendPageView({super.key, required this.phoneNumber});
  final String phoneNumber;

  @override
  State<ResendPageView> createState() => _ResendPageViewState();
}

class _ResendPageViewState extends State<ResendPageView> {
  final controller = Get.put(ResendController());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding:  EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 130),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade200,
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Enter OTP Code',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'We\'ve sent a verification code to your phone',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(
                          4,
                          (index) => SizedBox(
                            width: 50,
                            height: 60,
                            child: TextField(
                              controller: controller._digitControllers[index],
                              focusNode: controller._focusNodes[index],
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              maxLength: 1,
                              onChanged:
                                  (value) =>
                                      controller.onDigitInput(value, index),
                              decoration: InputDecoration(
                                counterText: '',
                                contentPadding: EdgeInsets.zero,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                    color: theme.primaryColor,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                    color: theme.primaryColor,
                                    width: 2,
                                  ),
                                ),
                              ),
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            controller.verifyOtp(widget.phoneNumber, context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.primaryColor,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text('Verify'),
                        ),
                      ),
                      const SizedBox(height: 20),
            
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: OtpResendTimer(
                          controller: controller._controller,
                          onResendClicked: controller.onResendClicked,
                          autoStart: true,
                          timerMessage: 'Resend OTP in ',
                          readyMessage: 'You can now resend the code',
                          holdMessage: 'Start timer to enable resend',
                          resendMessage: 'Resend',
                          timerMessageStyle: TextStyle(
                            color: theme.primaryColor,
                            fontSize: 12,
                          ),
                          resendMessageStyle: TextStyle(
                            color: theme.primaryColor,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
