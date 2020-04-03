import 'package:carros/bloc/login_bloc.dart';
import 'package:carros/pages/home_page.dart';
import 'package:carros/service/api_response.dart';
import 'package:carros/service/firebase_service.dart';
import 'package:carros/utils/alert.dart';
import 'package:carros/utils/nav.dart';
import 'package:carros/widgets/app_button.dart';
import 'package:carros/widgets/app_campo_texto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _bloc = LoginBloc();

  final _formKey = GlobalKey<FormState>();

  final _tLogin = TextEditingController();
  final _tSenha = TextEditingController();

  final _focusSenha = FocusNode();

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
            StreamBuilder<bool>(
              stream: _bloc.boolBloc.stream,
              initialData: false,
              builder: (context, snapshot) {
                return AppButton(
                  'Login',
                  onPressed: _onClickLogin,
                  showProgress: snapshot.data,
                );
              },
            ),
            Container(
              height: 46,
              margin: EdgeInsets.only(top: 20),
              child: GoogleSignInButton(
                onPressed: _onClickGoogle,
              ),
            )
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

    ApiResponse response = await _bloc.login(login, senha);

    if (response.ok) {
      //Usuario user = response.result;
      push(context, HomePage(), replace: true);
    } else {
      alert(context, "Erro!", response.msg);
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

  void _onClickGoogle() async {
    final service = FirebaseService();
    ApiResponse response = await service.loginGoogle();

    if(response.ok) {
      push(context, HomePage(), replace: true);
    } else {
      alert(context, "Erro!", response.msg);
    }
  }

  @override
  void dispose() {
    super.dispose();

    _bloc.dispose();
  }

}
