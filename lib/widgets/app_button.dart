import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  
  final String texto;
  final Function onPressed;

  AppButton(this.texto, {this.onPressed});

  @override
  Widget build(BuildContext context) {
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
}