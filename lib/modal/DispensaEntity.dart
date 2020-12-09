

import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DispensaEntity{

  final String key_EAN;
  final String nome;
  final String categoria;

  DispensaEntity(this.key_EAN, this.nome, this.categoria);

  Map<String, dynamic> toMap() {
    return {
      'key_EAN': key_EAN,
      'nome': nome,
      'categoria': categoria,
    };
  }

  @override
  String toString() {
    return 'DispensaEntity{key_EAN: $key_EAN, nome: $nome, categoria: $categoria}';
  }

}