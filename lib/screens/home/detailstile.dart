import 'package:flutter/material.dart';
import 'package:zetech_app/models/details.dart';
import 'package:zetech_app/screens/home/settings.dart';

class DetailsTile extends StatelessWidget {
  final Details detail;
  DetailsTile({this.detail});

  @override
  Widget build(BuildContext context) {

    void _showsettingspanel(){
      showModalBottomSheet(context: context,builder: (context) {
        return Container(
            padding: EdgeInsets.symmetric(vertical: 20,horizontal: 60),
            child: SettingsForm(),
        );
      });
    }
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
      margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: Column(
        children: <Widget>[
          ListTile(
          contentPadding: EdgeInsets.fromLTRB(40, 40, 40, 40),
          leading: Icon(Icons.person,size: 100,),
          title: Text(detail.name),
          subtitle: Text(detail.regNo ),
          ),
          ButtonBar(
            children: <Widget>[
              FlatButton(
                child: const Text('UPDATE DETAILS'),
                onPressed: () { 
                  _showsettingspanel();
                 },
              ),
              FlatButton(
                child: const Text('LISTEN'),
                onPressed: () { /* ... */ },
              ),
            ],
          ),
        ],
    ),
      )
    );
  }
}
