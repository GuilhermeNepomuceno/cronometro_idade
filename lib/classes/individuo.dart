import 'package:flutter/material.dart';
import 'idade.dart';

class Individuo {
  DateTime _dataNascimento;
  TimeOfDay _horaNascimento;
  Idade _idade;

  Individuo() {
    _idade = Idade();
  }

  set setDataNascimento(DateTime dataN) {
    _dataNascimento = dataN;
  }

  set setHoraNascimento(TimeOfDay horaN) {
    _horaNascimento = horaN;
  }

  set setIdade(Idade idade) {
    this._idade = idade;
  }

  DateTime get getDataNascimento {
    return _dataNascimento;
  }

  TimeOfDay get getHoraNascimento {
    return _horaNascimento;
  }

  Idade get getIdade {
    return _idade;
  }
}
