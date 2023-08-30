import 'dart:convert';
import 'dart:ffi';
import 'dart:math';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart';
import 'package:loans/Model/ActiveLoansModel.dart';
import 'package:loans/Model/AddressModel.dart';
import 'package:loans/Model/CustomerModel.dart';
import 'package:loans/Model/LoanStatusModel.dart';
import 'package:loans/Model/PaymentModel.dart';
import 'package:loans/Model/RemainingPaymentModel.dart';
import 'package:loans/Model/TermWiseDetails.dart';
import 'package:loans/Screens/Login.dart';
import 'package:http/http.dart' as http;
import 'package:zoom_widget/zoom_widget.dart';


class PaymentSchedule extends StatefulWidget{
  TermWiseDetails termdetails;
  PaymentModel payemtModel;
  LoanStatusModel statusModel;
  RemainingPaymentModel remainingStatusModel;
  PaymentSchedule(this.remainingStatusModel,this.statusModel,this.payemtModel,this.termdetails);
  @override
  State<StatefulWidget> createState() {
    return PaymentScheduleState(this.remainingStatusModel,this.statusModel,this.payemtModel,this.termdetails);
  }

}


class PaymentScheduleState  extends State<PaymentSchedule>{
  TermWiseDetails termdetails;
  PaymentModel payemtModel;
  LoanStatusModel statusModel;
  RemainingPaymentModel remainingStatusModel;
  PaymentScheduleState(this.remainingStatusModel,this.statusModel,this.payemtModel,this.termdetails);
  TermWiseDetails termdetails1 = new TermWiseDetails();
  int tapped = 0;
  var ctr=0;

  Future<TermWiseDetails> getTermWiseDetails(int tapped)
  async{
    String url = "http://10.0.2.2:8091/api/termWiseDetails/"+"${tapped}";
    var data = await http.post(url);
    var jsonData = json.decode(data.body);
    print(jsonData);
    TermWiseDetails details = new TermWiseDetails();
    details.dueDate = DateFormat.yMMMMd().format(DateTime.parse(jsonData["dueDate"]));
    details.intrestPaid = jsonData["intrestPaid"];
    details.intrest = jsonData["intrest"];
    details.principalPaid = jsonData["principalPaid"];
    details.installment = jsonData["installment"];
    details.principalOutstanding = jsonData["principaOutstanding"];
    details.principal = jsonData["principal"];
    return details;
  }

