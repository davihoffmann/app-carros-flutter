import 'package:carros/pages/home_page.dart';
import 'package:carros/pages/login_page.dart';
import 'package:carros/service/firebase_service.dart';
import 'package:carros/utils/alert.dart';
import 'package:carros/utils/nav.dart';
import 'package:carros/widgets/app_campo_texto.dart';
import 'package:flutter/material.dart';

class CadastroPage extends StatefulWidget {
  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final _formKey = GlobalKey<FormState>();

  final _tNome = TextEditingController();
  final _tEmail = TextEditingController();
  final _tSenha = TextEditingController();

  var _progress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro de Usuário"),
      ),
      body: _body(context),
    );
  }

  _body(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: <Widget>[
            AppCampoTexto(
              'Nome',
              'Informe o seu nome',
              controller: _tNome,
              validator: _validaNome,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
            ),
            TextFormField(
              controller: _tEmail,
              validator: _validaEmail,
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(fontSize: 25),
              decoration: InputDecoration(
                labelText: "E-mail",
                hintText: "Informe o seu e-mail",
              ),
            ),
            TextFormField(
              controller: _tSenha,
              validator: _validaSenha,
              keyboardType: TextInputType.number,
              obscureText: true,
              style: TextStyle(fontSize: 25),
              decoration: InputDecoration(
                labelText: "Senha",
                hintText: "Informe uma senha",
              ),
            ),
            Container(
              height: 46,
              margin: EdgeInsets.only(top: 20),
              child: RaisedButton(
                color: Colors.blue,
                onPressed: () => _onClickCadastrar(context),
                child: _progress
                    ? CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      )
                    : Text(
                        "Cadastrar",
                        style: TextStyle(color: Colors.white, fontSize: 22),
                      ),
              ),
            ),
            Container(
              height: 46,
              margin: EdgeInsets.only(top: 20),
              child: RaisedButton(
                color: Colors.white,
                onPressed: () => _onClickCancelar(context),
                child: Text(
                  "Cancelar",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 22,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _onClickCadastrar(BuildContext context) async {
    String nome = _tNome.text;
    String email = _tEmail.text;
    String senha = _tSenha.text;

    print("Nome: $nome, Email: $email, Senha: $senha");

    if(!_formKey.currentState.validate()) {
      return;
    }

    setState(() {
      _progress = true;
    });

    final service = FirebaseService();
    final response = await service.cadastrar(nome, email, senha);

    if(response.ok) {
      push(context, HomePage(), replace: true);
    } else {
      alert(context, "Erro!", response.msg);
    }

    setState(() {
      _progress = false;
    });
  }

  _onClickCancelar(BuildContext context) {
    push(context, LoginPage(), replace: true);
  }

  String _validaNome(String value) {
    if (value.isEmpty) {
      return "É obrigatório informar o seu nome!";
    }
    return null;
  }

  String _validaEmail(String value) {
    if (value.isEmpty) {
      return "É obrigatório informar o seu e-mail!";
    }
    return null;
  }

  String _validaSenha(String value) {
    if (value.isEmpty) {
      return "É obrigatório informar uma senha!";
    }
    return null;
  }

}
