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
  void initState(){
    resetAnim();
  }
  bool _progress = true ;
  void resetAnim() async {
    setState(() {
     bool _progress = true;
    });

    await new Future.delayed(const Duration(milliseconds: 50));


    setState(() {

      _progress = false;
    });
  }
  Widget build(BuildContext context) {
    final user = Provider.of<Usser?>(context);
    return Scaffold(
      body:SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(height:80 ),
                  Container(
                    height: 80,
                    color: Colors.white,
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          height: 200,
                            color: Colors.white,
                            child: Image.asset("Images/FoodGive.png",fit: BoxFit.fitHeight,)),

                        SizedBox(width: 10,),
                        Column(
                          children: [
                            SizedBox(height: 5,),
                            Text("  Food Available ",style: TextStyle(fontSize: 35,fontWeight:  FontWeight.w500 , decoration: TextDecoration.underline , decorationStyle: TextDecorationStyle.double,color: Colors.pinkAccent),),

                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 14,),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 30000),

                    height: 20,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors:  _progress == true ? [Colors.pinkAccent,Colors.purpleAccent,Colors.pinkAccent] : [Colors.purpleAccent,Colors.pinkAccent,Colors.purpleAccent]
                      ),
                    color: Colors.blue

                    ),
                  ),
                  GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 20 , ),
                    padding: EdgeInsets.all(25),
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context,index){
                    return TextButton(
                      onPressed: (){

                      },
                      child: Row(
                        children: [
                          Container(
                            height: 300,
                          width: 150,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black,width: 3),

                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)

                          )
                          ,child: Column(
                            children: <Widget>[
                              SizedBox(height: 10,),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(400)
                                ),
                                height: MediaQuery.of(context).size.height * 0.122,
                                width: MediaQuery.of(context).size.width * 0.27,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.asset("Images/img.png",fit: BoxFit.cover,),
                                ),
                              ),
                              Text(" 2 Persons",style: TextStyle(fontSize: 17),),
                              Text("Location",style: TextStyle(fontSize: 17),),

                            ],

                          ),),
                        ],
                      ),
                    );
                    },
                    itemCount: 20,
                    shrinkWrap: true,


                  )
                ],
              ),
            ),
          ),
        )
    );
      
  }
}
