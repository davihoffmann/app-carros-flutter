import 'package:carros/bloc/favorito_bloc.dart';
import 'package:carros/pages/carros_list.dart';
import 'package:carros/widgets/text_error.dart';
import 'package:flutter/material.dart';
import 'package:carros/models/carro.dart';

class FavoritosPage extends StatefulWidget {
  @override
  _FavoritosPageState createState() => _FavoritosPageState();
}

class _FavoritosPageState extends State<FavoritosPage> with AutomaticKeepAliveClientMixin<FavoritosPage> {
  final _bloc = FavoritoBloc();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    _bloc.fetch();
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
    return _bloc.fetch();
  }

  @override
  void dispose() {
    super.dispose();

    _bloc.dispose();
  }

}
