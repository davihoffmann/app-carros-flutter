import 'package:cached_network_image/cached_network_image.dart';
import 'package:carros/pages/carro_page.dart';
import 'package:carros/utils/nav.dart';
import 'package:flutter/material.dart';
import 'package:carros/models/carro.dart';

class CarrosList extends StatelessWidget {
  final List<Carro> carros;

  CarrosList(this.carros);

  @override
  Widget build(BuildContext context) {
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
              child: InkWell(
                onTap: () => _onClickCarro(context, carro),
                onLongPress: () => _onLongClickCarroModalBottomSheet(context, carro),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: CachedNetworkImage(
                          imageUrl: carro.urlFoto ??
                              'http://www.tribunadeituverava.com.br/wp-content/uploads/2017/12/sem-foto-sem-imagem.jpeg',
                          width: 250,
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error)),
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
                          onPressed: () => _onClickCarro(context, carro),
                        ),
                        FlatButton(
                          child: const Text('SHARE'),
                          onPressed: () => _onClickShare(context, carro),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  _onClickCarro(BuildContext context, Carro carro) {
    push(context, CarroPage(carro));
  }

  /*
  _onLongClickCarro(BuildContext context, Carro carro) {
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text(carro.nome),
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.directions_car),
                title: Text("Detalhes"),
                onTap: () {
                  pop(context);
                  _onClickCarro(context, carro);
                },
              ),
              ListTile(
                leading: Icon(Icons.share),
                title: Text("Share"),
                onTap: () {
                  pop(context);
                  _onClickShare(context, carro);
                },
              )
            ],
          );
        });
  }*/

  _onLongClickCarroModalBottomSheet(BuildContext context, Carro carro) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(20),
                child: Text(
                  carro.nome,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.directions_car),
                title: Text("Detalhes"),
                onTap: () {
                  pop(context);
                  _onClickCarro(context, carro);
                },
              ),
              ListTile(
                leading: Icon(Icons.share),
                title: Text("Share"),
                onTap: () {
                  pop(context);
                  _onClickShare(context, carro);
                },
              )
            ],
          );
        });
  }

  void _onClickShare(BuildContext context, Carro carro) {
    print("share >> ${carro.nome}");
  }
}
