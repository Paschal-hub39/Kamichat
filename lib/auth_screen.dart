import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'services.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final AppServices service = AppServices();

  void login() async {
    await service.login(emailController.text.trim(), passController.text.trim());
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen()));
  }

  void signup() async {
    await service.signup(emailController.text.trim(), passController.text.trim());
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("KamiChat 💬", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            TextField(controller: emailController, decoration: InputDecoration(hintText: "Email")),
            TextField(controller: passController, decoration: InputDecoration(hintText: "Password")),
            SizedBox(height: 10),
            ElevatedButton(onPressed: login, child: Text("Login")),
            ElevatedButton(onPressed: signup, child: Text("Signup")),
          ],
        ),
      ),
    );
  }
}