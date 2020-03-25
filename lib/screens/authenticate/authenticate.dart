import 'package:flutter/material.dart';
import 'package:zetech_app/screens/authenticate/register.dart';
import 'package:zetech_app/screens/authenticate/sign_in.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showsignin = true;
  void toggleview(){
    setState(() {
      showsignin =! showsignin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showsignin == true){
      return SignIn(toggleview: toggleview);
    }else{
      return Register(toggleview: toggleview);
    }
  }
}