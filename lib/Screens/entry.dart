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
  Color c = const Color(0xFF98316A);
  Color d = const Color(0xFFF9F9F9);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: c,
              border: Border.all(
                color: c,
                width: 0,
              ),
            ),
            padding: const EdgeInsets.all(40),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.4,
            // color: Colors.purple,
            child: const Image(
                image: AssetImage('assets/screen_images/food.jpg'),
                // colorBlendMode: BlendMode.overlay,
                alignment: Alignment.center),
          ),
          Container(
            decoration: BoxDecoration(
              color: c,
              border: Border.all(
                color: c,
                width: 0,
              ),
            ),
            padding: const EdgeInsets.all(0),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.3,
            // color: Colors.purple,
            child: const Text(
              '\n  Hi! \n  Who are you ?',
              style: TextStyle(
                decoration: TextDecoration.none,
                color: Color.fromARGB(0xFF, 0xF9, 0xF9, 0xF9),
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(1),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.2,
            color: c,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width * 0.49,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: d),
                      borderRadius: BorderRadius.circular(10),
                      // image: const DecorationImage(
                      //   image: AssetImage('assets/screen_images/food.jpg'),
                      //   fit: BoxFit.fill,
                      // ),
                    ),
                    child: TextButton(
                      child: Container(
                        child: const Image(
                          image: AssetImage('assets/screen_images/food.jpg'),
                        ),
                      ),
                      onPressed: () => {},
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width * 0.49,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: d),
                      borderRadius: BorderRadius.circular(10),
                      // image: const DecorationImage(
                      //   image: AssetImage('assets/screen_images/food.jpg'),
                      //   fit: BoxFit.fill,
                      // ),
                    ),
                    child: TextButton(
                      child: Container(
                        child: const Image(
                          image: AssetImage('assets/screen_images/food.jpg'),
                        ),
                      ),
                      onPressed: () => {},
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: c,
              border: Border.all(
                color: c,
                width: 0,
              ),
            ),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.1,
          )
        ],
      ),
    );
  }
}
