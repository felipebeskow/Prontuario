import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prontuario/apresention/agendamentos.dart';
import 'package:prontuario/apresention/home.dart';
import 'package:prontuario/control/data_manipulation.dart';
import 'package:prontuario/control/terapia_controller.dart';

class Atendimento extends StatefulWidget{
  var _cliente;

  Atendimento(cliente):super(){
    _cliente = cliente;
  }

  @override
  State<Atendimento> createState() => _AtendimentoState();
}

class _AtendimentoState extends State<Atendimento> {
  final TerapiaController _controller = TerapiaController();
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
                            initialValue: Data.mostraData(_controller.data),
                          ),
                          const SizedBox(height: 10.0,),
                          const Text('Terapia'),
                          DropdownButton(
                            hint: const Text('Escolha um tipo de terapia'), // Not necessary for Option 1
                            value: _controller.terapia,
                            onChanged: (newValue) {
                              setState(() {
                                _controller.terapia = newValue;
                              });
                            },
                            items: ['Acupuntura','Iridofoto','Reflexoterapia','Localizada'].map((value) {
                              return DropdownMenuItem(
                                child: Text(value),
                                value: value,
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 10.0,),
                          const Text('Atendimento'),
                          TextFormField(
                            decoration: const InputDecoration(
                              hintText: 'Descreva como foi o atendimento',
                            ),
                            validator: (String? value){
                              if (value == null || value.isEmpty) {
                                return 'Por favor, insira a descrição do atendimento';
                              }
                              return null;
                            },
                            initialValue: (_controller.populado) ? _controller.atendimento : null,
                            onChanged: (value){
                              _controller.atendimento = value;
                            },
                            minLines: 5,
                            maxLines: 15,
                          ),
                          const SizedBox(height: 10.0,),
                          const Text('Recomendações'),
                          TextFormField(
                            decoration: const InputDecoration(
                              hintText: 'Descreva quais são as recomendações',
                            ),
                            initialValue: (_controller.populado) ? _controller.recomendacoes : null,
                            onChanged: (value){
                              _controller.recomendacoes = value;
                            },
                            minLines: 3,
                            maxLines: 15,
                          ),
                          const SizedBox(height: 10.0,),
                          const Text('Anexos (Futura Feature)'),
                          const SizedBox(height: 30.0,),
                          Center(
                            child: ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate() && _controller.terapia != null) {
                                  String _message;
                                  _message = await _controller.save();
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                      content: (_message == 'Sucesso') ? const Text('Atendimento salvo com sucesso!') : Text(_message)
                                  ),);
                                  if (_message == 'Sucesso') {
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                          builder: (context) => HomePage(),
                                        ),
                                            (Route<dynamic> route) => route is HomePage
                                    );
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                      content: Text('Preencha corretamente todos os campos')
                                  ),);
                                }
                              },
                              child: const Text("Salvar"),
                            ),
                          ),
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