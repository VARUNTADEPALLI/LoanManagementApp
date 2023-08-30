import 'dart:convert';
import 'dart:math';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:loans/Model/ActiveLoansModel.dart';
import 'package:loans/Model/CodeAndValuesModel.dart';
import 'package:loans/Model/LoanStatusModel.dart';
import 'package:loans/Screens/ActiveLoans.dart';
import 'package:loans/Screens/LoanCalculator.dart';
import 'package:loans/Screens/Login.dart';

class Loans extends StatefulWidget{
  String id;
  String todayDate;
  Loans(this.id,this.todayDate);
  @override
  State<StatefulWidget> createState() {
  return LoansState(this.id,this.todayDate);
  }

}



class LoansState  extends State<Loans>{

String id;
String todayDate;
LoansState(this.id,this.todayDate);

Future<List<ActiveLaonsModel>> getActiveLoanDetails()
async{
  String url = "http://10.0.2.2:8091/api/GetCustomerLoanDetails/"+"$id";
  var data = await http.get(url);
  var jsonData = json.decode(data.body);
  print(jsonData);

  List<ActiveLaonsModel> model = [];
  for(var al in jsonData)
  {
    ActiveLaonsModel activeLaonsModel = new ActiveLaonsModel();
    activeLaonsModel.name = al["name"];
    activeLaonsModel.loanAmount = al["loanAmount"];
    activeLaonsModel.loanId = al["loanId"];
    activeLaonsModel.loanType = al["loanType"];
    activeLaonsModel.customerId =al["customerId"];
    activeLaonsModel.mobilenumber = id;
    model.add(activeLaonsModel);
  }
  print(model[0].loanType);
  return model;
}



Future<List<String>> getIntrestRateType()
async{
  String url = "http://10.0.2.2:8091/api/getIntrestrateType";
  var data = await http.post(url);
  var jsonData = json.decode(data.body);
  print(jsonData);

  List<String> model = [];
  for(var al in jsonData)
  {
    model.add(al["value"]);
  }
  print(model);
  return model;
}


Future<List<String>> getPaymentFrequency()
async{
  String url = "http://10.0.2.2:8091/api/getPaymentFrequency";
  var data = await http.post(url);
  var jsonData = json.decode(data.body);
  print(jsonData);

  List<String> model = [];
  for(var al in jsonData)
  {
    model.add(al["value"]);
  }
  print(model);
  return model;
}


  @override
  Widget build(BuildContext context) {

  TextStyle? textstyle = Theme.of(context).textTheme.subtitle2;

    return Scaffold(
      appBar: AppBar(
        title: Text("Loans"),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child:Column(
          children: [
            SizedBox(
              height: 20,
            ),
             Container(
              height: 180,
              padding: EdgeInsets.symmetric(
                horizontal: 5,
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child:GestureDetector(
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Login(),),);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: 1,
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
                                  child: Image.asset("assets/Loan_Booking.png"),
                                ),
                              ),
                              Text('Loan Booking',style: TextStyle(
                                  fontSize: 15
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
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Login(),),);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: 1,
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
                                  child: Image.asset("assets/InFlight_Applications.png"),
                                ),
                              ),
                              Text('InFlight Applications',style: TextStyle(
                                  fontSize: 15
                              ),),
                            ],
                          ),
                        ),
                      )

                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 180,
              padding: EdgeInsets.symmetric(
                horizontal: 5,
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child:GestureDetector(
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Login(),),);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: 1,
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
                                  child: Image.asset("assets/View_My_Application.png"),
                                ),
                              ),
                              Text('View My Application',style: TextStyle(
                                  fontSize: 15
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
                        onTap: () async {
                          List<ActiveLaonsModel> model1 = await getActiveLoanDetails();
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ActiveLoans(model1,todayDate),),);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: 1,
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
                                  child: Image.asset("assets/Active_Loans.png"),
                                ),
                              ),
                              Text('Active Loans',style: TextStyle(
                                  fontSize: 15
                              ),),
                            ],
                          ),
                        ),
                      )

                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 180,
              padding: EdgeInsets.symmetric(
                horizontal: 5,
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child:GestureDetector(
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Login(),),);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: 1,
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
                                  child: Image.asset("assets/Offers.jpg"),
                                ),
                              ),
                              Text('Offers',style: TextStyle(
                                  fontSize: 15
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
                        onTap: () async {
                          List<String> interestRateType = await getIntrestRateType();
                          List<String> paymentFrequency = await getPaymentFrequency();
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoanCalculator(interestRateType,paymentFrequency,todayDate),),);
                          //Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Login(),),);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: 1,
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
                                  child: Image.asset("assets/EMI_Calculator.png"),
                                ),
                              ),
                              Text('EMI Calculator',style: TextStyle(
                                  fontSize: 15
                              ),),
                            ],
                          ),
                        ),
                      )

                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 180,
              padding: EdgeInsets.symmetric(
                horizontal: 5,
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child:GestureDetector(
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Login(),),);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: 1,
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
                                  child: Image.asset("assets/BNPL.png"),
                                ),
                              ),
                              Text('BNPL',style: TextStyle(
                                  fontSize: 15
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
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Login(),),);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white,
                              width: 0,
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
                                  // child: Image.asset("assets/BNPL.png"),
                                ),
                              ),
                              // Text('Loans',style: TextStyle(
                              //     fontSize: 19
                              // ),),
                            ],
                          ),
                        ),
                      )

                  ),
                ],
              ),

            ),
            SizedBox(
              height: 20,
            ),

          ],
        )


      ),


    );
  }

}
