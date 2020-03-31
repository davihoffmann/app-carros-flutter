
import 'package:carros/controller/carro_dao.dart';
import 'package:carros/controller/favorito_dao.dart';
import 'package:carros/models/carro.dart';
import 'package:carros/models/favorito.dart';

class FavoritoService {

  static favoritar(Carro carro) async {
    Favorito favorito  = Favorito.fromCarro(carro);
    final dao = FavoritoDAO();

    final exists = await dao.exists(carro.id);
    if(exists) {
      // deleta dos favoritos
      dao.delete(carro.id);
    } else {
      //adiciona nos favoritos
      dao.save(favorito);
    }
  }

  static Future<List<Carro>> getCarros() async {
    List<Carro> carros = await CarroDAO().query('select * from carro c, favorito f where c.id = f.id');
    return carros;
  }

}