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
          TextFormField(
            style: TextStyle(
              fontSize: 25,
              color: Colors.blue,
            ),
            decoration: InputDecoration(
              labelText: 'Login',
              labelStyle: TextStyle(
                fontSize: 25,
              ),
              hintText: 'Digite o Login',
            ),
          ),
          SizedBox(height: 10),
          TextFormField(
            style: TextStyle(
              color: Colors.blue,
              fontSize: 25,
            ),
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Senha',
              labelStyle: TextStyle(
                fontSize: 25,
              ),
              hintText: 'Digite a Senha',
            ),
          ),
          SizedBox(height: 20),
          Container(
            height: 50,
            child: RaisedButton(
              color: Colors.blue,
              child: Text(
                'Logar',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                ),
              ),
              onPressed: () {},
            ),
          )
        ],
      ),
    );
  }
}
