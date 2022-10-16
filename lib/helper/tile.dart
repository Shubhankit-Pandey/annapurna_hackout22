import 'package:annapurna/Screens/itemscreen.dart';
import 'package:annapurna/classes/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Tile extends StatefulWidget {
  final Inventory profile;
  int ind;
  Tile({required this.profile, required this.ind});


  @override
  _TileState createState() => _TileState();
}

class _TileState extends State<Tile> {
  @override
  Widget build(BuildContext context) {
   Inventory profile = widget.profile;
    return TextButton(
      onPressed: () {  Navigator.push(
          context,
          MaterialPageRoute(
          builder: (context) => Item(profile: profile)));},
      child: Row(
        children: [
          Container(
            height: 300,
            width: 150,
            decoration: BoxDecoration(
                border: Border.all(
                    color: Color.fromARGB(0xff, 0x98, 0x31, 0x6A), width: 1.2),
                color: Colors.white,
                borderRadius:
                BorderRadius.circular(20)),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all( ),
                      borderRadius:
                      BorderRadius.circular(400)),
                  height: MediaQuery.of(context)
                      .size
                      .height *
                      0.122,
                  width: MediaQuery.of(context)
                      .size
                      .width *
                      0.27,
                  child: ClipRRect(
                    borderRadius:
                    BorderRadius.circular(15),
                    child: Image.asset(
                      "Images/food.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Text(
                  profile.capacity,
                  style: TextStyle(fontSize: 15,color: Color.fromARGB(0xFF, 0x98, 0x31, 0x6A)),
                ),
                Text(
                  profile.date,
                  style: TextStyle(fontSize: 15,color: Color.fromARGB(0xFF, 0x98, 0x31, 0x6A)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
