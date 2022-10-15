import 'package:annapurna/authentication/wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../classes/user.dart';
import 'authentication.dart';


class Verify extends StatelessWidget {
  const Verify({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<Usser?>.value(
      initialData: Usser(uid: ""),
      value: AuthService().user,
      child: MaterialApp(home: wrapper()),
    );
  }
}
