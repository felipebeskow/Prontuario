import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prontuario/apresention/agendamentos.dart';
import 'package:prontuario/apresention/home.dart';

import 'package:intl/intl.dart';

class Atendimento extends StatefulWidget{
  var _cliente;

  Atendimento(cliente):super(){
    _cliente = cliente;
  }

  @override
  State<Atendimento> createState() => _AtendimentoState();
}

class _AtendimentoState extends State<Atendimento> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    print(widget._cliente.id);
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
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Card(
                      child: ListTile(
                        title: Text('Cliente: ' + widget._cliente.get('nome')),
                        subtitle: Text(
                          'Idade: ' + (DateTime.now().difference(DateTime.parse(widget._cliente.get('dataNascimento').toDate().toString())).inDays / 365 ).truncate().toString() + ' anos' + '\n' +
                          'Profissão: ' + widget._cliente.get('profissao')
                        ),
                      ),
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 30.0,),
                          const Text('Data do Atendimento'),
                          TextFormField(
                            enabled: false,
                            initialValue: ((DateTime.now().day<10) ? ('0' + DateTime.now().day.toString()) : (DateTime.now().day.toString())) + '/' +
                                ((DateTime.now().month<10) ? ('0' + DateTime.now().month.toString()) : (DateTime.now().month.toString()))
                                + '/' + DateTime.now().year.toString(),
                          ),
                          const SizedBox(height: 30.0,),
                          const Text(''),
                        ],
                      ),
                    ),
                    ],
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}