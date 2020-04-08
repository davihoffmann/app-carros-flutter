import 'package:carros/models/carro.dart';
import 'package:carros/pages/carros_list.dart';
import 'package:carros/service/carro_service.dart';
import 'package:flutter/material.dart';

class CarrosSearch extends SearchDelegate<Carro> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildSuggestions(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.length > 2) {
      return FutureBuilder(
        future: CarroService.search(query),
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            final List<Carro> carros = snapshot.data;
            return CarrosList(carros, search: true);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      );
    }

    return Container();
  }
}
