import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../authentication/verify.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override

    void initState() {
      super.initState();
      _navigationtohome();
    }
    _navigationtohome()async{
      await Future.delayed(Duration(seconds:3), () {});
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) =>Verify()));
    }
    Widget build(BuildContext context) {
      return Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              color: Colors.white,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

                      Padding(
                          padding: EdgeInsets.only(top:70.0,bottom: 0.0,left: 40,right: 40),
                        child: Image(image: AssetImage("images/logo-png.png")),
                      ),
                    ],
                  ),
                ),
                Expanded(flex:1,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SpinKitRotatingCircle(color: const Color.fromARGB(
                              0xFF, 0x98, 0x31, 0x6A),),
                          Padding(
                            padding: EdgeInsets.only(top: 20.0),
                          ),
                        ]
                    ))
              ],
            )
          ],
        ),
      );
    }
}

