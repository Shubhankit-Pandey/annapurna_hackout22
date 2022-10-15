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
      backgroundColor: const Color.fromARGB(
          0xFF, 0x98, 0x31, 0x6A),
      body: Column(
        children: <Widget>[
          SizedBox(height: 40,),
          Container(
            padding: const EdgeInsets.fromLTRB(35, 43,35,0),
            // width: MediaQuery.of(context).size.width,
            // height: MediaQuery.of(context).size.height * 0.4,
            child: const Image(
                image: AssetImage("images/donate.png"),
                // colorBlendMode: BlendMode.overlay,
                alignment: Alignment.center),
          ),
          Container(
            height: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 40,),
                Text(
                  'Heyy !',
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    color: Color.fromARGB(0xFF, 0xF9, 0xF9, 0xF9),
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  ' Who are you ?',
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    color: Color.fromARGB(0xFF, 0xF9, 0xF9, 0xF9),
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
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
                    // margin: const EdgeInsets.all(10),
                    // padding: const EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width * 0.49,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      border: Border.all(width: 2, color: d),
                      borderRadius: BorderRadius.circular(10),

                    ),

                    child: Column(
                      children: [
                        TextButton(
                          child: Container(
                            child: const Image(
                              image: AssetImage("images/donor-image-1.png"),
                              height:100,
                            ),
                          ),
                          onPressed: () => { Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>RegisterDonor()),)
                          },
                        ),
                        //  SizedBox(height: 10,),
                        Text(
                          'Donor',
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            color: Color.fromARGB(0xFF, 0xF9, 0xF9, 0xF9),
                            fontSize: 19,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
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
                      border: Border.all(width: 2, color: d),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        TextButton(
                          child: Container(
                            child: const Image(
                              image: AssetImage("images/reciever-image-1.png"),
                              height:80,
                            ),
                          ),
                          onPressed: () => { Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>RegisterNgo()),
                          )},
                        ),
                        // SizedBox(height: 20,),
                        Text(
                          'Reciever',
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            color: Color.fromARGB(0xFF, 0xF9, 0xF9, 0xF9),
                            fontSize: 19,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
