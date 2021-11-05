import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prontuario/apresention/agendamentos.dart';
import 'package:prontuario/apresention/cadastro_cliente.dart';
import '../control/global.dart' as global;

class HomePage extends StatefulWidget{
  User? _user;
  HomePage({Key? key}) : super(key: key){
    _user = global.user;
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    String nome = 'SEM-NOME';
    nome = widget._user!.displayName!;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prontuário - Início'),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed:(){
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const Agendamento(),
                ),
              );
            }
          )
        ],
      ),
      body: Center(
        child: Text('Olá ' + nome),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const CadastroCliente(),
            ),
          );
        },
        child: const Icon(
            Icons.add,
        ),
      ),
    );
  }
}