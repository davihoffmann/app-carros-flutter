import 'dart:convert';

import 'package:carros/models/carro.dart';
import 'package:http/http.dart' as http;

class TipoCarro {
  static const String CLASSICO = "classicos";
  static const String ESPORTIVO = "esportivos";
  static const String LUXO = "luxo";
}

class CarroService {
  static Future<List<Carro>> getCarros(String tipo) async {
    var url = 'https://carros-springboot.herokuapp.com/api/v1/carros/tipo/$tipo';
    var response = await http.get(url);
    
    List list = json.decode(response.body);
    
    return list.map<Carro>((map) => Carro.fromJson(map)).toList();
  }
}
