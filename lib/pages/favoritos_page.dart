import 'package:carros/bloc/favorito_bloc.dart';
import 'package:carros/pages/carros_list.dart';
import 'package:carros/widgets/text_error.dart';
import 'package:flutter/material.dart';
import 'package:carros/models/carro.dart';
import 'package:provider/provider.dart';

class FavoritosPage extends StatefulWidget {
  @override
  _FavoritosPageState createState() => _FavoritosPageState();
}

class _FavoritosPageState extends State<FavoritosPage> with AutomaticKeepAliveClientMixin<FavoritosPage> {
  
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    FavoritoBloc favoritosBloc = Provider.of<FavoritoBloc>(context, listen: false);
    favoritosBloc.fetch();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    FavoritoBloc favoritosBloc = Provider.of<FavoritoBloc>(context);

    // Utilizado para redesenhar pequenas partes da tela, sem necessidade de recarrgar todo o build
    // Melhora o gerenciamento de estado da tela (observer)
    // Programacao reativa
    return StreamBuilder(
      stream: favoritosBloc.stream,
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
    FavoritoBloc favoritosBloc = Provider.of<FavoritoBloc>(context, listen: false);
    
    return favoritosBloc.fetch();
  }

}
