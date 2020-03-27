import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String texto;
  final Function onPressed;
  final bool showProgress;

  AppButton(this.texto, {this.onPressed, this.showProgress = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: RaisedButton(
        color: Colors.blue,
        child: showProgress
            ? Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Text(
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
