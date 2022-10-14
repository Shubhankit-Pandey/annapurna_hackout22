// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:image_picker/image_picker.dart';
// import 'HomeScreen.dart';
//
//
// class Donate extends StatefulWidget {
//   String capacity;
//   String latitude;
//   String longitude;
//   String veg;
//   String date;
//   Donate(
//       {required this.capacity,
//         required this.latitude,
//         required this.longitude,
//         required this.veg,
//         required this.date});
//   @override
//   _DonateState createState() => _DonateState();
// }
//
// class _DonateState extends State<Donate> {
//   @override
//   String capacity='';
//   String latitude='';
//   String longitude='';
//   String veg='';
//   String date='';
//   String url='';
//   final _formKey = GlobalKey<FormState>();
//   File? _image;
//   Future<List<String>> avaiableDocuments() async {
//     List<String> ids = [];
//
//     final QuerySnapshot snapshot =
//     await FirebaseFirestore.instance.collection('product').get();
//     snapshot.docs.forEach((element) {
//       ids.add(element.id);
//     });
//     return ids;
//   }
//
//   Future<String> uploadPic() async {
//     FirebaseStorage storage = FirebaseStorage.instance;
//     Reference ref = storage.ref().child("image1" + DateTime.now().toString());
//     UploadTask uploadTask = ref.putFile(_image!);
//     uploadTask.whenComplete(() async {
//       url = await ref.getDownloadURL();
//     });
//     if (url != null)
//       return url!;
//     else {
//       return url = await ref.getDownloadURL();
//     }
//   }
//
//   Future getImage() async {
//     String capacity = widget.capacity;
//     String latitude = widget.latitude;
//     String longitude= widget.longitude;
//     String veg = widget.veg;
//     String date = widget.date;
//
//     try {
//       ImagePicker picker = ImagePicker();
//       XFile? image =
//       await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
//       if (image == null) return;
//       _image = File(image.path);
//       Reference ref = FirebaseStorage.instance.ref().child('${latitude}.jpg');
//       await ref.putFile(File(image!.path));
//       ref.getDownloadURL().then((value) async {
//         setState(() {
//           url = value;
//         });
//         url = await uploadPic();
//         DocumentReference productCollection =
//         FirebaseFirestore.instance.collection('Inventry').doc();
//         productCollection.set({
//           'capacity': capacity,
//           'latitude': latitude,
//           'longitude': longitude,
//           'veg/nonveg': veg,
//           'uid':productCollection.id,
//           'date': date,
//         });
//         uploadPic();
//         List<String> ids = await avaiableDocuments();
//         for (int i = 0; i < ids.length; i++) {
//           FirebaseFirestore.instance
//               .collection('product')
//               .doc(ids[i])
//               .update({'pid': ids[i]});
//         }
//       });
//     } on PlatformException catch (e) {
//       print('Failed to pick image: $e');
//     }
//   }
//
//   addproducts() async {}
//   final List<String> items = ['Lost', 'Found'];
//   Widget build(BuildContext context) {
//     String name = widget.name;
//     String uid = widget.uid;
//     return Scaffold(
//         appBar: new PreferredSize(
//           child: new Container(
//             color: Color.fromRGBO(92, 104, 211, .5),
//             padding:
//             new EdgeInsets.only(top: MediaQuery.of(context).padding.top),
//             child: new Padding(
//               padding:
//               const EdgeInsets.only(left: 30.0, top: 20.0, bottom: 20.0),
//               child: new Text(
//                 'Enter Details',
//                 style: new TextStyle(
//                     fontSize: 20.0,
//                     fontWeight: FontWeight.w500,
//                     color: Colors.white),
//               ),
//             ),
//           ),
//           preferredSize: new Size(MediaQuery.of(context).size.width, 150.0),
//         ),
//         body: Container(
//             padding: EdgeInsets.fromLTRB(9, 0, 9, 0),
//             child: SingleChildScrollView(
//                 child: Form(
//                   key: _formKey,
//                   child: Column(children: <Widget>[
//                     Container(
//                         child: SingleChildScrollView(
//                             reverse: true,
//                             child: Column(children: [
//                               SizedBox(
//                                 height: 30,
//                               ),
//                               _image != null
//                                   ? ClipRRect(
//                                 borderRadius: BorderRadius.circular(50.0),
//                                 child: Image.file(_image!,
//                                     width: 180,
//                                     height: 180,
//                                     fit: BoxFit.cover),
//                               )
//                                   : ClipRRect(
//                                   borderRadius: BorderRadius.circular(50.0),
//                                   child: FlutterLogo(size: 1)),
//                               SizedBox(height: 10.0),
//                               Padding(
//                                 padding: EdgeInsets.only(left: 20.0, right: 20.0),
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.only(left: 30.0, right: 30.0),
//                                 child: TextFormField(
//                                   decoration: InputDecoration(hintText: 'Name'),
//                                   validator: (val) => val!.isEmpty
//                                       ? 'please enter item name'
//                                       : null,
//                                   onChanged: (val) => setState(() => p_name = val),
//                                 ),
//                               ),
//                               SizedBox(height: 10.0),
//                               Padding(
//                                 padding: EdgeInsets.only(left: 20.0, right: 20.0),
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.only(left: 30.0, right: 30.0),
//                                 child: TextFormField(
//                                   decoration: InputDecoration(hintText: 'Details'),
//                                   validator: (val) => val!.isEmpty
//                                       ? 'please enter item description'
//                                       : null,
//                                   onChanged: (val) => setState(() => desc = val),
//                                 ),
//                               ),
//                               SizedBox(height: 20.0),
//                               Padding(
//                                 padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
//                                 child: SizedBox(
//                                   child: DecoratedBox(
//                                     decoration:
//                                     const BoxDecoration(color: Colors.white70),
//                                     child: Row(
//                                       children: [
//                                         FloatingActionButton(
//                                           onPressed: () {
//                                             getImage();
//                                           },
//                                           backgroundColor:
//                                           Color.fromRGBO(92, 104, 211, .5),
//                                           child: Icon(Icons.add_a_photo_outlined),
//                                         ),
//                                         Text(
//                                           '     Add item image',
//                                           style: TextStyle(
//                                               color: Colors.black87,
//                                               fontSize: 18,
//                                               fontWeight: FontWeight.w500),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               RaisedButton(
//                                 color: Colors.blue,
//
//                                 child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: <Widget>[
//                                          Text(
//                                             'Add',
//                                             style: TextStyle(
//                                                 color: Colors.white,
//                                                 fontSize: 20.0),
//                                           ),
//
//                                     ]),
//                                 onPressed: () async {
//                                   if (_formKey.currentState!.validate()) {
//                                     Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                             builder: (context) => HomeScreen()));
//                                   }
//                                 },
//                                                             )
//                             ])))
//                   ]),
//                 ))));
//   }
// }
