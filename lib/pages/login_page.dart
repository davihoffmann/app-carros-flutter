import 'package:carros/models/usuario.dart';
import 'package:carros/pages/home_page.dart';
import 'package:carros/service/api_response.dart';
import 'package:carros/service/login_service.dart';
import 'package:carros/utils/alert.dart';
import 'package:carros/utils/nav.dart';
import 'package:carros/widgets/app_button.dart';
import 'package:carros/widgets/app_campo_texto.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _tLogin = TextEditingController();
  final _tSenha = TextEditingController();

  final _focusSenha = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carros'),
      ),
      body: _body(),
    );
  }

  _body() {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(25),
        child: ListView(
          children: <Widget>[
            Container(
              child: Image.network(
                'https://www.automanianet.com.br/wp-content/uploads/11-out-18-App-CarMasters-2.png',
                height: 150,
              ),
            ),
            SizedBox(height: 10),
            AppCampoTexto('Login', 'Informe seu login',
                controller: _tLogin,
                validator: _validateLogin,
                textInputAction: TextInputAction.next,
                nextFocus: _focusSenha),
            SizedBox(height: 10),
            AppCampoTexto('Senha', 'Informe sua senha',
                esconderTexto: true,
                controller: _tSenha,
                validator: _validateSenha,
                keyboardType: TextInputType.number,
                focusNode: _focusSenha),
            SizedBox(height: 20),
            AppButton('Login', onPressed: _onClickLogin),
          ],
        ),
      ),
    );
  }

  void _onClickLogin() async {
    bool formOk = _formKey.currentState.validate();
    if (!formOk) {
      return;
    }

    String login = _tLogin.text;
    String senha = _tSenha.text;

    ApiResponse response = await LoginSerevice.login(login, senha);

    if(response.ok) {
      Usuario user = response.result;
      push(context, HomePage());
    } else {
      alert(context, response.msg);
    }
  }

  String _validateLogin(String value) {
    if (value.isEmpty) {
      return "Digite o login para acessar!";
    }
    return null;
  }

  String _validateSenha(String value) {
    if (value.isEmpty) {
      return "Digite a senha para acessar!";
    }
    if (value.length < 3) {
      return "A senha deve conter mais de 3 caracteres";
    }
    return null;
  }

  @override
  void dispose() {
    super.dispose();
  }
}
