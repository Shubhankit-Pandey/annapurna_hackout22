import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/cupertino.dart';
import '../helper/loading.dart';
import 'HomeScreen.dart';

class signIn extends StatefulWidget {
  @override
  _signInState createState() => _signInState();
}

class _signInState extends State<signIn> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String error = '';
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            body: Stack(children: <Widget>[
            SingleChildScrollView(
              child: new Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0),
                color: Colors.transparent,
                child: Form(
                    key: _formKey,
                    child: Column(children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(hintText: 'Email'),
                        validator: (val) =>
                            val!.isEmpty ? 'Enter an email' : null,
                        onChanged: (val) {
                          setState(() => email = val);
                        },
                      ),
                      SizedBox(height: 15.0),
                      TextFormField(
                        decoration: InputDecoration(hintText: 'Password'),
                        obscureText: true,
                        validator: (value) => value!.length < 6
                            ? 'Enter a password of 6 or more characters'
                            : null,
                        onChanged: (val) {
                          setState(() => password = val);
                        },
                      ),
                      SizedBox(height: 10.0),
                      RaisedButton(
                          padding: EdgeInsets.all(15),
                          color: Color.fromRGBO(12, 65, 96, 1),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32)),
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                                fontFamily: 'Mochiy Pop P One',
                                color: Colors.white,
                                fontSize: 18),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              dynamic result =
                                  await _auth.signInWithEmailAndPassword(
                                      email: email, password: password);
                              if (result == null) {
                                setState(() {
                                  error = 'please supply a valid email';
                                  loading = false;
                                });
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomeScreen()),
                                );
                              }
                            }
                          }),
                      Text(
                        error,
                        style: TextStyle(color: Colors.white, fontSize: 14.0),
                      ),
                    ])),
              ),
            ),
          ]));
  }
}
