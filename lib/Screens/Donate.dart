import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'HomeScreen.dart';
import 'maps.dart';

class Donate extends StatefulWidget {

 double lat;
 double long;
  Donate({required this.lat, required this.long});
  @override
  _DonateState createState() => _DonateState();
}

class _DonateState extends State<Donate> {
  @override
  String capacity = '';
  double latitude = 0;
  double longitude = 0;
  String veg = '';
  String date = '';
  String url = '';
  final _formKey = GlobalKey<FormState>();
  File? _image;
  Future<List<String>> avaiableDocuments() async {
    List<String> ids = [];

    final QuerySnapshot snapshot =
    await FirebaseFirestore.instance.collection('Inventory').get();
    snapshot.docs.forEach((element) {
      ids.add(element.id);
    });
    return ids;
  }

  Future<String> uploadPic() async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child("image1" + DateTime.now().toString());
    UploadTask uploadTask = ref.putFile(_image!);
    uploadTask.whenComplete(() async {
      url = await ref.getDownloadURL();
    });
    if (url != null)
      return url!;
    else {
      return url = await ref.getDownloadURL();
    }
  }

  Future getImage() async {
    try {
      ImagePicker picker = ImagePicker();
      XFile? image =
      await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
      if (image == null) return;
      _image = File(image.path);
      Reference ref = FirebaseStorage.instance.ref().child('${latitude}.jpg');
      await ref.putFile(File(image!.path));
      ref.getDownloadURL().then((value) async {
        setState(() {
          url = value;
        });
        url = await uploadPic();
        DocumentReference productCollection =
        FirebaseFirestore.instance.collection('Inventory').doc();
        productCollection.set({
          'capacity': capacity,
          'latitude': latitude,
          'longitude': longitude,
          'veg': veg,
          'userid': productCollection.id,
          'date': date,
          'productid':"",
        });
        uploadPic();
        List<String> ids = await avaiableDocuments();
        for (int i = 0; i < ids.length; i++) {
          FirebaseFirestore.instance
              .collection('Inventory')
              .doc(ids[i])
              .update({'productid': ids[i]});
        }
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  addproducts() async {}
  final List<String> items = ['10-30', '30-50','50-80','80-120','100-200','200-300'];
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Column(
              children: [
                //SizedBox(height: 40,),
                Container(
                    padding: EdgeInsets.fromLTRB(9, 0, 9, 0),
                    child: SingleChildScrollView(
                        child: Form(
                          key: _formKey,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Stack(
                              children: [

                                Column(
                                  children: [
                                    SizedBox(height:
                                    80,),
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(width: 1.8,color:  const Color.fromARGB(
                                            0xFF, 0x98, 0x31, 0x6A),),
                                        borderRadius: BorderRadius.circular(13),
                                      ),
                                      child: Column(children: <Widget>[
                                        // SizedBox(height:
                                        // 30,),
                                        Container(
                                            child: SingleChildScrollView(
                                                reverse: true,
                                                child: Column(children: [
                                                  SizedBox(
                                                    height: 30,
                                                  ),
                                                  _image != null
                                                      ? ClipRRect(
                                                    borderRadius: BorderRadius.circular(50.0),
                                                    child: Image.file(_image!,
                                                        width: 180,
                                                        height: 180,
                                                        fit: BoxFit.cover),
                                                  )
                                                      : ClipRRect(
                                                      borderRadius: BorderRadius.circular(50.0),
                                                      child: FlutterLogo(size: 1)),
                                                  TextButton(
                                                    onPressed: () => Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) => Home())),
                                                    child:
                                                    Container(
                                                      width: MediaQuery.of (context).size.width*0.8,
                                                      height: MediaQuery.of(context).size.height*0.1,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(width: 1.8,color:  const Color.fromARGB(
                                                            0xFF, 0x98, 0x31, 0x6A),),
                                                        borderRadius: BorderRadius.circular(13),
                                                      ),
                                                      child: Row(children: [
                                                        Container(
                                                            width:MediaQuery.of (context).size.width*0.28,
                                                            height:MediaQuery.of (context).size.height*0.05 ,
                                                            child: Image.asset('images/location.png',alignment: Alignment.centerRight,),
                                                        ),
                                                        Text("Your Location", style: TextStyle(fontSize: 20,color:  const Color.fromARGB(
                                                            0xFF, 0x98, 0x31, 0x6A),),textAlign: TextAlign.left,),
                                                      ],
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 20.0,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Container(
                                                        margin: const EdgeInsets.all(12),
                                                        width:MediaQuery.of (context).size.width*0.3,
                                                        height:MediaQuery.of (context).size.height*0.05 ,
                                                        alignment: Alignment.center,
                                                        decoration: BoxDecoration(
                                                          border: Border.all(width: 1.8,color:  const Color.fromARGB(
                                                              0xFF, 0x98, 0x31, 0x6A),),
                                                          borderRadius: BorderRadius.circular(5.0),
                                                          color:  const Color.fromARGB(
                                                              0xFF, 0x98, 0x31, 0x6A),
                                                        ),
                                                        child:const Text('Food Type: ',
                                                          style: TextStyle(
                                                            fontSize: 20,
                                                            color: Colors.white,
                                                        ),
                                                        ),
                                                      ),
                                                      Container(
                                                        width:MediaQuery.of (context).size.width*0.15,
                                                        height:MediaQuery.of (context).size.height*0.05 ,
                                                        child: Image.asset('images/veg.png',alignment:Alignment.centerRight,),
                                                      ),
                                                      Radio(
                                                        value: "veg",
                                                        groupValue:veg,
                                                        onChanged: (value){
                                                          setState(() {
                                                            veg = value.toString();
                                                          },);
                                                        },
                                                      ),
                                                      Container(
                                                        width:MediaQuery.of (context).size.width*0.1,
                                                        height:MediaQuery.of (context).size.height*0.05 ,
                                                        child: Image.asset('images/nonveg.jpeg',alignment:Alignment.center),
                                                      ),
                                                      Radio(
                                                        value: "nonveg",
                                                        groupValue: veg,
                                                        onChanged: (value){
                                                          setState(() {
                                                            veg = value.toString();
                                                          });
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(left: 20.0, right: 20.0),
                                                  ),
                                                 // SizedBox(height: 20.0),
                                                  Container(
                                                    alignment: Alignment.centerRight,
                                                      width: MediaQuery.of (context).size.width,
                                                      height: MediaQuery.of(context).size.height*0.1,
                                                      padding: EdgeInsets.symmetric(
                                                          vertical: 0, horizontal: 15),
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            alignment: Alignment.centerLeft,
                                                            width: MediaQuery.of (context).size.width*0.25 ,
                                                            height: MediaQuery.of(context).size.height*0.12,
                                                            child: Text(
                                                                "Number of people to feed:  ",
                                                                style: TextStyle(
                                                                  fontSize: 16.0,
                                                                  color:  const Color.fromARGB(
                                                                      0xFF, 0x98, 0x31, 0x6A),
                                                                  decoration: TextDecoration.none,
                                                                  decorationColor: Colors.redAccent,
                                                                ),textAlign: TextAlign.center),
                                                          ),
                                                          Container(
                                                            width: MediaQuery.of (context).size.width*0.5 ,
                                                            alignment: Alignment.centerRight,
                                                            child: DropdownButtonFormField(
                                                                dropdownColor: const Color.fromARGB(
                                                                    0x66, 0x98, 0x31, 0x6A),
                                                                focusColor: Color.fromRGBO(12, 65, 96, 0.5),
                                                                items: items.map((items) {
                                                                  return DropdownMenuItem(
                                                                      child: Text('${items}',style: TextStyle(fontSize: 17),), value: items);
                                                                }).toList(),
                                                                onChanged: (val) {
                                                                  setState(() => capacity = val! as String);
                                                                }),
                                                          ),
                                                        ],
                                                      )),
                                                  SizedBox(height: 10.0),
                                                  Padding(
                                                    padding: EdgeInsets.only(left: 20.0, right: 20.0),
                                                  ),

                                                  Padding(
                                                    padding: EdgeInsets.only(left: 20.0, right: 20.0),
                                                    child: Container(
                                                      alignment: Alignment.center,
                                                      width: MediaQuery.of (context).size.width*0.9,
                                                      height: MediaQuery.of(context).size.height*0.1,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(width: 1.8,color:  const Color.fromARGB(
                                                            0xFF, 0x98, 0x31, 0x6A),),
                                                        borderRadius: BorderRadius.circular(13),
                                                      ),
                                                      child: TextFormField(
                                                        decoration: InputDecoration(hintText: '    Date',),style: TextStyle(fontSize: 20,color:  const Color.fromARGB(
                                                          0xFF, 0x98, 0x31, 0x6A),),
                                                        validator: (val) => val!.isEmpty
                                                            ? 'please enter a valid date'
                                                            : null,
                                                        onChanged: (val) => setState(() => date = val),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 20.0),
                                                  Padding(
                                                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                                                    child: SizedBox(
                                                      child: DecoratedBox(
                                                        decoration:
                                                        const BoxDecoration(color: Colors.white70),
                                                        child: Row(
                                                          children: [
                                                            SizedBox(width: 17,),
                                                            FloatingActionButton(
                                                              onPressed: () {
                                                                getImage();
                                                              },
                                                              backgroundColor:
                                                              const Color.fromARGB(
                                                                  0x99, 0x98, 0x31, 0x6A),
                                                              child: Icon(Icons.add_a_photo_outlined),
                                                            ),
                                                            Text(
                                                              '     Add food image',
                                                              style: TextStyle(
                                                                  color:  const Color.fromARGB(
                                                                      0xFF, 0x98, 0x31, 0x6A),
                                                                  fontSize: 20,
                                                                  fontWeight: FontWeight.w500),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 40,),
                                                  ElevatedButton(
                                                    style: ButtonStyle(
                                                        foregroundColor: MaterialStateProperty.all( const Color.fromARGB(
                                                            0xFF, 0x98, 0x31, 0x6A),),
                                                        backgroundColor: MaterialStateProperty.all( const Color.fromARGB(
                                                            0xFF, 0x98, 0x31, 0x6A),)
                                                    ),
                                                    child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: <Widget>[
                                                          Padding(
                                                            padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 25),
                                                            child: Text(
                                                              'Add',
                                                              style: TextStyle(
                                                                  color: Colors.white, fontSize: 28.0),
                                                            ),
                                                          ),
                                                        ]),
                                                    onPressed: () async {
                                                      if (_formKey.currentState!.validate()) {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) => HomeScreen()));
                                                      }
                                                    },
                                                  ),
                                                  SizedBox(height: 30,),
                                                ])))
                                      ]),
                                    ),
                                  ],
                                ),
                                Positioned(
                                  child: Image(image: AssetImage('images/donor-image-1.png')),
                                  top: MediaQuery.of(context).size.height * 0.00000001,
                                  left: MediaQuery.of(context).size.width * 0.28,
                                ),
                              ],
                            ),
                          ),
                        ))),
              ],
            )));
  }
}
