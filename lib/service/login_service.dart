import 'dart:convert';

import 'package:carros/models/usuario.dart';
import 'package:carros/service/api_response.dart';
import 'package:http/http.dart' as http;

class LoginSerevice {
  static Future<ApiResponse<Usuario>> login(String login, String senha) async {
    try {
      var url = 'https://carros-springboot.herokuapp.com/api/v1/login';

      Map<String, String> headers = {"Content-Type": "application/json"};

      var params = {"username": login, "password": senha};

      var response =
          await http.post(url, body: json.encode(params), headers: headers);

      //print('Response status: ${response.statusCode}');
      //print('Response body: ${response.body}');

      Map mapResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        final user = Usuario.fromJson(mapResponse);
        user.save();

        return ApiResponse.ok(result: user);
      }

      return ApiResponse.error(msg: mapResponse["error"]);
    } catch (error, exception) {
      print("Erro no login $error >> $exception");

      return ApiResponse.error(msg: "Não foi possível fazer o login");
    }
  }
}
