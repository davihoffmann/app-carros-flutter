import 'dart:async';

import 'package:carros/service/loripsum_service.dart';

class LoripsumBloc {
  static String lorim;

  final _streamController = StreamController<String>();

  Stream<String> get stream => _streamController.stream;

  fetch() async {
    try {
      String texto = lorim ?? await LoripsumService.getLoripsum();

      lorim = texto;

      _streamController.add(texto);
    } catch (e) {
      _streamController.addError(e);
    }
  }

  void dispose() {
    _streamController.close();
  }
}
