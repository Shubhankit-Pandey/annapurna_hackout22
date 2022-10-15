// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
//
// class mail extends StatefulWidget {
//
//   final Profile profile;
//   mail({required this.profile});
//   @override
//   _mailState createState() => _mailState();
// }
//
// class _mailState extends State<mail> {
//   @override
//   Widget build(BuildContext context) {
//     Profile profile = widget.profile;
//     Future sendemail(String text) async{
//       final email='prakritivashishtha517@gmail.com';
//       String password='';
//       final smtpServer=gmail(email, password);
//       final message=Message()
//         ..from=Address(email,'CodeMate')
//         ..recipients=[profile.email]
//         ..subject='Project Collaboration'
//         ..text='${text}';
//       try{
//         await send(message,smtpServer);}
//       on MailerException catch(e){print(e);}
//     }
//     String tex='Hello';
//     return Scaffold(
//       backgroundColor: Color.fromRGBO(33, 57, 89, 1),
//       body:
//       Column(
//         children: [
//           SizedBox(height: 30,),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextFormField(
//               decoration: textInputDecoration.copyWith(hintText: 'Enter message'),
//               validator: (val) =>
//               val!.isEmpty ? 'please enter the meassage' : null,
//               onChanged: (val) => setState(() => tex = val),
//             ),
//           ),
//           SizedBox(height: 20.0),
//           RaisedButton(
//             child: Text('Send Mail',style: TextStyle(color: Colors.indigo[900]),),
//             color: Colors.white,
//             elevation: 0,
//             onPressed: () {
//               sendemail(tex);
//               Navigator.push(context, MaterialPageRoute(builder: (context)=>Flash())) ;
//             },
//             padding: EdgeInsets.symmetric(vertical: 5),
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.all(Radius.circular(28.0))),
//           ),
//         ],
//       ),
//     );
//   }
// }
