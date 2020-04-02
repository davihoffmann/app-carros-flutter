import 'dart:async';

import 'package:carros/bloc/carros_bloc.dart';
import 'package:carros/pages/carros_list.dart';
import 'package:carros/utils/event_bus.dart';
import 'package:carros/widgets/text_error.dart';
import 'package:flutter/material.dart';
import 'package:carros/models/carro.dart';

class CarrosPage extends StatefulWidget {
  final String tipo;
  CarrosPage(this.tipo);

  @override
  _CarrosPageState createState() => _CarrosPageState();
}

class _CarrosPageState extends State<CarrosPage> with AutomaticKeepAliveClientMixin<CarrosPage> {
  StreamSubscription<String> subscription;

  String get tipo => widget.tipo;

  final _bloc = CarrosBloc();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    _bloc.fetch(widget.tipo);

    // Escutando uma stream
    final bus = EventBus.get(context);
    subscription = bus.stream.listen((String s) {
      print("event > $s");
      // Atualiza a lista de carros, independente do evento (create, update, delete)
      _bloc.fetch(tipo);
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    // Utilizado para redesenhar pequenas partes da tela, sem necessidade de recarrgar todo o build
    // Melhora o gerenciamento de estado da tela (observer)
    // Programacao reativa
    return StreamBuilder(
      stream: _bloc.stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return TextError("Não foi possível buscar os carros!");
        }

        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        List<Carro> carros = snapshot.data;

        return RefreshIndicator(
          onRefresh: _onRefresh,
          child: CarrosList(carros),
        );
      },
    );
  }

  Future<void> _onRefresh() {
    return _bloc.fetch(tipo);
  }

  @override
  void dispose() {
    super.dispose();

    // Sempre executar esse metodos para otimização de memoria
    _bloc.dispose();
    subscription.cancel();
  }

}
