import 'package:flutter/material.dart';

class Prodotto {

  String _nome, _categoria;


  Prodotto(this._nome, this._categoria);

  String get nome => _nome;

  set nome(String value) {
    _nome = value;
  }

  get categoria => _categoria;

  set categoria(value) {
    _categoria = value;
  }

  @override
  String toString() {
    return 'Prodotto{_nome: $_nome, _categoria: $_categoria}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Prodotto &&
          runtimeType == other.runtimeType &&
          _nome == other._nome &&
          _categoria == other._categoria;

  @override
  int get hashCode => _nome.hashCode ^ _categoria.hashCode;
}

