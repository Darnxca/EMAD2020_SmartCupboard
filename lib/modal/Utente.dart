class Utente{

  String _nome,_cognome,_email,_id;

  Utente(this._nome, this._cognome, this._email,this._id);

  get email => _email;

  set email(value) {
    _email = value;
  }

  get cognome => _cognome;

  set cognome(value) {
    _cognome = value;
  }

  String get nome => _nome;

  set nome(String value) {
    _nome = value;
  }

  get id => _id;

  set id(value) {
    _id = value;
  }

  @override
  String toString() {
    return 'Utente{_nome: $_nome, _cognome: $_cognome, _email: $_email, _id: $_id}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Utente &&
          runtimeType == other.runtimeType &&
          _nome == other._nome &&
          _cognome == other._cognome &&
          _email == other._email &&
          _id == other._id;

  @override
  int get hashCode =>
      _nome.hashCode ^ _cognome.hashCode ^ _email.hashCode ^ _id.hashCode;
}