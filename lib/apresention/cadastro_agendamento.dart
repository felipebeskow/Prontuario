import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prontuario/apresention/agendamentos.dart';
import 'package:prontuario/apresention/home.dart';
import 'package:prontuario/control/agendamento_controller.dart';
import 'package:prontuario/control/data_manipulation.dart';

class CadastroAgendamento extends StatefulWidget{
  var _cliente;

  CadastroAgendamento(cliente):super(){
    _cliente = cliente;
  }

  @override
  State<CadastroAgendamento> createState() => _CadastroAgendamentoState();
}

class _CadastroAgendamentoState extends State<CadastroAgendamento> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AgendamentoController _agendamentoController = AgendamentoController();


  @override
  Widget build(BuildContext context) {

    setState((){
      _agendamentoController.clienteId = widget._cliente.id;
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Agendamento'),
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
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
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
                  children: [
                    const SizedBox(height: 30.0,),
                    const Text('Dia do agendamento:'),
                    TextButton(
                      style: TextButton.styleFrom(
                        primary: (_agendamentoController.validaDia()) ? (Colors.black87) :(Colors.black54),
                      ),
                      onPressed: (){
                        Future<DateTime?> selecionaData = showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2050),
                          builder: (BuildContext context, Widget? child){
                            return Theme(
                              data: ThemeData.dark(),
                              child: (child != null) ? child : Text(''),
                            );
                          },
                        ).then((value) {
                          setState(() {
                            _agendamentoController.dia = value;
                          });
                        });
                      },
                      child: (_agendamentoController.validaDia()) ? Text(Data.mostraData(_agendamentoController.dia)) : const Text('Insira o dia do agendamento')
                    ),
                    const SizedBox(height: 30.0,),
                    const Text('Hora do agendamento:'),
                    TextButton(
                      style: TextButton.styleFrom(
                        primary: (_agendamentoController.validaDia()) ? (Colors.black87) :(Colors.black54),
                      ),
                      onPressed: (){
                        Future selecionaHora = showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                          builder: (BuildContext context, Widget? child){
                            return Theme(
                              data: ThemeData.dark(),
                              child: (child != null) ? child : Text(''),
                            );
                          },
                        ).then((value) {
                          setState(() {
                            _agendamentoController.hora = value;
                          });
                        });
                      },
                      child: (_agendamentoController.validaHora()) ? Text(Data.mostraHora(_agendamentoController.hora)) : const Text('Insira a hora do agendamento'),
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          if (_agendamentoController.validaDia() && _agendamentoController.validaHora()){
                            String _message;
                            _message = await _agendamentoController.save();
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: (_message == 'Sucesso') ? const Text('Cliente agendado com sucesso!') : Text(_message)
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
                        child: const Text('Salvar')
                    )
                  ],
                )
              )
            ],
          )
        ),
      )
    );
  }
}