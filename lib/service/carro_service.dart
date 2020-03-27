import 'package:carros/models/carro.dart';

class CarroService {

  static Future<List<Carro>> getCarros() async {
    final carros = List<Carro>(); 

    await Future.delayed(Duration(seconds: 2));

    carros.add(Carro(nome: "Cadillac Convertibles", urlFoto: "http://www.livroandroid.com.br/livro/carros/classicos/Cadillac_Deville_Convertible.png",));
    carros.add(Carro(nome: "Chevrolet Bel-Air", urlFoto: "http://www.livroandroid.com.br/livro/carros/classicos/Chevrolet_BelAir.png"));
    carros.add(Carro(nome: "Cadillac Eldorado", urlFoto: "http://www.livroandroid.com.br/livro/carros/classicos/Cadillac_Eldorado.png"));

    return carros;
  }

}