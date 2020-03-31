
import 'package:carros/controller/carro_dao.dart';
import 'package:carros/controller/favorito_dao.dart';
import 'package:carros/models/carro.dart';
import 'package:carros/models/favorito.dart';

class FavoritoService {

  static Future<bool> favoritar(Carro carro) async {
    Favorito favorito  = Favorito.fromCarro(carro);
    final dao = FavoritoDAO();

    final exists = await dao.exists(carro.id);
    if(exists) {
      // deleta dos favoritos
      dao.delete(carro.id);

      return false;
    } else {
      //adiciona nos favoritos
      dao.save(favorito);

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