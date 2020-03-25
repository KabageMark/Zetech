import 'package:flutter/material.dart';
import 'package:zetech_app/screens/shared/constants.dart';
import 'package:zetech_app/screens/shared/loading.dart';
import 'package:zetech_app/services/auth.dart';

class SignIn extends StatefulWidget {
  final Function toggleview;
  SignIn({this.toggleview});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();

  final _formkey = GlobalKey<FormState>();
  
  bool loading = false;

  //text field state
  String email = '';
 
  String password = '';

  String error = '';
  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        elevation: 0.0,
        title: Text('Sign in'),
         actions: <Widget>[
          FlatButton.icon(
            icon:Icon (Icons.person),
            label: Text('Register'),
            onPressed: () {
              widget.toggleview();
            },
            )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 50),
        child: Form(
          key: _formkey,
           child: Column(
             children: <Widget>[
               SizedBox(height: 20),
               TextFormField(
                decoration: textInputDecoration.copyWith( hintText: 'Email',),
                validator: (val) => val.isEmpty ? 'Enter an Email':null,
                 onChanged: (val) {
                 setState(() {
                   email = val;
                 });
                 },
               ),
               SizedBox(height: 20),
               TextFormField(
                 decoration: textInputDecoration.copyWith( hintText: 'Password',),
                validator: (val) => val.length < 6 ? 'Enter password 6 characters more' : null,
                 onChanged: (val) {
                  setState(() {
                   password = val;
                 });
                 },
                 obscureText: true,
               ),
                SizedBox(height: 20),
                RaisedButton(
                  color: Colors.blue[400],
                  child: Text(
                    'Sign In',
                    style: TextStyle(color: Colors.white),
                    ),
                    onPressed: ()async{
                      if(_formkey.currentState.validate()){
                        setState(() {
                          loading = true;
                        });
                       dynamic result = await _auth.signinEmailPassword(email, password);
                        if(result == null){
                          setState(() {
                            error ="Wrong Password and Email";
                            loading = false;
                          });
                        }
                      }
                    },
                ),
                 SizedBox(height: 12),
                Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 14),
                )
             ],
           ),
        )
      ),
    );
  }
}