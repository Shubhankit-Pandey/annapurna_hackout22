import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../authentication/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../classes/database.dart';
import '../classes/user.dart';
import '../helper/loading.dart';
import 'HomeScreen.dart';

class RegisterDonor extends StatefulWidget {
  @override
  _RegisterDonorState createState() => _RegisterDonorState();
}

class _RegisterDonorState extends State<RegisterDonor> {
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
                child: new Container(
                    color: Colors.transparent,
                    padding:
                        EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
                    child: Form(
                        key: _formKey,
                        child: Column(children: <Widget>[
                          TextFormField(
                            decoration: InputDecoration(hintText: 'Email'),
                            validator: (val) =>
                                val!.isEmpty ? 'Please enter email' : null,
                            onChanged: (val) {
                              setState(() => email = val);
                            },
                          ),
                          SizedBox(height: 15.0),
                          TextFormField(
                            decoration: InputDecoration(hintText: 'Password'),
                            obscureText: true,
                            validator: (val) => val!.length < 6
                                ? 'Enter a password of 6 or more characters'
                                : null,
                            onChanged: (val) {
                              setState(() => password = val);
                            },
                          ),

                          SizedBox(height: 10.0),
                           RaisedButton(
                                child: Text(
                                  'Register',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'Mochiy Pop P One',
                                      color: Colors.white),
                                ),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    dynamic result = await _auth
                                        .register2WithEmailAndPassword(
                                      email,
                                      password,
                                    );
                                    if (result == null) {
                                     // print("hekko2");
                                      setState(() {
                                        error = 'please supply a valid email';
                                        loading = false;
                                      });
                                    } else {
                                     // print("hekko3");
                                      await DatabaseDonor(uid: user!.uid)
                                          .updateUserData(
                                      email,user!.uid
                                      );
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>HomeScreen()),
                                      );
                                    }
                                  }
                                }),
                          Text(
                            error,
                            style:
                                TextStyle(color: Colors.black, fontSize: 8.0),
                          ),

                        ]))))
          ]));
  }
}
