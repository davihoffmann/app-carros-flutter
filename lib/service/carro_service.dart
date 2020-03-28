import 'dart:convert';

import 'package:carros/models/carro.dart';
import 'package:carros/models/usuario.dart';
import 'package:http/http.dart' as http;

class TipoCarro {
  static const String CLASSICO = "classicos";
  static const String ESPORTIVO = "esportivos";
  static const String LUXO = "luxo";
}

class CarroService {
  static Future<List<Carro>> getCarros(String tipo) async {
    Usuario user =  await Usuario.get();

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${user.token}"
    };

    var url = 'https://carros-springboot.herokuapp.com/api/v2/carros/tipo/$tipo';
    var response = await http.get(url, headers: headers);

    List list = json.decode(response.body);

    return list.map<Carro>((map) => Carro.fromJson(map)).toList();
  }
}
