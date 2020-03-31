import 'dart:convert';

import 'package:carros/models/carro.dart';
import 'package:carros/models/usuario.dart';
import 'package:carros/service/api_response.dart';
import 'package:http/http.dart' as http;

class TipoCarro {
  static const String CLASSICO = "classicos";
  static const String ESPORTIVO = "esportivos";
  static const String LUXO = "luxo";
}

class CarroService {
  static Future<List<Carro>> getCarros(String tipo) async {
    Usuario user = await Usuario.get();

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${user.token}"
    };

    var url =
        'https://carros-springboot.herokuapp.com/api/v2/carros/tipo/$tipo';

    print("GET > $url");

    var response = await http.get(url, headers: headers);

    List list = json.decode(response.body);

    List<Carro> carros = list.map<Carro>((map) => Carro.fromMap(map)).toList();

    return carros;
  }

  static Future<ApiResponse<bool>> save(Carro carro) async {
    try {
      bool isUpdate = carro.id != null;

      Usuario user = await Usuario.get();

      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${user.token}"
      };

      var url = 'https://carros-springboot.herokuapp.com/api/v2/carros';
      if (isUpdate) {
        url += "/${carro.id}";
      }

      print('POST > $url');

      String jsonCarro = carro.toJson();

      var response = await ((isUpdate)
          ? http.put(url, body: jsonCarro, headers: headers)
          : http.post(url, body: jsonCarro, headers: headers));

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 201 || response.statusCode == 200) {
        Map mapResponse = json.decode(response.body);

        Carro carro = Carro.fromMap(mapResponse);

        print('Novo Carro > ${carro.id}');

        return ApiResponse.ok(true);
      }

      if (response.body == null || response.body.isEmpty) {
        return ApiResponse.error("Não foi possível salvar o carro!");
      }

      Map mapResponse = json.decode(response.body);
      return ApiResponse.error(mapResponse["error"]);
    } catch (e) {
      print(e);
      return ApiResponse.error("Não foi possível salvar o carro!");
    }
  }
}
