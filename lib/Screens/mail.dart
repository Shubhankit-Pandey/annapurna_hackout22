import 'package:annapurna/classes/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import '../helper/notfound.dart';
//import '../authentication/google_auth_api.dart';

class mail extends StatefulWidget {

  final Inventory profile;
  mail({required this.profile});
  @override
  _mailState createState() => _mailState();
}

class _mailState extends State<mail> {
  @override
  Widget build(BuildContext context) {
    Inventory profile = widget.profile;
    Future sendemail(String text) async{
      final email='prakritivashishtha517@gmail.com';
     // final user=await GoogleAuthApi.signIn();
     //  if (user==null) return;
     //  final auth= await user.authentication;
     //  final token='';
     // final smtpServer=gmailSaslXoauth2(email, token);
      final message=Message()
        ..from(email)
        ..recipients=['iec2021054@iiita.ac.in']
        ..subject='Project Collaboration'
        ..text='$text';
      // try{
      //   await send(message,smtpServer);}
      // on MailerException catch(e){print(e);}
    }
    String text='Hello';
    return Scaffold(
      backgroundColor: Color.fromRGBO(33, 57, 89, 1),
      body:
      Column(
        children: [
          SizedBox(height: 30,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              validator: (val) =>
              val!.isEmpty ? 'please enter the meassage' : null,
              onChanged: (val) => setState(() => text = val),
            ),
          ),
          SizedBox(height: 20.0),
          RaisedButton(
            child: Text('Send Mail',style: TextStyle(color: Colors.indigo[900]),),
            color: Colors.white,
            elevation: 0,
            onPressed: () {
              sendemail(text);
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Flash())) ;
            },
            padding: EdgeInsets.symmetric(vertical: 5),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(28.0))),
          ),
        ],
      ),
    );
  }
}
