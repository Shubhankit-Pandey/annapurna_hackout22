import 'package:annapurna/Screens/Donate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../authentication/authentication.dart';
import '../classes/database.dart';
import '../classes/user.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import '../helper/loading.dart';
import 'LoginNgo.dart';
import 'dart:io';


class RegisterNgo extends StatefulWidget {
  @override
  _RegisterNgoState createState() => _RegisterNgoState();
}

class _RegisterNgoState extends State<RegisterNgo> {
  File? _image;
  String url = '';
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
      Reference ref = FirebaseStorage.instance.ref().child('${url}.jpg');
      await ref.putFile(File(image!.path));
      ref.getDownloadURL().then((value) async {
        setState(() {
          url = value;
        });
        url = await uploadPic();
        uploadPic();
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  addproducts() async {}
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String password = '';
  String email = '';
  String error = '';
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Usser?>(context);
    return loading? Loading():Scaffold(
        body: Stack(children: <Widget>[
          SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 150,
                  ),
                 Padding(
                   padding:
                   EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                   child: Container(
                       decoration: BoxDecoration(
                           border: Border.all(
                               width: 3,
                               color:
                               const Color.fromARGB(0xFF, 0x98, 0x31, 0x6A)),
                           borderRadius: BorderRadius.circular(30),
                           color: Colors.white),
                       height: MediaQuery.of(context).size.height*0.58,
                        padding:
                        EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                        child: Form(
                            key: _formKey,
                            child: Column(children: <Widget>[
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Email',
                                  hintStyle: TextStyle(
                                      fontSize: 23,
                                      color:
                                      Color.fromARGB(0xFF, 0x98, 0x31, 0x6A),
                                      fontWeight: FontWeight.w400),
                                ),
                                validator: (val) =>
                                val!.isEmpty ? 'Please enter email' : null,
                                onChanged: (val) {
                                  setState(() => email = val);
                                },
                              ),
                              SizedBox(height: 25.0),
                              TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Password',
                                  hintStyle: TextStyle(
                                      fontSize: 23,
                                      color:
                                      Color.fromARGB(0xFF, 0x98, 0x31, 0x6A),
                                      fontWeight: FontWeight.w400),
                                ),
                                obscureText: true,
                                validator: (val) => val!.length < 6
                                    ? 'Enter a password of 6 or more characters'
                                    : null,
                                onChanged: (val) {
                                  setState(() => password = val);
                                },
                              ),

                              SizedBox(height: 20.0),
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
                                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(14)
                                      )),
                                      backgroundColor: MaterialStateProperty.all(Color.fromARGB(0xFF, 0x98, 0x31, 0x6A))
                                  ),
                                  child: Text(
                                    'Register',
                                    style: TextStyle(
                                        fontFamily: 'Mochiy Pop P One',
                                        color: Colors.white,
                                        fontSize: 18),
                                  ),
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      dynamic result = await _auth
                                          .registerWithEmailAndPassword(
                                        email,
                                        password,
                                      );
                                      if (result == null) { print("result1$email");
                                        setState(() {
                                          error = 'please supply a valid email';
                                          loading = false;
                                        });
                                      } else {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>Donate(lat:0,long:0)),
                                        );
                                        await DatabaseNGO(uid: user!.uid)
                                            .updateUserData(
                                          email,user!.uid,
                                        );
                                        }
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Donate(lat:0,long:0))
                                        );
                                      }

                                  }),

                              Row(
                                children: [
                                  SizedBox(
                                    width: 30,
                                  ),
                                  Text("Already have an account?",
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              0x77, 0x98, 0x31, 0x6A),
                                          fontWeight: FontWeight.normal)),
                                  TextButton(
                                      onPressed: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => LoginNgo()),
                                      ),
                                      child: Text(
                                        "Sign In",
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                0xFF, 0x98, 0x31, 0x6A),
                                            fontWeight: FontWeight.w400),
                                      ))
                                ],
                              ),

                            ]))),
                 ),
                ],
              )),
          Positioned(
            child: Image(image: AssetImage('images/reciever-image-1.png')),
            top: MediaQuery.of(context).size.height * 0.12,
            left: MediaQuery.of(context).size.width * 0.3,
          ),
        ]));
  }
}
