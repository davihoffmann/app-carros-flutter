import 'dart:async';

import 'package:carros/bloc/simple_bloc.dart';
import 'package:carros/service/api_response.dart';
import 'package:carros/service/firebase_service.dart';

class LoginBloc {

  final boolBloc = SimpleBloc<bool>();

  //Faz a chamada do login no service
  Future<ApiResponse> login(String login, String senha) async {
    boolBloc.add(true);

    //ApiResponse response = await LoginSerevice.login(login, senha);
    ApiResponse response = await FirebaseService().login(login, senha);

    boolBloc.add(false);

    return response;
  }

  void dispose() {
    boolBloc.dispose();
  }
}