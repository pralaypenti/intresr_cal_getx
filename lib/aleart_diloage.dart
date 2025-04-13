import 'package:flutter/material.dart';

class AleartDiloageScreen extends StatefulWidget {
  const AleartDiloageScreen({super.key});

  @override
  State<AleartDiloageScreen> createState() => _AleartDiloageScreenState();
}

class _AleartDiloageScreenState extends State<AleartDiloageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Aleart Diloage'),
        backgroundColor: Colors.redAccent,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  show();
                },
                child: Text(
                  'Show Diloage',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void show() {
    var alertDialog = AlertDialog(
      title: Text('Confirm Action',),
      content: Text('Are you sure you want to proceed?',style: TextStyle(fontSize: 25,fontWeight:FontWeight.bold)),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context, true);
          },
          child: Text('Yes',style: TextStyle(fontSize: 25,fontWeight:FontWeight.w500),),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, true);
          },
          child: Text('No',style: TextStyle(fontSize: 25,fontWeight:FontWeight.bold)),
        ),
      ],
    );

    showDialog(
      context: context,
      builder: (context) {
        return alertDialog;
      },
    );
  }
}
