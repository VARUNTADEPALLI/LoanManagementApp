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
import 'package:loans/Model/LoanScheduleModel.dart';
import 'package:loans/Model/LoanStatusModel.dart';
import 'package:loans/Model/PaymentModel.dart';
import 'package:loans/Model/RemainingPaymentModel.dart';
import 'package:loans/Model/TermWiseDetails.dart';
import 'package:loans/Screens/Login.dart';
import 'package:http/http.dart' as http;
import 'package:zoom_widget/zoom_widget.dart';


class LoanSchedule extends StatefulWidget{
  List<LoanScheduleModel?> model;
  LoanSchedule(this.model);
  @override
  State<StatefulWidget> createState() {
    return LoanScheduleState(this.model);
  }

}


class LoanScheduleState  extends State<LoanSchedule>{
  List<LoanScheduleModel?> model;
  LoanScheduleState(this.model);
  int tapped = 0;
  int counter = 0;
  var ctr=0;

  @override
  Widget build(BuildContext context) {


    TextStyle? textstyle = Theme.of(context).textTheme.subtitle2;
    return Scaffold(
      appBar: AppBar(
        title: Text("Loan Schedue"),
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
                            Text("${model.first!.firstDueDate}")
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
                            Text("${model.last!.period}")
                          ],
                        ),),

                        SizedBox(
                          height: 10,
                        ),
                        Padding(padding: EdgeInsets.all(3),child: Row(
                          children: <Widget>[
                            Text("Total Amount",style: TextStyle(
                                fontWeight: FontWeight.bold
                            ),),

                            Spacer(),
                            Icon(Icons.currency_rupee,size: 18,),
                            Text("${model.last!.totalInstallmentAmount}")
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
                            Text("${model.last!.totalPrincipal}")
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
                           Text("${model.last!.totalInterestAmount}")
                          ],
                        ),),

                        SizedBox(
                          height: 10,
                        ),
                        Padding(padding: EdgeInsets.all(3),child: Row(
                          children: <Widget>[
                            Text("Interest Rate",style: TextStyle(
                                fontWeight: FontWeight.bold
                            )),

                            Spacer(),
                            Text("${model.first!.intrestRate}")
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
                            Text("${model.first!.paymentFrequency}")
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
                            Text("${model.last!.term}")
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

              SizedBox(
                height: 5,
              ),
              SizedBox(
                  height: 60.0,
                  child: ListView.builder(
                    // physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: model.last!.term,
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
                                      counter = index;

                                    });
                                  //  termdetails1 = await getTermWiseDetails(tapped);
                                    setState(() {
                                      tapped=index+1;
                                    //  termdetails = termdetails1;
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
                            Text("${model[counter]!.period}")
                          ],
                        ),),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(padding: EdgeInsets.all(3),child:  Row(
                          children: <Widget>[
                            Text("EMI",style: TextStyle(
                                fontWeight: FontWeight.bold
                            ),),

                            Spacer(),
                            Icon(Icons.currency_rupee,size: 18,),
                            Text("${model[counter]!.installmentAmount}")
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
                            Text("${model[counter]!.principal}")
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
                            Text("${model[counter]!.interestAmount}")
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
                            Text("${model[counter]!.principalOutstanding}")
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
