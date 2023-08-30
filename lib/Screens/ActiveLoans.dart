import 'dart:convert';
import 'dart:math';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter/foundation.dart';
import 'package:loans/Model/ActiveLoansModel.dart';
import 'package:loans/Model/CustomerModel.dart';
import 'package:loans/Screens/LoanStatus.dart';
import 'package:loans/Screens/Login.dart';
import 'package:http/http.dart' as http;

class ActiveLoans extends StatefulWidget{
  String todayDate;
  List<ActiveLaonsModel> model1;
  ActiveLoans(this.model1,this.todayDate);
  @override
  State<StatefulWidget> createState() {
    return ActiveLaonState(this.model1,this.todayDate);
  }

}


class ActiveLaonState  extends State<ActiveLoans>{
  String todayDate;
  List<ActiveLaonsModel> model1;
  ActiveLaonState(this.model1,this.todayDate);




  @override
  Widget build(BuildContext context) {

    TextStyle? textstyle = Theme.of(context).textTheme.subtitle2;

    return Scaffold(
      appBar: AppBar(
        title: Text("Active Loans"),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
          child:Column(
            children: [
              ListView.builder(scrollDirection:Axis.vertical,shrinkWrap: true,itemCount: model1.length,itemBuilder:(BuildContext context,int index){
              if(model1.isEmpty)
                {
                  return Container(
                    child: Center(
                      child: Icon(Icons.error),
                    ),
                  );

                }
              else
                {
                  // return Card(
                  //
                  //
                  // ); mju
                  return Container(
                    height: 100,
                    padding: EdgeInsets.symmetric(
                      horizontal: 8,
                    ),

                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child:GestureDetector(
                              onTap: (){
                                ActiveLaonsModel model = model1[index];
                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoanStatus(model,todayDate),),);
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  side: BorderSide(
                                    color: Colors.green,
                                    width: 2
                                  )
                                ),

                                  child: Column(

                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          ListTile(
                                            title: Text("${model1[index].name}",),


                                          ),
                                         Row(
                                           children: [
                                             SizedBox(
                                               width: 18,
                                             ),
                                             Text("${model1[index].loanId}"),
                                             SizedBox(
                                               width: 30,
                                             ),
                                             Text("${model1[index].loanType}",style: TextStyle(
                                               color: Colors.red,
                                             ),),
                                             SizedBox(
                                               width: 30,
                                             ),
                                             Text("${model1[index].loanAmount}",),
                                             SizedBox(
                                               width: 5,
                                             ),
                                           ],
                                         )
                                        ],

                                      ),

                              )
                            )

                        ),


                      ],
                    ),

                  );
                }
              })
              // SizedBox(
              //   height: 20,
              // ),
              // Card(
              //   child: ListView.builder(itemCount: model1.length,itemBuilder: (BuildContext context,int index){
              //     if(model1==null)
              //       {
              //         return Container(child: Center(
              //           child: Icon(Icons.error),
              //         ),);
              //       }
              //     else
              //       {
              //         return ListView.builder(itemCount: model1.length,itemBuilder: (BuildContext context,int index){
              //           return ListTile(
              //             title: Text("${model1[index].name}"),
              //             subtitle: Text("${model1[index].loanId}"+"${model1[index].loanType}"+"${model1[index].loanAmount}"),
              //           );
              //         });
              //       }
              //   }),
              //
              // )
              // // ListView.builder: (BuildContext context) {
              // //   if(model1==null)
              // //     {
              // //       return Container(child: Center(
              // //         child: Icon(Icons.error),
              // //       ),);
              // //     }
              // //   return ListView.builder(itemCount: snapshot.data?.length,itemBuilder:(BuildContext context,int index){
              // //     return ListTile(
              // //       title: Text("mobile number" + " " + " loan type" + " " + "loan id" + "loan amount"),
              // //       subtitle: Text("${snapshot.data?[index].mobilenumber}" + "${snapshot.data?[index].loanType}" + "${snapshot.data?[index].loanId}" + "${snapshot.data?[index].loanAmount}"),
              // //     );
              // //   });
              // // },


            ],
          )


      ),


    );
  }

}
