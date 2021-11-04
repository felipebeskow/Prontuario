import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget{
  User? _user;
  HomePage({required User user, Key? key}) : super(key: key){
    _user = user;
  }
  @override
  Widget build(BuildContext context) {
    String nome = 'SEM-NOME';
    nome = _user!.displayName!;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prontuário - Início'),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.calendar_today),
          )
        ],
      ),
      body: Center(
        child: Text('Olá ' + nome),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //go to cadastro clientes

        },
        child: const Icon(
            Icons.add,
        ),
      ),
    );
  }
  
}