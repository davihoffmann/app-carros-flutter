import 'package:flutter/material.dart';
import 'package:carros/models/carro.dart';
import 'package:carros/service/carro_service.dart';

class CarrosList extends StatefulWidget {
  
  final String tipo;
  CarrosList(this.tipo);

  @override
  _CarrosListState createState() => _CarrosListState();
}

class _CarrosListState extends State<CarrosList> with AutomaticKeepAliveClientMixin<CarrosList> {

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _body();
  }

  _body() {
    Future<List<Carro>> futureCarros = CarroService.getCarros(widget.tipo);

    return FutureBuilder(
      future: futureCarros,
      builder: (context, snapshot) {

        if (snapshot.hasError) {
          return Center(
            child: Text(
              "Não foi possível buscar os carros!",
              style: TextStyle(fontSize: 22, color: Colors.red),
            ),
          );
        }

        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        List<Carro> carros = snapshot.data;
        return _listaCarros(carros);
      },
    );
  }

  Container _listaCarros(List<Carro> carros) {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView.builder(
        itemCount: carros != null ? carros.length : 0,
        itemBuilder: (context, index) {
          Carro carro = carros[index];

          return Card(
            color: Colors.grey[100],
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Image.network(
                      carro.urlFoto ?? "https://www.tribunadeituverava.com.br/wp-content/uploads/2017/12/sem-foto-sem-imagem-300x186.jpeg",
                      width: 250,
                    ),
                  ),
                  Text(
                    carro.nome ?? "Sem nome",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 25),
                  ),
                  Text(
                    "descriçao...",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 16),
                  ),
                  ButtonBar(
                    children: <Widget>[
                      FlatButton(
                        child: const Text('DETALHES'),
                        onPressed: () {/* ... */},
                      ),
                      FlatButton(
                        child: const Text('SHARE'),
                        onPressed: () {/* ... */},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

}