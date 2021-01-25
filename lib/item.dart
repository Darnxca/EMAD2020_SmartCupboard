

import 'Prodotti.dart';

class Item {
  Item({
    this.expandedValue,
    this.categoryName,
    this.isExpanded = false,
    this.prodottiDipensa,
    this.urlImg,
  });

  String expandedValue;
  String categoryName;
  bool isExpanded;
  String urlImg;
  List<Prodotti> prodottiDipensa;
}