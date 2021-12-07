import 'package:cloud_firestore/cloud_firestore.dart';

class AgendamentoController {

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

}