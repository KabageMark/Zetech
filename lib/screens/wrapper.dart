import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zetech_app/models/user.dart';
import 'package:zetech_app/screens/authenticate/authenticate.dart';
import 'package:zetech_app/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      final user = Provider.of<User>(context);
    
    //return home or authenticate widget
    if (user == null){
       return Authenticate();
    }else{
       return Home();
    }
  }
}