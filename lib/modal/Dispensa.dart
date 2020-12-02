import 'package:smart_cupboard/modal/Prodotto.dart';

class Dispensa{
  List<Prodotto> _prodotti= new List<Prodotto>();

  Dispensa(this._prodotti);

  List<Prodotto> get prodotti => _prodotti;

  set prodotti(List<Prodotto> value) {
    _prodotti = value;
  }

  addProdotto(Prodotto p){
    if(!_prodotti.contains(p)) {
      _prodotti.add(p);
    }

  }

  @override
  String toString() {
    return 'Dispensa{_prodotti: $_prodotti}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Dispensa &&
          runtimeType == other.runtimeType &&
          _prodotti == other._prodotti;

  @override
  int get hashCode => _prodotti.hashCode;

  Dispensa.fromJson(Map<String, dynamic> json)
      : _prodotti = json['prodotti'];

  Map<String, dynamic> toJson() => {
    'prodotti': _prodotti,
  };
}