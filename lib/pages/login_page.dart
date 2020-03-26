import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
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
    return Container(
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
          _campoTexto('Login', 'Informe seu login'),
          SizedBox(height: 10),
          _campoTexto('Senha', 'Informe sua senha', esconderTexto: true),
          SizedBox(height: 20),
          _botao('Login')
        ],
      ),
    );
  }

  Container _botao(String texto) {
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
        onPressed: () {},
      ),
    );
  }

  TextFormField _campoTexto(String label, String hint,
      {bool esconderTexto = false}) {
    return TextFormField(
      obscureText: esconderTexto,
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
}
