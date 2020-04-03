import 'package:carros/pages/carros_list.dart';
import 'package:carros/service/favorito_service.dart';
import 'package:carros/widgets/text_error.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carros/models/carro.dart';

class FavoritosPage extends StatefulWidget {
  @override
  _FavoritosPageState createState() => _FavoritosPageState();
}

class _FavoritosPageState extends State<FavoritosPage>
    with AutomaticKeepAliveClientMixin<FavoritosPage> {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    // Utilizado para redesenhar pequenas partes da tela, sem necessidade de recarrgar todo o build
    // Melhora o gerenciamento de estado da tela (observer)
    // Programacao reativa
    return StreamBuilder<QuerySnapshot>(
      stream: FavoritoService().stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return TextError("Não foi possível buscar os carros!");
        }

        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        List<Carro> carros =
            snapshot.data.documents.map((DocumentSnapshot document) {
          return Carro.fromMap(document.data);
        }).toList();

        return CarrosList(carros);
      },
    );
  }
}
