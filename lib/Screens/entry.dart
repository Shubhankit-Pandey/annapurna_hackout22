import 'package:annapurna/Screens/RegisterNgo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'RegisterDonor.dart';

class Enter extends StatefulWidget {
  const Enter({Key? key}) : super(key: key);

  @override
  _EnterState createState() => _EnterState();
}

class _EnterState extends State<Enter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [

          RaisedButton(
            color: Colors.blue,
            child: Text(
              'Donor',
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Mochiy Pop P One',
                  color: Colors.white),
            ),
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RegisterDonor()),
              );
            },
          ),
          RaisedButton(
            color: Colors.blue,
              child: Text(
                'Receiver',
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Mochiy Pop P One',
                    color: Colors.white),
              ),
              onPressed: () async {

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterNgo()),
                );
              })
        ],
      ),
    );
  }
}
