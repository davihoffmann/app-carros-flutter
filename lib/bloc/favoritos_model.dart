import 'package:carros/models/carro.dart';
import 'package:carros/service/favorito_service.dart';
import 'package:flutter/material.dart';

class FavoritosModel extends ChangeNotifier {

  List<Carro> carros = [];

  Future<List<Carro>> getCarros() async {
    this.carros = await FavoritoService.getCarros();

    notifyListeners();

    return carros;
  }


}