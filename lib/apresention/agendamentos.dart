import 'package:flutter/material.dart';
import 'package:prontuario/apresention/atendimento.dart';
import 'package:prontuario/apresention/home.dart';
import 'package:prontuario/control/agendamento_controller.dart';
import 'package:prontuario/control/data_manipulation.dart';

class Agendamento extends StatefulWidget{
  /*List agenda = [];
  Agendamento({Key? key}) : super(key: key) async {
    await AgendamentoController().buscaAgendamentos().then((value) {
      agenda = value;
    });
  }*/

  @override
  State<Agendamento> createState() => _AgendamentoState();
}

class _AgendamentoState extends State<Agendamento> {
  var _agendados = [];
  //var _escolha;

  @override
  Widget build(BuildContext context) {
    var then = AgendamentoController().buscaAgendamentos().then((value) {
      setState(() {
        _agendados = value;
      });
    });
    /*setState(() {
      _agendados = widget.agenda;
    });*/
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prontuário - Agendamentos'),
        actions: [
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
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child:
          Column(
            children:[
              ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: _agendados.length,//(widget.agenda != null) ? (widget.agenda.length) : (0),
                itemBuilder: (context, index) {
                  if (_agendados[index] != null){
                    return Card(
                      child: ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(_agendados[index].clienteNome.toString()),

                          ],
                        ),
                        subtitle: Text(Data.mostraData(_agendados[index].dia) + ' ' + Data.mostraHora(_agendados[index].hora)),
                        onTap: () {
                          MaterialPageRoute(
                            builder: (context) => Atendimento(_agendados[index].clienteId),
                          );
                        }
                      )
                    );
                  }
                  return const /*SizedBox(
                    height: 0,
                    width: 0,
                  )*/Text('nope');
                }
              ),
          ],
        ),
        )
      ),
    );
  }
}