import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prontuario/apresention/login.dart';

class InitApp extends StatelessWidget {
  InitApp({Key? key}) : super(key: key);
  User? result = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Prontuário',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        home: const LoginPage()
    );
  }
}