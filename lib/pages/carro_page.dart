import 'package:cached_network_image/cached_network_image.dart';
import 'package:carros/bloc/loripsum_bloc.dart';
import 'package:carros/models/carro.dart';
import 'package:carros/pages/carro_form_page.dart';
import 'package:carros/pages/mapa_page.dart';
import 'package:carros/pages/video_page.dart';
import 'package:carros/service/api_response.dart';
import 'package:carros/service/carro_service.dart';
import 'package:carros/service/favorito_service.dart';
import 'package:carros/utils/alert.dart';
import 'package:carros/utils/event_bus.dart';
import 'package:carros/utils/nav.dart';
import 'package:carros/widgets/text_component.dart';
import 'package:carros/widgets/text_error.dart';
import 'package:flutter/material.dart';

class TipoAcao {
  static const String EDITAR = "editar";
  static const String DELETAR = "deletar";
  static const String SHARE = "share";
}

class CarroPage extends StatefulWidget {
  final Carro carro;

  CarroPage(this.carro);

  @override
  _CarroPageState createState() => _CarroPageState();
}

class _CarroPageState extends State<CarroPage> {
  // Declaração da classe bloc
  final _loripsumBloc = LoripsumBloc();

  Color color = Colors.grey;

  @override
  void initState() {
    super.initState();

    FavoritoService.isFavorito(widget.carro).then((favorito) {
      setState(() {
        color = favorito ? Colors.red : Colors.grey;
      });
    });

    // 1 - Chama o metodo fetch, que faz a busca dos dados na api, e adiciona o resultado a stream
    _loripsumBloc.fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.carro.nome),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.place),
            onPressed: () => _onClickMap(context),
          ),
          IconButton(
            icon: Icon(Icons.video_call),
            onPressed: () => _onClickVideo(context),
          ),
          PopupMenuButton<String>(
            onSelected: (String value) => _onClickPopupMenu(value),
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(value: TipoAcao.EDITAR, child: Text("Editar")),
                PopupMenuItem(value: TipoAcao.DELETAR, child: Text("Deletar")),
                PopupMenuItem(value: TipoAcao.SHARE, child: Text("Share")),
              ];
            },
          ),
        ],
      ),
      body: _body(),
    );
  }

  _body() {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView(
        children: <Widget>[
          CachedNetworkImage(
            imageUrl: widget.carro.urlFoto ??
                'http://www.tribunadeituverava.com.br/wp-content/uploads/2017/12/sem-foto-sem-imagem.jpeg',
            width: 250,
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
          _bloco01(),
          Divider(),
          _bloco02()
        ],
      ),
    );
  }

  Row _bloco01() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextComponent(widget.carro.nome, fontSize: 20, bold: true),
            TextComponent(widget.carro.tipo, color: Colors.grey, fontSize: 15)
          ],
        ),
        Row(
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.favorite,
                color: color,
                size: 40,
              ),
              onPressed: _onClickFavorito,
            ),
            IconButton(
              icon: Icon(
                Icons.share,
                size: 40,
              ),
              onPressed: _onClickShare,
            )
          ],
        )
      ],
    );
  }

  _bloco02() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 20,
        ),
        TextComponent(
          widget.carro.descricao,
          fontSize: 16,
          bold: true,
        ),
        SizedBox(
          height: 20,
        ),
        // 2 - a Stream fica escutando se há modificações, caso ocorra, faz alteração somente da área que esta referênciada
        StreamBuilder(
          stream: _loripsumBloc.stream,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return TextError(
                "Não foi possível carregar os dados!",
              );
            }

            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            // 3 - Adicionado o resultado da strem atualizada ao componete da tela
            return TextComponent(
              snapshot.data,
              fontSize: 16,
            );
          },
        )
        /*
        FutureBuilder<String>(
          future: LoripsumService.getLoripsum(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if(!snapshot.hasData) {
              return Center(child: CircularProgressIndicator(),);
            }

            return TextComponent(snapshot.data, fontSize: 16,);
          },
        ),*/
      ],
    );
  }

  _onClickMap(BuildContext context) {
    if(widget.carro.latitude != null && widget.carro.longitude != null) {
      push(context, MapaPage(widget.carro));
    } else {
      alert(context, "Erro!", "Este carro não possui latitude ou longitude video");
    }
  }

  _onClickVideo(BuildContext context) {
    if(widget.carro.urlVideo != null && widget.carro.urlVideo.isNotEmpty) {
      //launch(widget.carro.urlVideo);
      push(context, VideoPage(widget.carro));
    } else {
      alert(context, "Erro!", "Este carro não possui nenhum video");
    }
  }

  _onClickPopupMenu(String value) {
    if (value == TipoAcao.EDITAR) {
      push(context, CarroFormPage(carro: widget.carro));
    } else if (value == TipoAcao.DELETAR) {
      _deletar();
    }
  }

  _onClickFavorito() async {
    bool favorito = await FavoritoService.favoritar(context, widget.carro);

    setState(() {
      color = favorito ? Colors.red : Colors.grey;
    });
  }

  _onClickShare() {}

  void _deletar() async {
    ApiResponse<bool> response = await CarroService.delete(widget.carro);

    if(response.ok) {
      alert(context, "Sucesso!", "Carro deletado com sucesso!", callback: () {
        EventBus.get(context).sendEvent(CarroEvent("carro_deletado", widget.carro.tipo));
        
        pop(context);
      });
    } else {
      alert(context, "Erro!", response.msg);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _loripsumBloc.dispose();
  }
}
