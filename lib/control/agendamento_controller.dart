import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AgendamentoController {

  popula(String clienteId, String clienteNome, Timestamp data){
    var _agendamento = AgendamentoController();
    _clienteId = clienteId;
    _clienteNome = clienteNome;
    _dia = data.toDate();
    _hora = TimeOfDay.fromDateTime(data.toDate());
    return _agendamento;
  }

  populaByData(Map<String, dynamic> dados){
    _clienteId = dados['clienteId'].toString();
    _dia = dados['data'].toDate();
    _hora = TimeOfDay.fromDateTime(dados['data'].toDate());
  }

  var _dia;

  get dia => _dia;

  set dia(dia) {
    _dia = dia;
  }

  bool validaDia(){
    return (_dia != null);
  }

  var _hora;

  get hora => _hora;

  set hora(hora) {
    _hora = hora;
  }

  bool validaHora(){
    return (_hora != null);
  }

  var _clienteId;

  get clienteId => _clienteId;

  set clienteId(clienteId) {
    _clienteId = clienteId;
  }

  var _clienteNome;

  get clienteNome => _clienteNome;

  set clienteNome(clienteNome) {
    _clienteNome = clienteNome;
  }

  save() {
    CollectionReference agendamneto = FirebaseFirestore.instance.collection('agendamentos');

    return agendamneto.add({
      'clienteId': clienteId,
      'data': DateTime(dia.year, dia.month, dia.day, hora.hour, hora.minute),
      'creationAt': DateTime.now()
    }).then((value){
      return 'Sucesso';
    }).catchError((error){
      return error;
    });
  }

  Future<List> buscaAgendamentos() async {
    final List<QueryDocumentSnapshot<Map<String, dynamic>>> _agendamentos = (await FirebaseFirestore.instance.collection('agendamentos').where(
        'data',
        isGreaterThan: DateTime.now()
    ).get()).docs.toList();
    final List<QueryDocumentSnapshot<Map<String, dynamic>>> _cliente = (await FirebaseFirestore.instance.collection('clientes').get()).docs.toList();

    List<AgendamentoController> agendados = [];

    _agendamentos.forEach((QueryDocumentSnapshot<Map<String, dynamic>> element) {
      AgendamentoController _agendamento = AgendamentoController();
      _agendamento.populaByData(element.data()); //mapear os dados
      Map<String, dynamic> cliente = (_cliente.firstWhere((element) {
        return element.id.toString()==_agendamento.clienteId;
      })).data();
      _agendamento.clienteNome = cliente['nome'].toString();
      agendados.add(_agendamento);
    });

    return agendados.toList();
  }

}