import 'package:flutter/material.dart';

class AppCampoTexto extends StatelessWidget {
  final String label;
  final String hint;
  final bool esconderTexto;
  final TextEditingController controller;
  final FormFieldValidator<String> validator;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final FocusNode focusNode;
  final FocusNode nextFocus;

  AppCampoTexto(
    this.label,
    this.hint, {
    this.esconderTexto = false,
    this.controller,
    this.validator,
    this.keyboardType,
    this.textInputAction,
    this.focusNode,
    this.nextFocus,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: esconderTexto,
      validator: validator,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      focusNode: focusNode,
      onFieldSubmitted: (String text) {
        if (nextFocus != null) {
          FocusScope.of(context).requestFocus(nextFocus);
        }
      },
      style: TextStyle(
        fontSize: 25,
        color: Colors.blue,
      ),
      decoration: InputDecoration(
        //border: OutlineInputBorder(),
        labelText: label,
        labelStyle: TextStyle(
          fontSize: 25,
        ),
        hintText: hint,
      ),
    );
  }
}