  @override
  Widget build(BuildContext context) {
    if(statusModel.closureDate == "Jan 1, 1900"){
      statusModel.closureDate = "\t";
    }

    TextStyle? textstyle = Theme.of(context).textTheme.subtitle2;
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment Schedue"),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(padding: EdgeInsets.only(top: 10),
                child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white10,
                        width: 2.2,
                      ),
                    ),
                    height: 261,

                    child: Column(
                      children: [
                        Padding(padding: EdgeInsets.all(3),child: Row(
                          children: <Widget>[
                            Text("Start Date",style: TextStyle(
                                fontWeight: FontWeight.bold
                            ),),

                            Spacer(),
                            // SizedBox(
                            //   width: 20,
                            // ),
                            Text("${statusModel.firstDueDate}")
                          ],
                        ),),

                        SizedBox(
                          height: 10,
                        ),
                        Padding(padding: EdgeInsets.all(3),child:  Row(
                          children: <Widget>[
                            Text("End Date",style: TextStyle(
                                fontWeight: FontWeight.bold
                            ),),

                            Spacer(),
                            Text("${statusModel.finalDueDate}")
                          ],
                        ),),

                        SizedBox(
                          height: 10,
                        ),
                        Padding(padding: EdgeInsets.all(3),child: Row(
                          children: <Widget>[
                            Text("Total Installment",style: TextStyle(
                                fontWeight: FontWeight.bold
                            ),),

                            Spacer(),
                            Icon(Icons.currency_rupee,size: 18,),
                            Text("${payemtModel.totalInstallmentAmount}")
                          ],
                        ),),

                        SizedBox(
                          height: 10,
                        ),
                        Padding(padding: EdgeInsets.all(3),child: Row(
                          children: <Widget>[
                            Text("Total Principal",style: TextStyle(
                                fontWeight: FontWeight.bold
                            ),),

                            Spacer(),
                            Icon(Icons.currency_rupee,size: 18,),
                            Text("${payemtModel.totalPrincipalAmount}")
                          ],
                        ),),

                        SizedBox(
                          height: 10,
                        ),
                        Padding(padding: EdgeInsets.all(3),child:Row(
                          children: <Widget>[
                            Text("Total Interest",style: TextStyle(
                                fontWeight: FontWeight.bold
                            ),),

                            Spacer(),
                            Icon(Icons.currency_rupee,size: 18,),
                            Text("${payemtModel.totalIntrestAmount}")
                          ],
                        ),),

                        SizedBox(
                          height: 10,
                        ),
                        Padding(padding: EdgeInsets.all(3),child: Row(
                          children: <Widget>[
                            Text("Interest Type",style: TextStyle(
                                fontWeight: FontWeight.bold
                            )),

                            Spacer(),
                            Text("${statusModel.intrestType}")
                          ],
                        ),),

                        SizedBox(
                          height: 10,
                        ),
                        Padding(padding: EdgeInsets.all(3),child: Row(
                          children: <Widget>[
                            Text("Payment Frequency",style: TextStyle(
                                fontWeight: FontWeight.bold
                            )),

                            Spacer(),
                            Text("${statusModel.paymentFrequency}")
                          ],
                        ),),

                        SizedBox(
                          height: 10,
                        ),
                        Padding(padding: EdgeInsets.all(3),child: Row(
                          children: <Widget>[
                            Text("Term",style: TextStyle(
                                fontWeight: FontWeight.bold
                            )),

                            Spacer(),
                            Text("${statusModel.term}")
                          ],
                        ),),
                      ],
                    )

                ),
              ),

              Divider(
                thickness: 16,
                color: Colors.grey,
              ),

              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Padding(padding: EdgeInsets.only(left: 4),child:  Text("Term Wise Details",style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                    textAlign: TextAlign.start,) ,)

                ],
              ),

              SizedBox(
                height: 5,
              ),
              SizedBox(
                height: 60.0,
                child: ListView.builder(
                  // physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: statusModel.term,
                  itemBuilder: (BuildContext context, int index) =>
                  Container(
                    width: 60,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white10)
                    ),
                    child: Padding(padding: EdgeInsets.only(top: 0),
                      child:
                          GestureDetector(
                            onTap: () async {
                              setState(() {
                                tapped=index+1;
                              });
                              termdetails1 = await getTermWiseDetails(tapped);
                              setState(() {
                                termdetails = termdetails1;
                              });

                            },
                              child:Container(
                               decoration: BoxDecoration(
                                 border: Border(
                                   bottom: BorderSide(
                                     width: 4,
                                     color: tapped==index+1 ? Colors.blue : Colors.white10
                                   )
                                 ),


                               ),
                                child:  Padding(
                                  padding: EdgeInsets.only(top: 15),
                                  child:Text('${index+1}',textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color:  tapped==index+1 ? Colors.blue : Colors.black
                                  ),)
                                  ,)
                            ),
                          )

                    )

                    ),
                  )

                ),
              SizedBox(
                height: 20,
              ),
              Padding(padding: EdgeInsets.only(top: 7),
                child: Container(
                    height: 241,
                    child: Column(
                      children: [
                        Padding(padding: EdgeInsets.all(3),child: Row(
                          children: <Widget>[
                            Text("Period",style: TextStyle(
                                fontWeight: FontWeight.bold
                            ),),
                            Spacer(),
                            Text("${termdetails.dueDate}")
                          ],
                        ),),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(padding: EdgeInsets.all(3),child:  Row(
                          children: <Widget>[
                            Text("Installment",style: TextStyle(
                                fontWeight: FontWeight.bold
                            ),),

                            Spacer(),
                            Icon(Icons.currency_rupee,size: 18,),
                            Text("${termdetails.installment}")
                          ],
                        ),),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(padding: EdgeInsets.all(3),child: Row(
                          children: <Widget>[
                            Text("Principal",style: TextStyle(
                                fontWeight: FontWeight.bold
                            ),),

                            Spacer(),
                            Icon(Icons.currency_rupee,size: 18,),
                            Text("${termdetails.principal}")
                          ],
                        ),),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(padding: EdgeInsets.all(3),child: Row(
                          children: <Widget>[
                            Text("Interest",style: TextStyle(
                                fontWeight: FontWeight.bold
                            ),),

                            Spacer(),
                            Icon(Icons.currency_rupee,size: 18,),
                            Text("${termdetails.intrest}")
                          ],
                        ),),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(padding: EdgeInsets.all(3),child:Row(
                          children: <Widget>[
                            Text("Principal Outstading",style: TextStyle(
                                fontWeight: FontWeight.bold
                            ),),

                            Spacer(),
                            Icon(Icons.currency_rupee,size: 18,),
                            Text("${termdetails.principalOutstanding}")
                          ],
                        ),),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(padding: EdgeInsets.all(3),child: Row(
                          children: <Widget>[
                            Text("Principal Paid Amount",style: TextStyle(
                                fontWeight: FontWeight.bold
                            )),

                            Spacer(),
                            Icon(Icons.currency_rupee,size: 18,),
                            Text("${termdetails.principalPaid}")
                          ],
                        ),),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(padding: EdgeInsets.all(3),child: Row(
                          children: <Widget>[
                            Text("Interest Paid Amount",style: TextStyle(
                                fontWeight: FontWeight.bold
                            )),

                            Spacer(),
                            Icon(Icons.currency_rupee,size: 18,),
                            Text("${termdetails.intrestPaid}")
                          ],
                        ),),
                      ],
                    )

                ),),









            ],
          )
      ),


    );


  }


}
