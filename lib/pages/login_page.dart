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
            _campoTexto(
              'Login',
              'Informe seu login',
              controller: _tLogin,
              validator: _validateLogin,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              nextFocus: _focusSenha
            ),
            SizedBox(height: 10),
            _campoTexto('Senha', 'Informe sua senha',
                esconderTexto: true,
                controller: _tSenha,
                validator: _validateSenha,
                keyboardType: TextInputType.number,
                focusNode: _focusSenha),
            SizedBox(height: 20),
            _botao('Login', _onClickLogin),
          ],
        ),
      ),
    );
  }

  TextFormField _campoTexto(String label, String hint,
      {bool esconderTexto = false,
      TextEditingController controller,
      FormFieldValidator<String> validator,
      TextInputType keyboardType,
      TextInputAction textInputAction,
      FocusNode focusNode,
      FocusNode nextFocus}) {
    return TextFormField(
      controller: controller,
      obscureText: esconderTexto,
      validator: validator,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      focusNode: focusNode,
      onFieldSubmitted: (String text) {
        if(nextFocus != null) {
          FocusScope.of(context).requestFocus(nextFocus);
        }
      },
      style: TextStyle(
        fontSize: 25,
        color: Colors.blue,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          fontSize: 25,
        ),
        hintText: hint,
      ),
    );
  }

  Container _botao(String texto, Function onPressed) {
    return Container(
      height: 50,
      child: RaisedButton(
        color: Colors.blue,
        child: Text(
          texto,
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }

  void _onClickLogin() {
    bool formOk = _formKey.currentState.validate();
    if (!formOk) {
      return;
    }

    String login = _tLogin.text;
    String senha = _tSenha.text;
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
