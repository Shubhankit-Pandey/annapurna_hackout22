import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Screens/HomeScreen.dart';
import '../Screens/RegisterDonor.dart';
import '../classes/user.dart';


class wrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Usser?>(context);
    if(user==null){
      return Register();
    }
    else{
      return HomeScreen();
    }
  }
}
