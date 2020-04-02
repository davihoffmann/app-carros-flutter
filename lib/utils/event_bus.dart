
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Event {

}


class EventBus {

  /*
  * Método static para faciliar a busca do provider
  */
  static EventBus get(BuildContext context) => Provider.of<EventBus>(context, listen: false);
  
  /*
   * Com o "broadcast()" permite que a stream seja escutada mais de uma vez
   * todas as tream do rxdart já são broadcast por padrão
   */
  final _streamController  = StreamController<Event>.broadcast();

  Stream<Event> get stream => _streamController.stream;

  sendEvent(Event event) {
    _streamController.add(event);
  }

  dispose() {
    _streamController.close();
  }

}