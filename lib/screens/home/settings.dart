import 'package:flutter/material.dart';
import 'package:zetech_app/screens/shared/constants.dart';
import 'package:zetech_app/models/user.dart';
import 'package:zetech_app/screens/shared/loading.dart';
import 'package:zetech_app/services/database.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formkey = GlobalKey<FormState>();
  String _currentname;
  String _currentregNo;
  String _currentCourse;


  @override
  Widget build(BuildContext context) {

  final user = Provider.of<User>(context);

    return Container(
      padding: EdgeInsets.fromLTRB(30, 30, 30, 0),
      child: StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {

          UserData userData =  snapshot.data;

          if ( snapshot.hasData )  {
          return Form(
            key: _formkey,
            child: Column(
              children: <Widget>[
                Text(
                  'Update Student Details',
                  style: TextStyle(fontSize: 18.0),       
                ),
                SizedBox(height: 15.0,),
                TextFormField(
                    initialValue: userData.name,
                    decoration: textInputDecoration.copyWith( hintText: 'Full Names',),
                    validator: (val) => val.isEmpty ? 'Please enter full names' : null,
                    onChanged: (val) {
                    setState(() {
                      _currentname = val;
                    });
                    },
                     ),
                SizedBox(height: 15.0,),
                TextFormField(
                  initialValue: userData.regNo,
                    decoration: textInputDecoration.copyWith( hintText: 'Registration Number',),
                    validator: (val) => val.isEmpty ? 'Please enter Registration Number' : null,
                    onChanged: (val) {
                      setState(() {
                      _currentregNo = val;
                    });
                    },
                     ),
                SizedBox(height: 15.0,),     
                TextFormField(
                  initialValue: userData.course,
                       decoration: textInputDecoration.copyWith( hintText: 'Course',),
                       validator: (val) => val.isEmpty ? 'Please enter Course' : null,
                       onChanged: (val) {
                        setState(() {
                         _currentCourse = val;
                       });
                       },
                     ),
                SizedBox(height: 15.0,),
            
                RaisedButton(
                        color: Colors.blue[400],
                        child: Text(
                          'Update',
                          style: TextStyle(color: Colors.white),
                          ),
                          onPressed: ()async{
                            if(_formkey.currentState.validate()){
                              await DatabaseService(uid: user.uid).updateUserData(
                             
                                _currentname ?? userData.name,
                                _currentCourse ?? userData.course,
                                _currentregNo ?? userData.regNo
                                );
                                Navigator.pop(context);
                            }
                          },
                      )               
              ],
            
            ),
          );
          } else {
            return Loading();
          }
        }
      ),
    );
  }
}