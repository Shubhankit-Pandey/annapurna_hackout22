import 'package:annapurna/classes/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import '../helper/auth_api.dart';
import '../helper/notfound.dart';


class Mail extends StatefulWidget {

  final donor profile;
  Mail({required this.profile});
  @override
  _MailState createState() => _MailState();
}

class _MailState extends State<Mail> {
  @override
  Widget build(BuildContext context) {
    donor profile = widget.profile;
    Future sendemail(String text) async{
      final email='prakritivashishtha517@gmail.com';
     final user=await GoogleAuthApi.signIn();
      if (user==null) return;
      final auth= await user.authentication;
      final token='';
     final smtpServer=gmailSaslXoauth2(email, token);
      final message=Message()
        ..from(email)
        ..recipients=[profile.email]
        ..subject='Project Collaboration'
        ..text='$text';
      try{
        await send(message,smtpServer);}
      on MailerException catch(e){print(e);}
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
          ElevatedButton(
            child: Text('Send Mail',style: TextStyle(color: Colors.indigo[900]),),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.white),
              elevation: MaterialStateProperty.all(0),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(28.0))),)

            ),
            onPressed: () {
              sendemail(text);
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Flash())) ;
            },

          ),
        ],
      ),
    );
  }
}
