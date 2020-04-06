import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carros/models/carro.dart';
import 'package:carros/service/api_response.dart';
import 'package:carros/service/carro_service.dart';
import 'package:carros/service/firebase_service.dart';
import 'package:carros/utils/alert.dart';
import 'package:carros/utils/event_bus.dart';
import 'package:carros/utils/nav.dart';
import 'package:carros/widgets/app_button.dart';
import 'package:carros/widgets/app_campo_texto.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CarroFormPage extends StatefulWidget {
  final Carro carro;

  CarroFormPage({this.carro});

  @override
  _CarroFormPageState createState() => _CarroFormPageState();
}

class _CarroFormPageState extends State<CarroFormPage> {
  // Utilizado para fazer a validação do Formulario
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final tNome = TextEditingController();
  final tDesc = TextEditingController();
  final tTipo = TextEditingController();

  int _radioIndex = 0;

  var _showProgress = false;

  File _file;

  Carro get carro => widget.carro;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(carro != null ? carro.nome : "Novo Carro"),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: _form(),
      ),
    );
  }

  String _validateNome(String value) {
    if (value.isEmpty) {
      return 'Informe o nome do carro.';
    }
    return null;
  }

  @override
  void initState() {
    super.initState();

    // Copia os dados do carro para o form
    if (carro != null) {
      tNome.text = carro.nome;
      tDesc.text = carro.descricao;
      _radioIndex = getTipoInt(carro);
    }
  }

  _form() {
    return Form(
      key: this._formKey,
      child: ListView(
        children: <Widget>[
          _headerFoto(),
          Text(
            "Toque na imagem para tirar uma foto",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          Divider(),
          Text(
            "Tipo",
            style: TextStyle(
              color: Colors.blue,
              fontSize: 20,
            ),
          ),
          _radioTipo(),
          Divider(),
          AppCampoTexto(
            'Nome',
            '',
            controller: tNome,
            keyboardType: TextInputType.text,
            validator: _validateNome,
          ),
          SizedBox(
            height: 25,
          ),
          AppCampoTexto(
            'Descrição',
            '',
            controller: tDesc,
            keyboardType: TextInputType.text,
          ),
          SizedBox(
            height: 25,
          ),
          AppButton(
            "Salvar",
            onPressed: _onClickSalvar,
            showProgress: _showProgress,
          )
        ],
      ),
    );
  }

  _headerFoto() {
    return InkWell(
      onTap: _onClickFoto,
      child: this._file != null
          ? Image.file(_file, height: 150,)
          : carro != null
              ? CachedNetworkImage(
                  imageUrl: carro.urlFoto ??
                      'http://www.tribunadeituverava.com.br/wp-content/uploads/2017/12/sem-foto-sem-imagem.jpeg',
                )
              : Image.asset(
                  "assets/images/camera_icon.png",
                  height: 150,
                ),
    );
  }

  _radioTipo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Radio(
          value: 0,
          groupValue: _radioIndex,
          onChanged: _onClickTipo,
        ),
        Text(
          "Clássicos",
          style: TextStyle(color: Colors.blue, fontSize: 15),
        ),
        Radio(
          value: 1,
          groupValue: _radioIndex,
          onChanged: _onClickTipo,
        ),
        Text(
          "Esportivos",
          style: TextStyle(color: Colors.blue, fontSize: 15),
        ),
        Radio(
          value: 2,
          groupValue: _radioIndex,
          onChanged: _onClickTipo,
        ),
        Text(
          "Luxo",
          style: TextStyle(color: Colors.blue, fontSize: 15),
        ),
      ],
    );
  }

  void _onClickTipo(int value) {
    setState(() {
      _radioIndex = value;
    });
  }

  getTipoInt(Carro carro) {
    switch (carro.tipo) {
      case TipoCarro.CLASSICO:
        return 0;
      case TipoCarro.ESPORTIVO:
        return 1;
      default:
        return 2;
    }
  }

  String _getTipo() {
    switch (_radioIndex) {
      case 0:
        return TipoCarro.CLASSICO;
      case 1:
        return TipoCarro.ESPORTIVO;
      default:
        return TipoCarro.LUXO;
    }
  }

  void _onClickFoto() async {
    File file = await ImagePicker.pickImage(source: ImageSource.camera);

    FirebaseService.uploadFirebaseStorage(file);

    //if (file != null) {
    //  setState(() {
    //    this._file = file;
    //  });
    //}
  }

  _onClickSalvar() async {
    // Utilizando o formkey chama o validate do formulario, que vai chamar o validate de cada campo
    if (!_formKey.currentState.validate()) {
      return;
    }

    // Cria o carro
    var c = carro ?? Carro();
    c.nome = tNome.text;
    c.descricao = tDesc.text;
    c.tipo = _getTipo();

    print("Carro: $c");

    setState(() {
      _showProgress = true;
    });

    print("Salvar o carro $c");

    //await Future.delayed(Duration(seconds: 3));

    ApiResponse<bool> response = await CarroService.save(c, _file);

    if (response.ok) {
      alert(context, "Sucesso!", "Carro salvo com sucesso!", callback: () {
        EventBus.get(context).sendEvent(CarroEvent("carro_cadastrado", c.tipo));
        pop(context);
      });
    } else {
      alert(context, "Erro!", response.msg);
    }

    setState(() {
      _showProgress = false;
    });

    print("Fim.");
  }
}
