import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:intresr_cal_getx/aditional_oprator_view.dart';
import 'package:intresr_cal_getx/aleart_diloage.dart';
import 'package:intresr_cal_getx/intrest_cal.dart';
import 'package:intresr_cal_getx/login_screen.dart';
import 'package:intresr_cal_getx/love_cal.dart';
import 'package:intresr_cal_getx/shared_prefereence.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(home: ButtonScreen());
  }
}

class ButtonScreen extends StatefulWidget {
  const ButtonScreen({super.key});

  @override
  State<ButtonScreen> createState() => _ButtonScreenState();
}

class _ButtonScreenState extends State<ButtonScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Button Screen'),
        backgroundColor: Colors.yellowAccent,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoveCal()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  textStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: Text(
                  'Calculate Love',
                  style: TextStyle(color: Colors.pinkAccent),
                ),
              ),
              SizedBox(height: 25),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => IntrestCalView()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  textStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: Text(
                  'Intrest Cal Button',
                  style: TextStyle(color: Colors.pinkAccent),
                ),
              ),
              SizedBox(height: 25),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SharedPreference()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  textStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: Text(
                  'Shared Preference Button',
                  style: TextStyle(color: Colors.pinkAccent),
                ),
              ),

              SizedBox(height: 25),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreenPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  textStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: Text(
                  'Login Page Button',
                  style: TextStyle(color: Colors.pinkAccent),
                ),
              ),

              SizedBox(height: 25),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AleartDiloageScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  textStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: Text(
                  'Aleart Button',
                  style: TextStyle(color: Colors.pinkAccent),
                ),
              ),
              SizedBox(height: 25),

              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AditionalOparator(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  textStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: Text(
                  'Additional  Button',
                  style: TextStyle(color: Colors.pinkAccent),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
