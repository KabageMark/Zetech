import 'package:flutter/material.dart';
import 'package:zetech_app/models/urls.dart';
import 'package:zetech_app/services/database.dart';

class Posters extends StatefulWidget {
  @override
  _PostersState createState() => _PostersState();
}

class _PostersState extends State<Posters> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Url>>(
          stream: DatabaseService().posterurls,
          builder: (context, snapshot) {
          
          List<Url> _posterData =  snapshot.data;

          return Container(
          child: Scaffold(
            body: Column(                                        
            children: <Widget>[                                         
              Flexible(                                             
                child:  ListView.builder(                            
                  padding:  EdgeInsets.all(8.0),                     
                  reverse: true, 
                  itemCount: _posterData.length,                                         
                  itemBuilder: (context,  index){
                    return Column(
                    children:  <Widget>[
                      Card(
                      child: ListTile(
                      title: Image.network(_posterData[index].url),                    
                    ),
                      ),
                      
                    ],
                  );
                  },                                 
                ),
              ),
            Divider(height: 1.0),  

            ],

          ),
          ),
          );

          }
    );
  }
}