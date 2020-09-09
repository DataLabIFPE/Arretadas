import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Button extends StatefulWidget {
  Button(
      {Key key,
      this.type,
      this.email,
      this.password,
      this.txtColor,
      this.btnColor,
      this.labelText,
      this.callback})
      : super(key: key);

  final Color txtColor;
  final Color btnColor;
  final String labelText;
  final String type;
  final String email;
  final String password;
  final Function callback;
  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  // Future<dynamic> _checkUser(email, password) async {
  //   final url = 'http://10.0.2.2:3000/exists';
  //   final isLogged =
  //       await http.post(url, body: {'email': email, 'password': password});

  //   print(isLogged.statusCode);

  //   return isLogged.statusCode;
  // }

  // Future<dynamic> _sendMessage() async {
  //   final url = 'http://10.0.2.2:3000/help';
  //   final send = await http.post(url, body: {
  //     'num1': '5583996292935',
  //     'num2': '5587999429510',
  //     'num3': '5587999914901',
  //     'num4': '5581992882988',
  //     'num5': '5587981090745'
  //   });
  //   print('enviou');
  //   return send.statusCode;
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 50.0),
      height: 70.0,
      width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40.0),
        color: widget.btnColor,
      ),
      child: FlatButton(
        onPressed: widget.callback,
        child: Center(
          child: Text(
            widget.labelText,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15.0,
              color: widget.txtColor,
            ),
          ),
        ),
      ),
    );
  }
}