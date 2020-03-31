import 'package:carros/bloc/simple_bloc.dart';
import 'package:carros/models/carro.dart';
import 'package:carros/service/favorito_service.dart';

/*
 * Business Logic Component
 * Classe com a logica de negócios (utilizando programação reativa (streams))
 */
class FavoritoBloc extends SimpleBloc<List<Carro>> {
  
  // Busca os carros da API
  Future<List<Carro>> fetch() async {
    try {

      List<Carro> carros = await FavoritoService.getCarros();
      add(carros);

      return carros;
    } catch(e) {
      List<Carro> carros = [];
      addError(e);

      return carros;
    }
  }

}
