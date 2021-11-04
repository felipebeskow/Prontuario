import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:prontuario/apresention/home.dart';
import 'package:prontuario/control/authentication.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool? _loading = false;

  loading(){
    setState(() {
      _loading = true;
    });
  }

  @override
  Widget build (BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Faça o Login'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FutureBuilder(
              future: Authentication.initializeFirebase(context: context),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Text('Error initializing Firebase');
                } else if (snapshot.connectionState == ConnectionState.done) {
                  return SignInButton(
                      Buttons.Google,
                      text: 'Faça login com o Google',
                      onPressed: () async {
                        loading();
                        User? user = await Authentication.signInWithGoogle(
                            context: context);
                        if (user != null) {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => HomePage(user: user),
                            ),
                          );
                        }

                      }
                  );
                };
                return const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.deepOrangeAccent,
                  ),
                );
              },
            ),
            const SizedBox(height: 100),
            Visibility(
              visible: _loading!,
              child: LoadingBouncingLine.square(
                backgroundColor: Colors.deepPurple,
              )
            ),
          ],
        ),
      ),
    );
  }
}
