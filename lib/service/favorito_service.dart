import 'package:carros/bloc/favoritos_model.dart';
import 'package:carros/controller/carro_dao.dart';
import 'package:carros/controller/favorito_dao.dart';
import 'package:carros/models/carro.dart';
import 'package:carros/models/favorito.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritoService {

  static Future<bool> favoritar(BuildContext context, Carro carro) async {
    Favorito favorito  = Favorito.fromCarro(carro);
    final dao = FavoritoDAO();

    final exists = await dao.exists(carro.id);
    if(exists) {
      // deleta dos favoritos
      dao.delete(carro.id);

      Provider.of<FavoritosModel>(context, listen: false).getCarros();

      return false;
    } else {
      //adiciona nos favoritos
      dao.save(favorito);
      Provider.of<FavoritosModel>(context, listen: false).getCarros();

      return true;
    }
  }

  static Future<List<Carro>> getCarros() async {
    List<Carro> carros = await CarroDAO().query('select * from carro c, favorito f where c.id = f.id');
    return carros;
  }

  static Future<bool> isFavorito(Carro carro) async {
    final dao = FavoritoDAO();

    final exists = await dao.exists(carro.id);

    return exists;
  }

}