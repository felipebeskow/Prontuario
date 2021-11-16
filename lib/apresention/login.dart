import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:prontuario/apresention/home.dart';
import 'package:prontuario/control/authentication.dart';
import '../control/global.dart' as global;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool? _loading = false;

  loading(){
    setState(() {
      if (_loading == true)
        _loading = false;
      else
        _loading = true;
    });
  }

  @override
  Widget build (BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prontuário - Login')
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
                          CollectionReference usuarios = FirebaseFirestore.instance.collection('usuarios');

                          try{
                            var usuario = await usuarios.where(
                                'uid', isEqualTo: user.uid
                            ).get();

                            usuarios.doc(usuario.docs.first.id).update({
                              'lastLoginAt': DateTime.now(),
                            });

                            global.user = user;
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => HomePage(),
                              ),
                            );
                          } catch(e){
                            CollectionReference usuariosBlocked = FirebaseFirestore.instance.collection('usuarios-blocked');
                            usuariosBlocked.add({
                              'uid': user.uid,
                              'email': user.email,
                              'nome': user.displayName,
                              'telefone': user.phoneNumber,
                              'lastLoginAt': DateTime.now()
                            });
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Erro ao autorizar acesso\n${user.displayName} peça para o administrador autorizar seu usuário')
                            ),);
                            loading();
                          }

                        }
                      }
                  );
                }
                return const Text('Carregando ...');
              },
            ),
            const SizedBox(height: 100),
            Visibility(
              visible: _loading!,
              child: LoadingBouncingLine.square(
                backgroundColor: Colors.teal,
              )
            ),
          ],
        ),
      ),
    );
  }
}
