import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:annapurna/classes/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../classes/profile.dart';

class Item extends StatefulWidget {
  final Inventory profile;
  Item({required this.profile,});

  @override
  _ItemState createState() => _ItemState();
}

class _ItemState extends State<Item> {
  List<String> id = [];
  List<String> mail = [];


  @override
  int f=0;
  Widget build(BuildContext context) {

    final Stream<QuerySnapshot> _usersStream =
    FirebaseFirestore.instance.collection('donor_profile').snapshots();
    _usersStream.forEach((profile) {
      profile.docs.asMap().forEach((index, data) {
        mail.add(profile.docs[index]['email']);
        id.add(profile.docs[index]['uid']);
        f=f+1;
      });
    });

    final dp = List<donor>.generate(
    f,
    (i) => donor(
    uid: id[i],
    email: mail[i],
    ));
    Inventory profile = widget.profile;
    return Scaffold(
      body:Column(
        children: [
          Text(profile.capacity),
          Text(profile.date),
       //   Text(profile.url),
          Text(profile.veg),
         // ElevatedButton(onPressed: ()=>
              // Navigator.push(
              // context,
              // MaterialPageRoute(
              //     builder: (context) => Mail(profile.userid,))), child: Text("")
         // )
        ],
      ),
    );
  }
}
