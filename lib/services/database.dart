import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:zetech_app/models/details.dart';
import 'package:zetech_app/models/notice.dart';
import 'package:zetech_app/models/urls.dart';
import 'package:zetech_app/models/user.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DatabaseService{
  
  final String uid;
  //This is a constructor for the class
  DatabaseService({this.uid});

  //collection Reference 
  final CollectionReference zetechUsers = Firestore.instance.collection('ZetechUsers');
  final CollectionReference zetechNoticeBoardMessages = Firestore.instance.collection('NoticeBoardMessages');
  final CollectionReference zetechNoticeBoardImages = Firestore.instance.collection('NoticeBoardImages');

  //function for updating userdata
  Future updateUserData(String name,String course , String regNo ) async{
    return await zetechUsers.document(uid).setData({
          'name': name,
          'course':course,
          'regNo' :regNo,
        
  });
  }

//Function for posting messsage on notice board
  Future updateNoticeBoard(String notice , String time) async{
    return await zetechNoticeBoardMessages.add({
          'notice': notice,
          'time' : time,
  
  });
  }

//Function for saving image url on notice board collection
  Future updatePosterUrl(String url ) async{
    return await zetechNoticeBoardImages.add({
          'url': url,
  
  });
  }

//Function for uploading image on notice board

  Future uploadImage( File image ) async{
  

  String fileName = 'images/${DateTime.now()}.png';


   final StorageReference zetechNoticeBoardImages = FirebaseStorage.instance.ref().child(fileName);

   StorageUploadTask uploadTask = zetechNoticeBoardImages.putFile(image);

   StorageTaskSnapshot snapshot = await uploadTask.onComplete;

   
   
    String  downloadUrl =  await snapshot.ref.getDownloadURL();
    
    print('File Uploaded');
    
    
    updatePosterUrl(downloadUrl.toString());
    
    
   
    print('Error from image repo ${snapshot.error.toString()}');
    
   return downloadUrl;
  
  }
  
  //Quering student details from Snapshot
  List<Details> _userDetailsFromSnapshot(QuerySnapshot snapshot){
          
    return snapshot.documents.map((doc){
          return Details(
            regNo: doc.data['regNo'] ?? 'regNo',
            name: doc.data['name'] ?? 'name',
            course: doc.data['course'] ?? 'course',
            

          );
    }).toList();
  }

  //Querying Noticeboard messages from snapshot
   List<Notice> _noticeDetailsFromSnapshot(QuerySnapshot snapshot){
          
    return snapshot.documents.map((doc){
          return Notice(
            notice: doc.data['notice'] ?? 'Notice Board is Empty',
            time: doc.data['time'] ?? 'Time is not specified',


          );
    }).toList();
  }
  
    //Querying Noticeboardimages urls from snapshot
   List<Url> _noticeImagesFromSnapshot(QuerySnapshot snapshot){
          
    return snapshot.documents.map((doc){
          return Url(
            url: doc.data['url'] ?? 'No posters available',

          );
    }).toList();
  }

  //stream for details
  Stream<List<Details>> get userDetails {
    return  zetechUsers.snapshots().map(_userDetailsFromSnapshot);
  }

  //stream for noticeboard messages
  Stream<List<Notice>> get noticeDetails {
    return  zetechNoticeBoardMessages.snapshots().map(_noticeDetailsFromSnapshot);
  }

   //stream for noticeboard posters
  Stream<List<Url>> get posterurls {
    return  zetechNoticeBoardImages.snapshots().map(_noticeImagesFromSnapshot);
  }
  
//user data from snapshot
UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
  return UserData(
    uid: uid,
    name: snapshot.data['name'],
    course: snapshot.data['course'],
    regNo: snapshot.data['regNo']

  );
  
}


//get user doc String
 Stream<UserData> get userData{
   return  zetechUsers.document(uid).snapshots().map(_userDataFromSnapshot);
 }

}