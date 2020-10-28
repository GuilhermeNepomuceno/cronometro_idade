import 'package:cronometro/classes/individuo.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TempoDeVida extends StatefulWidget {
  @override
  _TempoDeVidaState createState() => _TempoDeVidaState();
}

class _TempoDeVidaState extends State<TempoDeVida> {
  Individuo pessoa = Individuo();
  final _controleData = TextEditingController();
  final _controleHora = TextEditingController();
  DateTime _dataAtual = DateTime.now();

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
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: Column(
                          children: [
                            ListTile(
                              leading: IconButton(
                                  icon: Icon(Icons.calendar_today),
                                  onPressed: () async {
                                    pessoa.setDataNascimento =
                                        await setDataNascimento(
                                            context, pessoa.getDataNascimento);
                                    _controleData.text =
                                        formatData(pessoa.getDataNascimento);
                                  }),
                              title: TextFormField(
                                //key: _inData,
                                controller: _controleData,
                                readOnly: true,
                                onTap: () async {
                                  pessoa.setDataNascimento =
                                      await setDataNascimento(
                                          context, pessoa.getDataNascimento);
                                  _controleData.text =
                                      formatData(pessoa.getDataNascimento);
                                },
                                decoration: InputDecoration(
                                    labelText: 'Data de Nascimento'),

                                //initialValue: 'teste',
                              ),
                            ),
                            ListTile(
                              leading: IconButton(
                                  icon: Icon(Icons.access_time),
                                  onPressed: () async {
                                    pessoa.setHoraNascimento =
                                        await setHoraNascimento(
                                            context, pessoa.getHoraNascimento);
                                    _controleHora.text =
                                        formatHora(pessoa.getHoraNascimento);
                                  }),
                              title: TextFormField(
                                controller: _controleHora,
                                readOnly: true,
                                onTap: () async {
                                  pessoa.setHoraNascimento =
                                      await setHoraNascimento(
                                          context, pessoa.getHoraNascimento);
                                  _controleHora.text =
                                      formatHora(pessoa.getHoraNascimento);
                                },
                                decoration:
                                    InputDecoration(labelText: 'Horário'),

                                //initialValue: 'teste',
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: RaisedButton(
                          onPressed: () {
                            if ((pessoa.getDataNascimento != null) |
                                (pessoa.getHoraNascimento != null)) {
                              calcularSpanTempo(pessoa);
                              setState(() {});
                            } else {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text('Dados insuficientes'),
                                  content: Text('Informar Data ou Horário'),
                                  actions: [
                                    FlatButton(
                                        onPressed: () {},
                                        child: Text('Entendido'))
                                  ],
                                ),
                              );
                            }
                          },
                          child: Text('Calcular Idade'),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 15, bottom: 25),
                        child: Text(
                            'Data atual: ${DateFormat('d/M/y').format(_dataAtual)}'),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Idade:',
                                  style: TextStyle(fontSize: 20),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text('${pessoa.getIdade.getAno ?? '0'} Ano(s)'),
                                Text(
                                    '${pessoa.getIdade.getMes ?? '0'} Mês(es)'),
                                Text('${pessoa.getIdade.getDia ?? '0'} Dia(s)'),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                    '${pessoa.getIdade.getHorasDeVida ?? '0'} Horas'),
                                Text(
                                    '${pessoa.getIdade.getMinutosDeVida ?? '0'} Minutos'),
                              ],
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

  Future<TimeOfDay> setHoraNascimento(context, TimeOfDay horaNascimento) async {
    if (horaNascimento != null) {
      horaNascimento = await relogio(context, horaNascimento);
    } else {
      horaNascimento = await relogio(context);
    }
    return horaNascimento;
  }

  String formatHora(TimeOfDay hora) {
    String horaFormatada = '${hora.hour}:${hora.minute}';
    return horaFormatada;
  }

  Future<DateTime> setDataNascimento(context, DateTime dataNascimento) async {
    if (dataNascimento != null) {
      dataNascimento = await calendario(context, dataNascimento);
    } else {
      dataNascimento = await calendario(context);
    }
    return dataNascimento;
  }

  String formatData(DateTime data) {
    String dataFormatada = DateFormat('d/M/y').format(data);
    return dataFormatada;
  }
}

bool calcularHora(Individuo pessoa) {
  bool diaCompleto = pessoa.getIdade.calcularHora(pessoa.getHoraNascimento);

  return diaCompleto;
}

void calcularIdade(Individuo pessoa, bool diaCompleto) {
  pessoa.getIdade.calcularIdade(pessoa.getDataNascimento, diaCompleto);
}

Future<DateTime> calendario(context, [DateTime dataInicial]) async {
  DateTime dataNascimento = await showDatePicker(
      context: context,
      initialDate: dataInicial ?? DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 90),
      lastDate: DateTime.now());
  return dataNascimento;
}

Future<TimeOfDay> relogio(context, [TimeOfDay horaInicial]) async {
  TimeOfDay horaNascimento = await showTimePicker(
    initialTime: horaInicial ?? TimeOfDay.now(),
    context: context,
  );
  return horaNascimento;
}

void calcularSpanTempo(Individuo pessoa) {
  bool diaCompleto = calcularHora(pessoa);
  calcularIdade(pessoa, diaCompleto);
}
