import 'package:annapurna/classes/profile.dart';
import 'package:annapurna/helper/tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../authentication/authentication.dart';
import '../classes/user.dart';
import '../helper/notfound.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String password = '';
  String email = '';
  String error = '';

  @override

  Widget build(BuildContext context) {
    int c = 0;
    List<String> cap = [];
    List<String> url = [];
    List<String> date = [];
    List<double> lat = [];
    List<double> long = [];
    List<String> pid = [];
    List<String> veg = [];
    List<String> uid = [];
    final user = Provider.of<Usser?>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Food Available",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
        backgroundColor: Color.fromARGB(0xFF, 0x98, 0x31, 0x6A),
        actions: [ElevatedButton(

          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Color.fromARGB(0xFF, 0x98, 0x31, 0x6A))
          ),
          child: IconButton(
            tooltip: "Sign Out",
            onPressed: () async { await _auth.signOut();

            },
              icon: Icon(Icons.logout_rounded)),
          onPressed: () async {
            await _auth.signOut();
          },
        ),],

    ),
        body:
        //SafeArea(
            // child: Scaffold(
            //   body: SingleChildScrollView(
                 SingleChildScrollView(
                   child: Container(

                      child:  StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('Inventory')
                                .snapshots(),
                            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (!snapshot.hasData) {
                                return Center(child: CircularProgressIndicator());
                              }
                              final documentSnapshotList = snapshot.data!.docs;
                              documentSnapshotList.forEach((element) {
                              //  url.add(element['url']);
                                cap.add(element['capacity']);
                                veg.add(element['veg']);
                                date.add(element['date']);
                                lat.add(element['latitude']);
                                long.add(element['longitude']);
                                uid.add(element['userid']);
                                pid.add(element['productid']);
                                                           });
                              c=documentSnapshotList.length;

                              if (!snapshot.hasData) {
                                return Center(child: Text("snapshot has no data"));
                              } else {
                                if (c == 0) {
                                  return Flash();
                                } else {
                                  final profile = List<Inventory>.generate(
                                      c,
                                          (i) => Inventory(
                                        capacity: cap[i],
                                        latitude: lat[i],
                                        longitude: long[i],
                                        veg: veg[i],
                                        productid: pid[i],
                                        userid: uid[i],
                                        date: date[i],
                                        //    url: url[i],
                                      ));

                                  return GridView.builder(
                                    
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 20,
                                    ),
                                    padding: EdgeInsets.all(25),
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return Tile(profile: profile[index], ind: index);
                                    },
                                    itemCount: profile.length,
                                    shrinkWrap: true,
                                  );
                                }
                              }
                            })
                    //   ],
                    // ),
    ),
                 ));
            //     ),
            //   ),
            // )));
  }
}
