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
            body: Container(
                padding: EdgeInsets.fromLTRB(9, 0, 9, 0),
                child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(children: <Widget>[
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
                                    Text("Your Location", style: TextStyle()),
                                  ),
                                  Row(
                                    children: [
                                      Text('Veg',style: TextStyle(color: Colors.white),),
                                      Radio(
                                        value: "veg",
                                        groupValue:veg,
                                        onChanged: (value){
                                          setState(() {
                                            veg = value.toString();
                                          });
                                        },
                                      ),
                                      Text('Non-Veg',style: TextStyle(color: Colors.white),),
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
                                  SizedBox(height: 20.0),
                                  Container(
                                      width: 300,
                                      padding: EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 30),
                                      child: DropdownButtonFormField(
                                          dropdownColor:
                                          Color.fromRGBO(12, 65, 96, 0.5),
                                          focusColor: Color.fromRGBO(12, 65, 96, 0.5),
                                          items: items.map((items) {
                                            return DropdownMenuItem(
                                                child: Text('${items}'), value: items);
                                          }).toList(),
                                          onChanged: (val) {
                                            setState(() => capacity = val! as String);
                                          })),
                                  SizedBox(height: 10.0),
                                  Padding(
                                    padding: EdgeInsets.only(left: 20.0, right: 20.0),
                                  ),

                                  Padding(
                                    padding: EdgeInsets.only(left: 30.0, right: 30.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          border: Border.all( color: Color.fromARGB(
                                              0x77, 0x98, 0x31, 0x6A),)

                                      ),
                                      child: TextFormField(
                                        decoration: InputDecoration(hintText: ' Date',),style: TextStyle(),
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
                                            FloatingActionButton(
                                              onPressed: () {
                                                getImage();
                                              },
                                              backgroundColor:
                                              Color.fromRGBO(92, 104, 211, .5),
                                              child: Icon(Icons.add_a_photo_outlined),
                                            ),
                                            Text(
                                              '     Add item image',
                                              style: TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(
                                    style: ButtonStyle(
                                        foregroundColor: MaterialStateProperty.all(Colors.blue),
                                        backgroundColor: MaterialStateProperty.all(Colors.blue)
                                    ),
                                    child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            'Add',
                                            style: TextStyle(
                                                color: Colors.white, fontSize: 20.0),
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
                                  )
                                ])))
                      ]),
                    )))));
  }
}
