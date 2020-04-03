import 'package:carros/database/db_helper.dart';
import 'package:carros/models/usuario.dart';
import 'package:carros/pages/login_page.dart';
import 'package:carros/service/firebase_service.dart';
import 'package:carros/utils/nav.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    // Iniciar o banco de dados
    Future futureA = DatabaseHelper.getInstance().db;

    Future futureB = Future.delayed(Duration(seconds: 3));

    // Usuario
    Future<Usuario> futureC = Usuario.get();

    Future.wait([futureA, futureB, futureC]).then((List values) {
      Usuario user = values[2];
      if (user != null) {
        firebaseUserUid = user.id;
        
        push(context, HomePage(), replace: true);
      } else {
        push(context, LoginPage(), replace: true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[200],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: CircularProgressIndicator(),
          ),
        ],
      ),
    );
  }
}
