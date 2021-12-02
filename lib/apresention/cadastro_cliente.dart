import 'package:flutter/material.dart';
import 'package:prontuario/apresention/agendamentos.dart';
import 'package:prontuario/apresention/home.dart';
import 'package:prontuario/control/clientes_controller.dart';
import 'package:prontuario/control/data_manipulation.dart';

class CadastroCliente extends StatefulWidget{
  const CadastroCliente({Key? key}) : super(key: key);

  @override
  State<CadastroCliente> createState() => _CadastroClienteState();
}

class _CadastroClienteState extends State<CadastroCliente> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ClientesController _clientes = ClientesController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: true,
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
          child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Nome Completo:'),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Insira o nome completo do cliente',
                    ),
                    validator: (String? value){
                      if (value == null || value.isEmpty) {
                        return 'Por favor insira o nome';
                      }
                      return null;
                    },
                    initialValue: (_clientes.populado) ? _clientes.nome : null,
                    onChanged: (value){
                      _clientes.nome = value.toUpperCase();
                    },
                  ),
                  const SizedBox(height: 30.0,),
                  const Text('Profissão:'),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Insira a profissão do cliente',
                    ),
                    validator: (String? value){
                      if (value == null || value.isEmpty) {
                        return 'Por favor insira a profissão';
                      }
                      return null;
                    },
                    initialValue: (_clientes.populado) ? _clientes.profisao : null,
                    onChanged: (value){
                      _clientes.profisao = value;
                    },
                  ),
                  const SizedBox(height: 30.0,),
                  const Text('Data de Nascimento:'),
                  TextButton(
                    style: TextButton.styleFrom(
                      primary: (_clientes.validaDataNascimento()) ? (Colors.black87) :(Colors.black54),
                      ),
                    onPressed: (){
                      Future<DateTime?> selecionaData = showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                        builder: (BuildContext context, Widget? child){
                          return Theme(
                            data: ThemeData.dark(),
                            child: (child != null) ? child : Text(''),
                          );
                        },
                      ).then((value) {
                        setState(() {
                          _clientes.dataNascimento = value;
                        });
                      });
                    },
                    child: (_clientes.validaDataNascimento()) ? Text(Data.mostraData(_clientes.dataNascimento)) : const Text('Insira a data de nascimento')
                  ),
                  const SizedBox(height: 30.0,),
                  const Text('Telefone:'),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      hintText: 'Insira o telefone do cliente',
                    ),
                    validator: (String? value){
                      if ((value == null || value.isEmpty ) && value!.length < 8) {
                        return 'Por favor insira o telefone';
                      }
                      return null;
                    },
                    initialValue: (_clientes.populado) ? _clientes.telefone : null,
                    onChanged: (value){
                      _clientes.telefone = value;
                    },
                  ),
                  const SizedBox(height: 30.0,),
                  const Text('Endereço:'),
                  TextFormField(
                      keyboardType: TextInputType.streetAddress,
                      minLines: 2,
                      maxLines: 5,
                      decoration: const InputDecoration(
                        hintText: 'Insira o endereço do cliente',
                      ),
                      initialValue: (_clientes.populado) ? _clientes.endereco : null,
                    onChanged: (value){
                      _clientes.endereco = value;
                    },
                  ),
                  const SizedBox(height: 30.0,),
                  const Text('Observações:'),
                  TextFormField(
                    minLines: 3,
                    maxLines: 15,
                    decoration: const InputDecoration(
                      hintText: 'Insira o observações do cliente',
                    ),
                    initialValue: (_clientes.populado) ? _clientes.obeservacoes : null,
                    onChanged: (value){
                      _clientes.obeservacoes = value;
                    },
                  ),
                  const SizedBox(height: 50.0,),
                  Center(
                      child:
                      ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate() && _clientes.validaDataNascimento()) {
                              String _message;
                              _message = await _clientes.save();
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: (_message == 'Sucesso') ? const Text('Cliente salvo com sucesso!') : Text(_message)
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
                      )
                  ),
                ],
              )
          ),
        ),
      )
    );
  }
}