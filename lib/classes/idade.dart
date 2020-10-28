import 'package:flutter/material.dart';

class Idade {
  int _ano;
  int _mes;
  int _dia;
  int _horasVida;
  int _minutosVida;

  set setAno(int year) {
    _ano = year;
  }

  set setMes(int month) {
    _mes = month;
  }

  set setDia(int day) {
    _dia = day;
  }

  set setHoras(int hours) {
    _horasVida = hours;
  }

  set setMinutos(int minutes) {
    _minutosVida = minutes;
  }

  int get getAno {
    return _ano;
  }

  int get getMes {
    return _mes;
  }

  int get getDia {
    return _dia;
  }

  int get getHorasDeVida {
    return _horasVida;
  }

  int get getMinutosDeVida {
    return _minutosVida;
  }

  bool calcularHora(TimeOfDay horaNascimento) {
    TimeOfDay horaAtual = TimeOfDay.now();
    if (horaNascimento == null) {
      horaNascimento = horaAtual;
    }

    int horaFinal = horaAtual.hour;
    int horaInicial = horaNascimento.hour;
    int minutoFinal = horaAtual.minute;
    int minutoInicial = horaNascimento.minute;
    bool diaCompleto = true; //indica se completou 1 dia desde o nascimento
    if ((horaFinal < horaInicial) & (minutoFinal > minutoInicial)) {
      diaCompleto = false;
    } else if ((horaFinal <= horaInicial) & (minutoFinal < minutoInicial))
      diaCompleto = false;

    _horasVida =
        (horaFinal + ((horaFinal >= horaInicial ? 0 : 23) - horaInicial));
    _minutosVida =
        minutoFinal + ((minutoFinal >= minutoInicial ? 0 : 60) - minutoInicial);

    print(_horasVida);
    print(_minutosVida);
    print(diaCompleto);
    return diaCompleto;
  }

  void calcularIdade(DateTime dataNascimento, bool diaCompleto) {
    DateTime dataAtual = DateTime.now();
    if (dataNascimento == null) {
      dataNascimento = dataAtual;
    }
    _ano = dataAtual.year - dataNascimento.year;

    dataNascimento.month > dataAtual.month
        ? {_mes = dataAtual.month, _ano -= 1}
        : _mes = (dataAtual.month - dataNascimento.month);

    dataNascimento.day > dataAtual.day
        ? _dia = dataAtual.day
        : _dia = dataAtual.day - dataNascimento.day + (diaCompleto ? 0 : -1);
  }
}
