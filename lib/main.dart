import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'auth_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyA5qvHjNlTu06lDukX0QpVnoqldVhKRmPA",
      appId: "1:1050283607163:web:2fc9984764d166cc5c0ede",
      messagingSenderId: "1050283607163",
      projectId: "kamichat-b1f6b",
    ),
  );

  runApp(KamiChat());
}

class KamiChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.green,
      ),
      home: AuthScreen(),
    );
  }
}
