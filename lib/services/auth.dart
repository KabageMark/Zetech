import 'package:firebase_auth/firebase_auth.dart';
import 'package:zetech_app/models/user.dart';
import 'package:zetech_app/services/database.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;

 
  //Auth change user stream
  Stream<User> get user{

   return _auth.onAuthStateChanged.map(
     _userFromFirebaseUser);
     
  }

  //create firebase object based on user model
  User _userFromFirebaseUser(FirebaseUser user){

    return user != null ? User(uid: user.uid):null;
  }

  //sign in anonymously
  Future signInAnon() async {
     
  try{
   AuthResult result = await _auth.signInAnonymously();
   FirebaseUser user = result.user;
   return _userFromFirebaseUser(user);

  } 
   
  catch(e){
      print(e.toString());
      return null;
   }
  }

  //sign in with email and password
    Future signinEmailPassword(String email , String password) async {

      try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email,password:password );
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
      } 
      catch(e){
          print(e.toString());
          return null;
      }
}

  //register with email and password
  Future registerEmailPassword(String email , String password) async {

      try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email,password:password );
      FirebaseUser user = result.user;

      //create a new document
      await DatabaseService(uid: user.uid).updateUserData('name', 'course', 'regNo');
      await DatabaseService(uid: user.uid).updateNoticeBoard('Notice Board' , 'time' );
      return _userFromFirebaseUser(user);
      } 
      catch(e){
          print(e.toString());
          return null;
      }
}
  //sign out
  Future signOut() async {
     
    try{
    return await _auth.signOut();

    } 

    catch(e){
      print(e.toString());
      return null;
    }
}
}