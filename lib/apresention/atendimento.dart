import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prontuario/apresention/agendamentos.dart';
import 'package:prontuario/apresention/home.dart';

import 'package:intl/intl.dart';

class Atendimento extends StatelessWidget{
  var _cliente;

  Atendimento(cliente):super(){
    _cliente = cliente;
  }

  @override
  Widget build(BuildContext context) {
    var hoje = DateTime.now();
    print(_cliente.id);
    return Scaffold(
      appBar: AppBar(
          title: const Text('Prontuário - Cadastro Clientes'),
          actions: [
            IconButton(
                icon: const Icon(Icons.calendar_today),
                onPressed:(){
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Agendamento(),
                    ),
                  );
                }
            ),
            IconButton(
                icon: const Icon(Icons.home),
                onPressed:(){
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ),
                          (Route<dynamic> route) => route is HomePage
                  );
                }
            ),
          ]
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              Center(
                child: Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        title: Text('Cliente: ' + _cliente.get('nome')),
                        subtitle: Text(
                          'Idade: ' + (DateTime.now().difference(DateTime.parse(_cliente.get('dataNascimento').toDate().toString())).inDays / 365 ).truncate().toString() + ' anos' + '\n' +
                          'Profissão: ' + _cliente.get('profissao')
                        ),
                      ),
                    ],
                  ),
                )
              )
            ],
          ),
        ),
      ),
    );
  }
  
}