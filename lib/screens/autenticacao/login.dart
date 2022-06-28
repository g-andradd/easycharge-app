import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: SingleChildScrollView(
          child: Column(
            children: const [
            Align(
              alignment: Alignment.topCenter,
              child: Text("EasyCharge", style: TextStyle(fontSize: 35.0)),
            ),

            SizedBox(height: 35),
            Center(
              
            ),
              
          ],
        ),
      ),
    ),
    backgroundColor: Theme.of(context).secondaryHeaderColor,
    );
  }
}
