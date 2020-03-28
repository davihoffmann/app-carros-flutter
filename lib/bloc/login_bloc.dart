import 'dart:async';

import 'package:carros/bloc/simple_bloc.dart';
import 'package:carros/models/usuario.dart';
import 'package:carros/service/api_response.dart';
import 'package:carros/service/login_service.dart';

class LoginBloc {

  final buttonBloc = SimpleBloc<bool>();

  //Faz a chamada do login no service
  Future<ApiResponse<Usuario>> login(String login, String senha) async {
    buttonBloc.add(true);
    ApiResponse response = await LoginSerevice.login(login, senha);
    buttonBloc.add(false);

    return response;
  }

  void dispose() {
    buttonBloc.dispose();
  }
}