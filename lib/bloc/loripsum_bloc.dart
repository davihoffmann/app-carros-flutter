import 'dart:async';

import 'package:carros/service/loripsum_service.dart';

class LoripsumBloc {

  static String lorim;

  final _streamController = StreamController<String>();

  Stream<String> get stream => _streamController.stream;

  fetch() async {
    String texto = lorim ?? await LoripsumService.getLoripsum();

    lorim = texto;

    _streamController.add(texto);
  }

  void dispose() {
    _streamController.close();
  }


}