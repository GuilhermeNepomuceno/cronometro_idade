import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TempoDeVida extends StatefulWidget {
  @override
  _TempoDeVidaState createState() => _TempoDeVidaState();
}

class _TempoDeVidaState extends State<TempoDeVida> {
  final _controle = TextEditingController();
  DateTime _dataAtual = DateTime.now();
  DateTime _dataPicker;
  Duration _dataTxt;
  Map<String, int> _idade = {
    'anos': 0,
    'meses': 0,
    'dias': 0,
    'horas': 0,
    'minutos': 0,
    'segundos': 0
  };

  void limpar() {
    _controle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Idade'),
        ),
        body: Center(
            child: Container(
                padding: EdgeInsets.all(20),
                //margin: EdgeInsets.all(10),
                width: 300.0,
                child: Form(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        //key: _inData,
                        controller: _controle,
                        readOnly: true,
                        onTap: () => calendario(context),
                        decoration:
                            InputDecoration(labelText: 'Data de Nascimento'),

                        //initialValue: 'teste',
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 30, bottom: 15),
                        child: Text(
                            'Data atual: ${DateFormat('d/M/y').format(_dataAtual)}'),
                      ),
                      RaisedButton(
                        onPressed: () => calendario(context),
                        child: Text('Calendario'),
                      ),
                      Container(
                          //child: Text(_dataTxt),
                          ),
                      Container(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text('${_idade['anos'] ?? ''} Ano(s)'),
                                Text('${_idade['meses'] ?? ''} Mês(es)'),
                                Text('${_idade['dias'] ?? ''} Dia(s)'),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [Text('H:'), Text('M: '), Text('S: ')],
                            ),
                          ],
                        ),
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
    _dataPicker = await showDatePicker(
        context: context,
        initialDate: _dataPicker == null ? DateTime.now() : _dataPicker,
        firstDate: DateTime(1920),
        lastDate: DateTime.now());

    _controle.text = DateFormat('d/M/y').format(_dataPicker);

    _dataTxt = DateTime.now().difference(_dataPicker);

    calcularDiferenca(_dataTxt);
  }

  void calcularDiferenca(Duration diferencaIdade) {
    print(diferencaIdade);
    print(diferencaIdade.inDays);
    _idade['anos'] = _dataAtual.year - _dataPicker.year;
    _dataPicker.month > _dataAtual.month
        ? {_idade['meses'] = _dataAtual.month, _idade['anos'] -= 1}
        : _idade['meses'] = (_dataAtual.month - _dataPicker.month);
    _dataPicker.day > _dataAtual.day
        ? _idade['dias'] = _dataAtual.day
        : _idade['dias'] = _dataAtual.day - _dataPicker.day;

    setState(() {});
  }
}
