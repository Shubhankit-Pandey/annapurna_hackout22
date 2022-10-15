import 'package:annapurna/Screens/mail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../classes/profile.dart';

class Item extends StatefulWidget {
  final Inventory profile;
  Item({required this.profile,});

  @override
  _ItemState createState() => _ItemState();
}

class _ItemState extends State<Item> {
  @override
  Widget build(BuildContext context) {
    Inventory profile = widget.profile;
    return Scaffold(
      body:Column(
        children: [
          Text(profile.capacity),
          Text(profile.date),
       //   Text(profile.url),
          Text(profile.veg),
          ElevatedButton(onPressed: ()=>Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => mail(profile: profile,))), child: Text(""))
        ],
      ),
    );
  }
}
