import 'package:carros/bloc/simple_bloc.dart';
import 'package:carros/controller/carro_dao.dart';
import 'package:carros/models/carro.dart';
import 'package:carros/service/carro_service.dart';
import 'package:carros/utils/network.dart';

/*
 * Business Logic Component
 * Classe com a logica de negócios (utilizando programação reativa (streams))
 */
class CarrosBloc extends SimpleBloc<List<Carro>> {
  
  // Busca os carros da API
  Future<List<Carro>> fetch(String tipo) async {
    try {
      bool networkOn = await isNetworkOn();

      if(!networkOn) {
        // BUSCA NO BANCO DE DADOS
        List<Carro> carros = await CarroDAO().findAllByTipo(tipo);
        add(carros);
        return carros;
      } 

      List<Carro> carros = await CarroService.getCarros(tipo);

      if(carros.isNotEmpty) {
        final dao = CarroDAO();

        // Salvar os carros no banco de dados SQLITE
        carros.forEach((c) => dao.save(c));
      }

      add(carros);

      return carros;
    } catch(e) {
      List<Carro> carros = [];
      addError(e);

      return carros;
    }
  }

}
