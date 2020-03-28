import 'package:carros/bloc/carros_bloc.dart';
import 'package:carros/pages/carro_page.dart';
import 'package:carros/utils/nav.dart';
import 'package:carros/widgets/text_error.dart';
import 'package:flutter/material.dart';
import 'package:carros/models/carro.dart';

class CarrosList extends StatefulWidget {
  final String tipo;
  CarrosList(this.tipo);

  @override
  _CarrosListState createState() => _CarrosListState();
}

class _CarrosListState extends State<CarrosList> with AutomaticKeepAliveClientMixin<CarrosList> {
  
  List<Carro> carros;
  
  final _bloc = CarrosBloc();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    _bloc.fetch(widget.tipo);
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

        if(!snapshot.hasData) {
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
                      carro.urlFoto ??
                          "https://www.tribunadeituverava.com.br/wp-content/uploads/2017/12/sem-foto-sem-imagem-300x186.jpeg",
                      width: 250,
                    ),
                  ),
                  Text(
                    carro.nome ?? " - ",
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
                        onPressed: () => _onClickCarro(carro),
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

  _onClickCarro(Carro carro) {
    push(context, CarroPage(carro));
  }

  @override
  void dispose() {
    super.dispose();

    _bloc.dispose();
  }
}
