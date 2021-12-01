import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:prontuario/apresention/home.dart';
import 'package:prontuario/apresention/login.dart';
import './global.dart' as global;

class InitApp extends StatelessWidget {
  InitApp({Key? key}) : super(key: key);
  User? result = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'Prontuário',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: (global.user == null) ? const LoginPage() : HomePage(),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate
      ],
      supportedLocales: const [
        Locale('pt'),
      ],
    );
  }
}