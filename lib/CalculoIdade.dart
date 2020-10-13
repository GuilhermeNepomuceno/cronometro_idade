import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalculoIdade extends StatefulWidget {
  @override
  _CalculoIdadeState createState() => _CalculoIdadeState();
}

class _CalculoIdadeState extends State<CalculoIdade> {
  final _inData = GlobalKey<FormFieldState>();
  final _formKey = GlobalKey<FormState>();
  final _scaKey = GlobalKey<ScaffoldState>();
  final _controle = TextEditingController();
  var _dataAtual = new DateFormat('d/M/y').format(new DateTime.now());
  DateTime _dta;
  String _dataTxt = '';

  void limpar() {
    _controle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        key: _scaKey,
        appBar: AppBar(
          title: Text('Idade'),
        ),
        body: Center(
            child: Container(
                padding: EdgeInsets.all(20),
                //margin: EdgeInsets.all(10),
                width: 300.0,
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        //key: _inData,
                        controller: _controle,
                        readOnly: true,
                        onTap: () => calendario(context),
                        decoration: InputDecoration(
                            //hintText: 'Data de Nascimento',
                            labelText: 'Data de Nascimento'),

                        //initialValue: 'teste',
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 30, bottom: 15),
                        child: Text('Data atual: $_dataAtual'),
                      ),
                      RaisedButton(
                        onPressed: () => calendario(context),
                        child: Text('Calendario'),
                      ),
                      Container(
                        child: Text(_dataTxt),
                      )
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.grey[500]))),
      ),
    );
  }

  Future calendario(context) async {
    _dta = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1920),
        lastDate: DateTime.now());
    _controle.text = _dta.toString();
    print(_controle.text);
    //_inData.currentState.setValue(dta.year.toString());
    print(_inData.currentState.value);
    calculoIdade();
    //print(dta.toLocal());
  }

  void calculoIdade() {
    setState(() {
      _dataTxt = _dta.difference(new DateTime.now()).toString();
    });
  }
}
