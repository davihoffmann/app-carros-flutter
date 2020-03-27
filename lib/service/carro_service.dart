import 'dart:convert';

import 'package:carros/models/carro.dart';
import 'package:http/http.dart' as http;

class CarroService {
  static Future<List<Carro>> getCarros() async {
    var url = 'https://carros-springboot.herokuapp.com/api/v1/carros';
    var response = await http.get(url);

    List list = json.decode(response.body);

    List<Carro> carros = List<Carro>();

    list.map((map) => {
      carros.add(Carro.fromJson(map))
    }).toList();

    return carros;
  }
}
