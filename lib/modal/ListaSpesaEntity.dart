class ListaSpesaEntity{

  final String key_EAN;
  final String nome;

  ListaSpesaEntity(this.key_EAN, this.nome);

  Map<String, dynamic> toMap() {
    return {
      'key_EAN': key_EAN,
      'nome': nome,
    };
  }

  @override
  String toString() {
    return 'DispensaEntity{key_EAN: $key_EAN, nome: $nome}';
  }
}