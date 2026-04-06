import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_screen.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final email = TextEditingController();
  final pass = TextEditingController();

  void login() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email.text.trim(),
      password: pass.text.trim(),
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => HomeScreen()),
    );
  }

  void signup() async {
    var user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email.text.trim(),
      password: pass.text.trim(),
    );

    // create user profile
    // ignore: unused_local_variable
    var uid = user.user!.uid;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("KamiChat 💬", style: TextStyle(fontSize: 32)),
            SizedBox(height: 20),
            TextField(controller: email, decoration: InputDecoration(hintText: "Email")),
            TextField(controller: pass, decoration: InputDecoration(hintText: "Password")),
            SizedBox(height: 10),
            ElevatedButton(onPressed: login, child: Text("Login")),
            ElevatedButton(onPressed: signup, child: Text("Signup")),
          ],
        ),
      ),
    );
  }
}
