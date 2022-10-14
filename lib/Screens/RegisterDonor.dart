import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../authentication/authentication.dart';
import '../classes/user.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String password = '';
  String email = '';
  String error = '';
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Usser?>(context);
    return Scaffold(
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
                                        .registerWithEmailAndPassword(
                                      email,
                                      password,
                                    );
                                    if (result == null) {
                                      setState(() {
                                        error = 'please supply a valid email';
                                        loading = false;
                                      });
                                    } else {
                                      await DatabaseService(uid: user!.uid)
                                          .updateUserData(
                                      email,password,
                                      );
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //       builder: (context) =>()),
                                      // );
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
