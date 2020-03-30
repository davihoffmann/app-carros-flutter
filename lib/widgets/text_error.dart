import 'package:flutter/material.dart';

class TextError extends StatelessWidget {
  final String msg;
  
  TextError(this.msg);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.warning,color: Colors.red,),
          SizedBox(width: 5,),
          Text(
            msg,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.red,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
