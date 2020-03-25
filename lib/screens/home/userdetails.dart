import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zetech_app/models/details.dart';
import 'package:zetech_app/screens/home/detailstile.dart';

class UserDetails extends StatefulWidget {
  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  @override
  Widget build(BuildContext context) {
    final userdetails = Provider.of<List<Details>>(context) ?? [];
    
   
    return ListView.builder(
      itemCount: userdetails.length,
      itemBuilder: (context , index) {
        return DetailsTile(detail :userdetails[index]);
      },
    );
  }
}
