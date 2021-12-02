import 'package:cloud_firestore/cloud_firestore.dart';

class TerapiaController{

  TerapiaController(){
    populado = false;
    data = DateTime.now();
  }

  bool _populado = false;
  var _data;
  var _terapia;
  var _atendimento;
  var _recomendacoes;
  List _arquivos = [];

  get data => _data;

  set data(data) {
    _data = data;
  }

  get terapia => _terapia;

  set terapia(terapia) {
    _terapia = terapia;
  }

  get atendimento => _atendimento;

  set atendimento(atendimento) {
    _atendimento = atendimento;
  }

  get recomendacoes => _recomendacoes;

  set recomendacoes(recomendacoes) {
    _recomendacoes = recomendacoes;
  }

  List get arquivos => _arquivos;

  set arquivos(List arquivos) {
    _arquivos = arquivos;
  }

  bool get populado => _populado;

  set populado(bool populado) {
    _populado = populado;
  }

  Future<String> save() async {
    CollectionReference atendimento = FirebaseFirestore.instance.collection('atendimentos');

    return atendimento.add({
      'data': _data,
      'terapia': _terapia,
      'atendimento': _atendimento,
      'recomendacoes': _recomendacoes,
      'arquivos': _arquivos,
      'creationAt': DateTime.now()
    }).then((value){
      return 'Sucesso';
    }).catchError((error){
      return error;
    });

  }

}