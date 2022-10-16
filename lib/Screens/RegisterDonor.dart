import 'package:annapurna/Screens/Donate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../authentication/authentication.dart';
import '../classes/database.dart';
import '../classes/user.dart';
import '../helper/loading.dart';
import 'LoginDonor.dart';
import 'maps.dart';

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
    return loading
        ? Loading()
        : Scaffold(
            body: SingleChildScrollView(
              child: Stack(
                  children: <Widget>[
              SingleChildScrollView(
                  child: new Column(
                children: [
                  SizedBox(
                    height: 200,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 20.0, horizontal: 42.0),
                    child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 3,
                                color: const Color.fromARGB(0xFF, 0x98, 0x31, 0x6A)),
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.white),
                        height: MediaQuery.of(context).size.height*0.52,
                        padding: EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 20.0),
                        child: Form(
                            key: _formKey,
                            child: SingleChildScrollView(
                              child: Column(children: <Widget>[
                                SizedBox(height: 70,),
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
                                SizedBox(height: 20.0),
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
                                SizedBox(height: 95.0),
                                ElevatedButton(
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(11)
                                    )),
                                    backgroundColor: MaterialStateProperty.all(Color.fromARGB(0xFF, 0x98, 0x31, 0x6A))
                                  ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Register',
                                        style: TextStyle(
                                            fontFamily: 'Mochiy Pop P One',
                                            color: Colors.white,
                                            fontSize: 27),
                                      ),
                                    ),
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        dynamic result = await _auth
                                            .register2WithEmailAndPassword(
                                          email,
                                          password,
                                        );

                                        if (result == null) {
                                          setState(() {
                                            error = 'Please supply a valid email';
                                            loading = false;
                                          });
                                        } else {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Donate(lat:0,long:0)),
                                        );
                                          await DatabaseDonor(uid: user!.uid)
                                              .updateUserData(email, user!.uid);
                                        }
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Donate(lat:0,long:0)),
                                        );
                                      }
                                    }),
                                SizedBox(height: 10,),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text("Already have an account?",
                                        style: TextStyle(fontSize: 15,
                                            color: Color.fromARGB(
                                                0x77, 0x98, 0x31, 0x6A),
                                            fontWeight: FontWeight.w500)),
                                    TextButton(
                                        onPressed: () => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => signIn()),
                                            ),
                                        child: Text(
                                          "Log In",
                                          style: TextStyle(fontSize: 15,
                                              color: Color.fromARGB(
                                                  0xFF, 0x98, 0x31, 0x6A),
                                              fontWeight: FontWeight.w500),
                                        ))
                                  ],
                                ),
                              ]),
                            ))),
                  ),
                ],
              )),
                    Positioned(
                      child: Image(image: AssetImage('images/donor-image-1.png')),
                      top: MediaQuery.of(context).size.height * 0.18,
                      left: MediaQuery.of(context).size.width * 0.32,
                    ),
          ]),
            ));
  }
}
