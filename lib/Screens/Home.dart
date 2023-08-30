import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:loans/Model/CustomerModel.dart';
import 'package:loans/Screens/ForgotPassword.dart';
import 'package:loans/Screens/Loans.dart';
import 'package:loans/Screens/Login.dart';
import 'package:loans/Screens/NewUserRegistration.dart';

class Home extends StatefulWidget {
  String id;
  String todayDate;

  Home(this.id,this.todayDate);

  @override
  homeState createState() => homeState(this.id,this.todayDate);
}



class homeState extends State<Home> {
String id;
String todayDate;
homeState(this.id,this.todayDate);

  @override
  Widget build(BuildContext context) {
    TextStyle? textstyle = Theme
        .of(context)
        .textTheme
        .subtitle2;
    return Scaffold(
      body: Center(



        child: Container(
          height: 180,
          padding: EdgeInsets.symmetric(
            horizontal: 5,
          ),
          child: Row(
            children: <Widget>[
              Expanded(
          child:GestureDetector(
              onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Loans(id,todayDate),),);
        },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 3,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    height: 100,
                    width: 120,
                    padding: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 0,
                        color: Colors.white,
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Image.asset("assets/Loans.png"),
                    ),
                  ),
                  Text('Loans',style: TextStyle(
                      fontSize: 19
                  ),),
                ],
              ),
            ),
        )

              ),

              SizedBox(
                width: 20,
              ),
              Expanded(
                child:GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Loans(id,todayDate),),);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 3,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          height: 100,
                          width: 120,
                          padding: EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 0,
                              color: Colors.white,
                            ),
                          ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Image.asset("assets/Collections.jpg"),
                          ),
                        ),
                        Text('Collections',style: TextStyle(
                            fontSize: 19
                        ),),
                      ],
                    ),
                  ),
                )

              ),
            ],
          ),
        ),
      ),
    );

    return Center(

    );
    return Scaffold(
        body: Row(
      children: [
            GestureDetector(
            onTap: (){
    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Login(),),);
    },

        child: Card(
            semanticContainer: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/Loans.png'),
                            fit: BoxFit.fill),
                      ),
                    )),
                Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "Loans",
                      style: TextStyle(fontSize: 18.0),
                    )),
              ],
            )))
      ],
    )
    );
      // appBar: AppBar(
      //   title: Text("Login"),
      //   centerTitle: true,
      // ),

      // body: Center(
      //   child:Row(
      //     children: [
      //       GestureDetector(
      //         onTap: (){
      //           Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Login(),),);
      //         },
      //         child: Card(
      //           child :Image.asset("assets/Loans.png"),
      //
      //         ),
      //       ),
      //       GestureDetector(
      //         onTap: (){
      //           Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Login(),),);
      //         },
      //         child: Card(
      //           child :Image.asset("assets/Collections.png"),
      //
      //         ),
      //       ),
      //
      //     ],
      //
      //   )
      //
      //
      //
      //
      // ),

  }
}


//
// child: Card(
// semanticContainer: true,
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(10.0),
// ),
// clipBehavior: Clip.antiAlias,
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: <Widget>[
// Expanded(
// child: Container(
// decoration: BoxDecoration(
// image: DecorationImage(
// image: AssetImage('assets/Loans.png'),
// fit: BoxFit.fill),
// ),
// )),
// Padding(
// padding: EdgeInsets.all(10.0),
// child: Text(
// "Loans",
// style: TextStyle(fontSize: 18.0),
// )),
// ],
// ))));

