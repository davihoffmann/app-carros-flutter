
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventBus {

  /*
  * Método static para faciliar a busca do provider
  */
  static EventBus get(BuildContext context) => Provider.of<EventBus>(context, listen: false);
  
  /*
   * Com o "broadcast()" permite que a stream seja escutada mais de uma vez
   * todas as tream do rxdart já são broadcast por padrão
   */
  final _streamController  = StreamController<String>.broadcast();

  Stream<String> get stream => _streamController.stream;

  sendEvent(String event) {
    _streamController.add(event);
  }

  dispose() {
    _streamController.close();
  }

}