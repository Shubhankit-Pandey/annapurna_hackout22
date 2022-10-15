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
      onPressed: () {},
      child: Row(
        children: [
          Container(
            height: 300,
            width: 150,
            decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.black, width: 3),
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
                      "Images/img.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Text(
                  profile.capacity,
                  style: TextStyle(fontSize: 17),
                ),
                Text(
                  profile.date,
                  style: TextStyle(fontSize: 17),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
