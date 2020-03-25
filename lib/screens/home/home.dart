
import 'package:flutter/material.dart';
import 'package:zetech_app/models/details.dart';
import 'package:zetech_app/screens/home/notice.dart';
import 'package:zetech_app/screens/home/posters.dart';
import 'package:zetech_app/screens/home/settings.dart';
import 'package:zetech_app/screens/home/userdetails.dart';
import 'package:zetech_app/services/auth.dart';
import 'package:zetech_app/services/database.dart';
import 'package:provider/provider.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}
int selectedIndex  = 0;

List<Widget> widgetOptions = <Widget> [
    
    new UserDetails(),
    new NoticeBoard(),
    new Posters()    
    
];

class _HomeState extends State<Home> {
  @override
  final AuthService _auth = AuthService();


  Widget build(BuildContext context) {

      void _onItemTapped(int index) {
        setState(() {
           selectedIndex  = index;
        });   
    }
    return StreamProvider<List<Details>>.value(
      value: DatabaseService().userDetails,
        child: Scaffold(
        backgroundColor: Colors.blue[50],
        appBar: AppBar(
          title: Text('Notice Board'),
          backgroundColor: Colors.blue[400],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon:Icon (Icons.person),
              label: Text('Logout'),
              onPressed: () async{
                await _auth.signOut();
              },
              )
          ],
        ),
        body: 
           widgetOptions.elementAt(selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex:  selectedIndex,
            selectedItemColor: Colors.blue[800],
            onTap: _onItemTapped,

            items:  <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home , color: Color.fromARGB(255, 0, 0, 0)),
                title: Text('Home'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.mail ,color: Color.fromARGB(255, 0, 0, 0) ),
                title: Text('Notice'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings , color: Color.fromARGB(255, 0, 0, 0)),
                title: Text('Settings'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.image , color: Color.fromARGB(255, 0, 0, 0) ),
                title: Text('Posters'),
              )
            ],
            
          ),
              
      ),
    );
  }
}

