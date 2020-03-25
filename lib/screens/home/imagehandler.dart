import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:zetech_app/services/database.dart';
class ImageHandler extends StatefulWidget {
  @override
  _ImageHandlerState createState() => _ImageHandlerState();
}
File  _image;


class _ImageHandlerState extends State<ImageHandler> {
  @override
  Widget build(BuildContext context) {
    
     Future _uploadImage(File image) async{
        await DatabaseService().uploadImage(image);
     
     }
     Future getImage() async {
        var image = await ImagePicker.pickImage(source: ImageSource.gallery);

        setState(() {
          _image = image;
        });
        
     }

    return Scaffold(
      appBar: AppBar(
        title: Text("Image Handler"),
      ),
      body:Column(
     mainAxisSize: MainAxisSize.min,
      children: <Widget>[
         Center(
         child:_image == null ? Text('No image selected.') : Image.file(_image),
          ),
          IconButton(
          icon: Icon(Icons.add_a_photo),
          onPressed: (){    
            getImage();                  
          }
          )
    ],
     ),

      floatingActionButton: FloatingActionButton(
      onPressed: () {
         Navigator.pop(context);
        _uploadImage(_image);
       
      },
      child: Icon(Icons.arrow_forward),
      backgroundColor: Colors.lightBlue,
    ),        
      );
  }
}