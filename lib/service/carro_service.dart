import 'dart:convert';
import 'dart:io';

import 'package:carros/models/carro.dart';
import 'package:carros/service/api_response.dart';
import 'package:carros/service/http_base.dart' as http;
import 'package:carros/service/upload_service.dart';

class TipoCarro {
  static const String CLASSICO = "classicos";
  static const String ESPORTIVO = "esportivos";
  static const String LUXO = "luxo";
}

class CarroService {
  static Future<List<Carro>> getCarros(String tipo) async {
    var url = 'https://carros-springboot.herokuapp.com/api/v2/carros/tipo/$tipo';

    print("GET > $url");

    var response = await http.get(url);

    List list = json.decode(response.body);

    List<Carro> carros = list.map<Carro>((map) => Carro.fromMap(map)).toList();

    return carros;
  }

  static Future<ApiResponse<bool>> save(Carro carro, File file) async {
    try {

      if(file != null) {
        ApiResponse<String> response = await UploadService.upload(file);
        if(response.ok) {
          carro.urlFoto = response.result;
        }
      }

      bool isUpdate = carro.id != null;

      var url = 'https://carros-springboot.herokuapp.com/api/v2/carros';
      if (isUpdate) {
        url += "/${carro.id}";
      }

      print('POST > $url');

      String jsonCarro = carro.toJson();

      var response = await ((isUpdate)
          ? http.put(url, body: jsonCarro)
          : http.post(url, body: jsonCarro));

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

  static delete(Carro carro) async {
    try {
      var url = 'https://carros-springboot.herokuapp.com/api/v2/carros/${carro.id}';
     
      print('DELETE > $url');

      var response = await http.delete(url);

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        return ApiResponse.ok(true);
      }

      return ApiResponse.error("Não foi possível deletar o carro!");
    } catch (e) {
      print(e);
      return ApiResponse.error("Não foi possível deletar o carro!");
    }
  }
}
