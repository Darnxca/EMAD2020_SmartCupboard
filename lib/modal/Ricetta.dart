class Ricetta {
  String _nomeRicetta, _difficolta, _procedimento, _urlImg;
  List<String> _ingredienti;
  bool _healthy;

  Ricetta(this._nomeRicetta, this._difficolta, this._procedimento, this._urlImg,
      this._ingredienti,this._healthy);

  List<String> get ingredienti => _ingredienti;

  set ingredienti(List<String> value) {
    _ingredienti = value;
  }

  get urlImg => _urlImg;

  set urlImg(value) {
    _urlImg = value;
  }

  get procedimento => _procedimento;

  set procedimento(value) {
    _procedimento = value;
  }

  get difficolta => _difficolta;

  set difficolta(value) {
    _difficolta = value;
  }

  String get nomeRicetta => _nomeRicetta;

  set nomeRicetta(String value) {
    _nomeRicetta = value;
  }

  bool get healthy => _healthy;

  set healthy(bool value) {
    _healthy = value;
  }

  @override
  String toString() {
    return 'Ricetta{_nomeRicetta: $_nomeRicetta, _difficolta: $_difficolta, _procedimento: $_procedimento, _urlImg: $_urlImg, _ingredienti: $_ingredienti, _healthy: $_healthy}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Ricetta &&
          runtimeType == other.runtimeType &&
          _nomeRicetta == other._nomeRicetta &&
          _difficolta == other._difficolta &&
          _procedimento == other._procedimento &&
          _urlImg == other._urlImg &&
          _ingredienti == other._ingredienti &&
          _healthy == other._healthy;

  @override
  int get hashCode =>
      _nomeRicetta.hashCode ^
      _difficolta.hashCode ^
      _procedimento.hashCode ^
      _urlImg.hashCode ^
      _ingredienti.hashCode ^
      _healthy.hashCode;
}
