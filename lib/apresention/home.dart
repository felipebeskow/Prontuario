import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:prontuario/apresention/agendamentos.dart';
import 'package:prontuario/apresention/atendimento.dart';
import 'package:prontuario/apresention/cadastro_cliente.dart';
import '../control/global.dart' as global;

class HomePage extends StatefulWidget{
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}



class _HomePageState extends State<HomePage> {
  List _clientes = [];

  void setClientes(clientes){
    setState(() {
      _clientes = clientes;
    });
  }

  buscaClientes(String valor) async {
    valor = valor.toUpperCase();
    try{
      if (valor.isNotEmpty) {
        await _clientesFirecloud.where(
          'nome',
          isGreaterThanOrEqualTo: valor,
          isLessThan: valor.substring(0, valor.length - 1) +
          String.fromCharCode(valor.codeUnitAt(valor.length - 1) + 1),
        ).get().then((value) => setClientes(value.docs));
      } else {
        setClientes([]);
      }
    } catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Erro ao buscar usuário ${valor}'),
      duration: const Duration(seconds: 1),
      ),);
    }
  }

  String _busca = '';
  var _escolha;

  final CollectionReference _clientesFirecloud = FirebaseFirestore.instance.collection('clientes');

  @override
  Widget build(BuildContext context) {
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
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Buscar clientes:'),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Digite aqui para buscar por clientes',
                ),
                onEditingComplete: () {
                  buscaClientes(_busca);
                },
                onChanged: (value) {
                  _busca = value;
                },
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _clientes.length,
                  itemBuilder: (context, index) {
                    if (_clientes[index] != null){
                      return Card(
                        child: ListTile(
                          trailing: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => const Agendamento(),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.remove_red_eye)
                              ),
                            ],
                          ),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Radio<dynamic>(
                                value: _clientes[index],
                                groupValue: _escolha,
                                onChanged: (value) {
                                  setState(() {
                                    _escolha = value;
                                  });
                                },
                              ),
                              Text(_clientes[index].get('nome')),
                            ],
                          ),
                        )
                      );
                    }
                    return const SizedBox(
                      height: 0,
                      width: 0,
                    );
                  }
                )
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: (_escolha == null) ? null : (){
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const Agendamento(),
                        ),
                      );
                    },
                    child: const Text("Agendar"),
                  ),
                  const SizedBox(
                    width: 50.0,
                  ),
                  ElevatedButton(
                    onPressed: (_escolha == null) ? null : () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Atendimento(_escolha),
                        ),
                      );
                    },
                    child: const Text("Atender"),
                  ),
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
            ],
          ),
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