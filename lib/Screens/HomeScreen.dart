import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../authentication/authentication.dart';
import '../classes/user.dart';

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
    final user = Provider.of<Usser?>(context);
    return Scaffold(
      body:
      RaisedButton(
          color: Colors.blue,
          child: Text(
            'Receiver',
            style: TextStyle(
                fontSize: 18,
                fontFamily: 'Mochiy Pop P One',
                color: Colors.white),
          ),
          onPressed: () async {
            await _auth.signOut();
          })
    );
  }
}