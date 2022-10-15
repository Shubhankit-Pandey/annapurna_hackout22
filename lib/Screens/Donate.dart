import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'HomeScreen.dart';

class Donate extends StatefulWidget {
  @override
  _DonateState createState() => _DonateState();
}

class _DonateState extends State<Donate> {
  @override
  String capacity = '';
  String latitude = '';
  String longitude = '';
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

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: new Text(
            'Enter Details',
            style: new TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
                color: Colors.white),
          ),
        ),
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
                          SizedBox(height: 10.0),
                          Padding(
                            padding: EdgeInsets.only(left: 20.0, right: 20.0),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 30.0, right: 30.0),
                            child: TextFormField(
                              decoration: InputDecoration(hintText: 'capacity'),
                              validator: (val) => val!.isEmpty
                                  ? 'please enter item name'
                                  : null,
                              onChanged: (val) =>
                                  setState(() => capacity = val),
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Padding(
                            padding: EdgeInsets.only(left: 20.0, right: 20.0),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 30.0, right: 30.0),
                            child: TextFormField(
                              decoration:
                                  InputDecoration(hintText: 'latitude '),
                              validator: (val) => val!.isEmpty
                                  ? 'please enter item description'
                                  : null,
                              onChanged: (val) =>
                                  setState(() => latitude = val),
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Padding(
                            padding: EdgeInsets.only(left: 20.0, right: 20.0),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 30.0, right: 30.0),
                            child: TextFormField(
                              decoration:
                                  InputDecoration(hintText: 'longitude '),
                              validator: (val) => val!.isEmpty
                                  ? 'please enter item description'
                                  : null,
                              onChanged: (val) =>
                                  setState(() => longitude = val),
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Padding(
                            padding: EdgeInsets.only(left: 20.0, right: 20.0),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 30.0, right: 30.0),
                            child: TextFormField(
                              decoration: InputDecoration(hintText: 'veg'),
                              validator: (val) => val!.isEmpty
                                  ? 'please enter item description'
                                  : null,
                              onChanged: (val) => setState(() => veg = val),
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Padding(
                            padding: EdgeInsets.only(left: 20.0, right: 20.0),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 30.0, right: 30.0),
                            child: TextFormField(
                              decoration: InputDecoration(hintText: 'date'),
                              validator: (val) => val!.isEmpty
                                  ? 'please enter item description'
                                  : null,
                              onChanged: (val) => setState(() => date = val),
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
                          RaisedButton(
                            color: Colors.blue,
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
            ))));
  }
}
