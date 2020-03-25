import 'dart:io';
import 'package:flutter/material.dart';
import 'package:zetech_app/models/notice.dart';
import 'package:zetech_app/models/urls.dart';
import 'package:zetech_app/screens/home/imagehandler.dart';
import 'package:zetech_app/services/database.dart';


class NoticeBoard extends StatefulWidget {
  @override
  _NoticeBoardState createState() => _NoticeBoardState();
}

class _NoticeBoardState extends State<NoticeBoard> {

final noticeController = TextEditingController();
final String  time = DateTime.now().weekday.toString();


  @override
  Widget build(BuildContext context) {
    
    return Container(
      child: StreamBuilder<List<Notice>>(
        stream: DatabaseService().noticeDetails,
        builder: (context, snapshot) {
          
          List<Notice> _noticeData =  snapshot.data;
          
     
            void _handleSubmitted(String text , String time) async{
               text = noticeController.text; 
               await DatabaseService().updateNoticeBoard(text ?? _noticeData ,time);
              noticeController.clear();

            }

          if(snapshot.hasData){
          return Container(
            
            child: Scaffold(
              body: Column(     
                                                   
              children: <Widget>[                                         
                Flexible(                                             
                  child:  ListView.builder(                            
                    padding:  EdgeInsets.all(8.0),                     
                    reverse: true, 
                    itemCount: _noticeData.length,                                         
                    itemBuilder: (context,  index){
                        return Card(
                        child: ListTile(
                        title: Text(_noticeData[index].notice),
                        subtitle: Text(_noticeData[index].time),                    
                      ),
                        );
                        
                    },                                 
                  ),
                ),
              Divider(height: 1.0),                                 
            Container(                                                            
          child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                IconButton(
                      icon: Icon(Icons.add_a_photo),
                      onPressed: (){
                      Navigator.push(context,
                     MaterialPageRoute(builder: (context) => ImageHandler()),
                     );                     
                      }
                )
                
              ],
            ),
             Flexible(
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,

                children: [
                TextField(
                controller: noticeController,
                decoration: InputDecoration(
                  hintText: 'Post a message on Noticeboard'
                ),
                )
                ],
              ),
            ),
            Column( 
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () {
                      _handleSubmitted(noticeController.text ,time );                                                   
                      },
                      )
              ],
            ),
          ],
        ),
      )
   
             ],
           ),                                                                                                               //new
          ),
          ); 
         } else  {
          return Card(
           child: ListTile(
           title: Text('Notice Board is Empty'),
           ),
          );

         }
        }
       ),
     );
    }   
  }                                                           






    
       
