import 'dart:async';

import 'package:flutter/material.dart';
import 'CalculoIdade.dart';

void main() {
  //runApp(MyApp());
  runApp(MyHomePage());
}

/*class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlutterLogo();
  }
}*/

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  String contagem = '0';
  static const segundos = const Duration(microseconds: 1);
  var crono = new Stopwatch();
  var temporizador;
  var icone = Icon(Icons.play_arrow);
  Color btnStartCor = Colors.blue;
  var min = 0;
  var seg = 0;
  var hora = 0;

  void btnStart() {
    crono.start();
    icone = Icon(Icons.stop);
    btnStartCor = Colors.red;
    seg = crono.elapsed.inSeconds;
    contagem = crono.elapsed.inMilliseconds.toString();

    temporizador = new Timer.periodic(segundos, (t) {
      seg = crono.elapsed.inSeconds;
      if (seg > 59) {
        crono.reset();
        min++;
        if (min > 59) {
          min = 0;
          hora++;
        }
      }
      setState(() {
        contagem = crono.elapsed.inMilliseconds.toString();
      });
    });
    atualizarBotao(Icon(Icons.stop), Colors.red);
  }

  void atualizarBotao(Icon i, Color c) {
    setState(() {
      btnStartCor = c;
      icone = i;
    });
  }

  void btnStop() {
    crono.stop();
    atualizarBotao(Icon(Icons.play_arrow), Colors.blue);
  }

  void btnReset() {
    hora = min = seg = 0;
    crono.reset();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cronometro',
      home: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.cyan[700],
            title: Text('Cronometro'),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  margin: const EdgeInsets.all(5.0),
                  padding: EdgeInsets.all(15.0),
                  //color: Colors.grey[200],
                  //height: 48.0,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            child: Column(
                              children: [
                                Text(
                                  '$hora',
                                  textScaleFactor: 2.5,
                                ),
                                Divider(
                                  thickness: 5.0,
                                  color: Colors.grey[200],
                                  indent: 5.0,
                                ),
                                Text('Hora')
                              ],
                              mainAxisAlignment: MainAxisAlignment.center,
                            ),
                            width: 60,
                            height: 90,
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6.0)),
                          ),
                          Container(
                            child: Column(
                              children: [
                                Text(
                                  '$min',
                                  textScaleFactor: 2.5,
                                ),
                                Divider(
                                  thickness: 5.0,
                                  color: Colors.grey[200],
                                ),
                                Text('Min')
                              ],
                              mainAxisAlignment: MainAxisAlignment.center,
                            ),
                            width: 60,
                            height: 90,
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6.0)),
                          ),
                          Container(
                            child: Column(
                              children: [
                                Text(
                                  crono.elapsed.inSeconds.toString(),
                                  textScaleFactor: 2.5,
                                ),
                                Divider(
                                  thickness: 5.0,
                                  color: Colors.grey[200],
                                  endIndent: 5.0,
                                ),
                                Text('Seg')
                              ],
                              mainAxisAlignment: MainAxisAlignment.center,
                            ),
                            width: 60,
                            height: 90,
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6.0)),
                          ),
                        ],
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                  ),
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(60)),
                ),
              ),
              Row(
                children: [Text(contagem + ' ms')],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CalculoIdade()));
                },
                child: Icon(Icons.navigate_next),
              )
            ],
          ),
          bottomNavigationBar: BottomAppBar(
            child: Container(
              color: Colors.cyan[600],
              height: 40,
            ),
          ),
          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FloatingActionButton(
                heroTag: 'btStartStop',
                onPressed: crono.isRunning ? btnStop : btnStart,
                child: icone,
                backgroundColor: btnStartCor,
                //backgroundColor: Color(200),
              ),
              FloatingActionButton(
                heroTag: 'btReset',
                onPressed: btnReset,
                child: Icon(Icons.restore),
                backgroundColor: Colors.yellow[600],
              ),
            ],
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        ),
      ),
    );
  }
}
