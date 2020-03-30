import 'package:carros/bloc/simple_bloc.dart';
import 'package:carros/models/carro.dart';
import 'package:carros/service/carro_service.dart';

/*
 * Business Logic Component
 * Classe com a logica de negócios (utilizando programação reativa (streams))
 */
class CarrosBloc extends SimpleBloc<List<Carro>> {
  
  // Busca os carros da API
  Future<List<Carro>> fetch(String tipo) async {
    try {
      List<Carro> carros = await CarroService.getCarros(tipo);

      add(carros);

      return carros;
    } catch(e) {
      addError(e);
      List<Carro> carros = [];
      return carros;
    }
  }

}
