import 'package:cloud_firestore/cloud_firestore.dart';

class ClientesController {

  ClientesController(){
    populado = true;
  }

  var _nome;
  var _profisao;
  var _telefone;
  DateTime _dataNascimento = DateTime.now();
  var _endereco;
  var _obeservacoes;
  bool _populado = false;

  get populado => _populado;

  set populado(populado) {
    _populado = populado;
  }

  get nome => _nome;

  set nome(nome) {
    _nome = nome;
  }

  get profisao => _profisao;

  set profisao(profisao) {
    _profisao = profisao;
  }

  get telefone => _telefone;

  set telefone(telefone) {
    _telefone = telefone;
  }

  get dataNascimento => _dataNascimento;

  set dataNascimento(dataNascimento) {
    _dataNascimento = dataNascimento;
  }

  get endereco => _endereco;

  set endereco(endereco) {
    _endereco = endereco;
  }

  get obeservacoes => _obeservacoes;

  set obeservacoes(obeservacoes) {
    _obeservacoes = obeservacoes;
  }

  String toText(){
    return 'Nome: ' + _nome +
      '\nProfissão: ' + _profisao +
      '\nTelefone: ' + _telefone +
      '\nData de nascimento: ' + _dataNascimento.toString() +
      '\nEndereço: ' + _endereco +
      '\nObservações: ' + _obeservacoes;
  }

  Future<String> save() async {
    CollectionReference cliente = FirebaseFirestore.instance.collection('clientes');

    return cliente.add({
      'nome': _nome,
      'profissao': _profisao,
      'telefone': _telefone,
      'endereco': _endereco,
      'dataNascimento': _dataNascimento,
      'observacao': _obeservacoes,
      'creationAt': DateTime.now()
    }).then((value){
      return 'Sucesso';
    })
    .catchError((error){
      return error;
    });

  }

}