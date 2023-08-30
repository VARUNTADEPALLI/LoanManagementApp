import 'dart:convert';
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
import 'package:loans/Model/RemainingPaymentModel.dart';
import 'package:loans/Screens/Login.dart';
import 'package:http/http.dart' as http;
import 'package:zoom_widget/zoom_widget.dart';


class LoanDetails extends StatefulWidget{
  LoanStatusModel statusModel;
  RemainingPaymentModel remainingStatusModel;
  LoanDetails(this.statusModel,this.remainingStatusModel);
  @override
  State<StatefulWidget> createState() {
    return LoanDetailsState(this.statusModel,this.remainingStatusModel);
  }

}


class LoanDetailsState  extends State<LoanDetails>{
  LoanStatusModel statusModel;
  RemainingPaymentModel remainingStatusModel;
  LoanDetailsState(this.statusModel,this.remainingStatusModel);

  AddressModel addressModel = new AddressModel();
    Future<AddressModel?> getDetails()
    async{
      String url = "http://10.0.2.2:8091/api/getAddressDetails/"+"${statusModel.customerId}";
      var data = await http.get(url);
      var jsonData = json.decode(data.body);
      print(jsonData);
      addressModel.customerId = jsonData["customerId"];
      addressModel.streetName = jsonData["streetName"];
      addressModel.state = jsonData["state"];
      addressModel.pincode = jsonData["pincode"];
      addressModel.houseNumber = jsonData["houseNumber"];
      addressModel.description = jsonData["description"];
      addressModel.country = jsonData["country"];
      addressModel.city = jsonData["city"];
      print(addressModel.description);
      // showDialog(context: context, builder: (context){
      //   return AlertDialog(
      //     // title: Text("${addressModel.city}"),
      //     content:
      //     // RadioListTile(
      //     //   title: Text("${addressModel.description}"),
      //     //   value: "male",
      //     //   groupValue: gender,
      //     //   onChanged: (value){
      //     //     setState(() {
      //     //       gender = value.toString();
      //     //     });
      //     //   },
      //     // ),,
      //   );
      // });
    }




  @override
  Widget build(BuildContext context) {
if(statusModel.closureDate == "Jan 1, 1900"){
  statusModel.closureDate = "\t";
}

      TextStyle? textstyle = Theme.of(context).textTheme.subtitle2;

    return Scaffold(
      appBar: AppBar(
        title: Text("Loan Status"),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(2),
              child: Card(
                color: Colors.blue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(1),
                    side: BorderSide(
                        color: Colors.white,
                        width: 0
                    )
                ),

                child: Column(

                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ListTile(
                      title: Text("Loan Account Statement For \n${statusModel.loanId}",textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white
                        ),),


                    ),
                  ],

                ),

              ),
            ),
            SizedBox(
              height: 1,
            ),Text("${statusModel.name}",textAlign: TextAlign.center,),
            SizedBox(
              height: 1,
            ),
            Padding(padding: EdgeInsets.all(7),
             child: Container(
               decoration: BoxDecoration(
                 border: Border.all(
                   color: Colors.green,
                   width: 2.2,
                 ),
               ),
                  height: 271,

                  child: Column(
                    children: [
                  Padding(padding: EdgeInsets.all(3),child: Row(
                    children: <Widget>[
                      Text("Product"),

                      Spacer(),
                      // SizedBox(
                      //   width: 20,
                      // ),
                      Text("${statusModel.loanType}\t" + "${statusModel.currency}")
                    ],
                  ),),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(padding: EdgeInsets.all(3),child:  Row(
                        children: <Widget>[
                          Text("Total Loans"),

                          Spacer(),
                          Text("${statusModel.totalLoans}")
                        ],
                      ),),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(padding: EdgeInsets.all(3),child: Row(
                        children: <Widget>[
                          Text("No.Of Active Loans"),

                          Spacer(),
                          Text("${statusModel.activeLoans}")
                        ],
                      ),),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(padding: EdgeInsets.all(3),child: Row(
                        children: <Widget>[
                          Text("No. Of Closed Loans"),

                          Spacer(),
                          Text("${statusModel.closedLoans}")
                        ],
                      ),),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(padding: EdgeInsets.all(3),child:Row(
                        children: <Widget>[
                          Text("Mobile Number"),

                          Spacer(),
                          Text("${statusModel.mobilenumber}")
                        ],
                      ),),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(padding: EdgeInsets.all(3),child: Row(
                        children: <Widget>[
                          Text("Email Address"),

                          Spacer(),
                          Text("${statusModel.emailId}")
                        ],
                      ),),
                     SizedBox(
                        height: 10,
                      ),
                      Padding(padding: EdgeInsets.all(3),child: Row(
                        children: <Widget>[
                          Text("Intrest Start Date"),

                          Spacer(),
                          Text("${statusModel.intrestStartDate}")
                        ],
                      ),),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(padding: EdgeInsets.all(3),child:  Row(
                        children: <Widget>[
                          Text("Intrest Type"),

                          Spacer(),
                          Text("${statusModel.intrestType}")
                        ],
                      ),),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  )

                ),),
            SizedBox(
              height: 1,
            ),
            Text("Loan Summary",textAlign: TextAlign.center,),
            Padding(padding: EdgeInsets.all(7),
              child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.green,
                      width: 2.2,
                    ),
                  ),
                  height: 440,

                  child: Column(
                    children: [
                      Padding(padding: EdgeInsets.all(3),child: Row(
                        children: <Widget>[
                          Text("Laon Amount"),

                          Spacer(),
                          // SizedBox(
                          //   width: 20,
                          // ),
                          Icon(Icons.currency_rupee,size: 18,),
                          Text("${statusModel.loanAmount}")
                        ],
                      ),),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(padding: EdgeInsets.all(3),child:  Row(
                        children: <Widget>[
                          Text("Intrest Rate"),

                          Spacer(),
                          Text("${statusModel.intrestRate}")
                        ],
                      ),),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(padding: EdgeInsets.all(3),child: Row(
                        children: <Widget>[
                          Text("Tenure"),

                          Spacer(),
                          Text("${statusModel.term}")
                        ],
                      ),),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(padding: EdgeInsets.all(3),child: Row(
                        children: <Widget>[
                          Text("Installment Amount"),

                          Spacer(),
                          Icon(Icons.currency_rupee,size: 18,),
                          Text("${statusModel.installmentAmount}")
                        ],
                      ),),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(padding: EdgeInsets.all(3),child:Row(
                        children: <Widget>[
                          Text("Disbursal Date"),

                          Spacer(),
                          Text("${statusModel.disbursalDate}")
                        ],
                      ),),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(padding: EdgeInsets.all(3),child: Row(
                        children: <Widget>[
                          Text("First Due Date"),

                          Spacer(),
                          Text("${statusModel.firstDueDate}")
                        ],
                      ),),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(padding: EdgeInsets.all(3),child: Row(
                        children: <Widget>[
                          Text("Final Due Date"),

                          Spacer(),
                          Text("${statusModel.finalDueDate}")
                        ],
                      ),),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(padding: EdgeInsets.all(3),child:  Row(
                        children: <Widget>[
                          Text("Status"),

                          Spacer(),
                          Text("${statusModel.status}")
                        ],
                      ),),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(padding: EdgeInsets.all(3),child:  Row(
                        children: <Widget>[
                          Text("Remaining Terms"),

                          Spacer(),
                          Text("${statusModel.RemainingTerm}")
                        ],
                      ),),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(padding: EdgeInsets.all(3),child:  Row(
                        children: <Widget>[
                          Text("Remaining Principal Amount"),

                          Spacer(),
                          Icon(Icons.currency_rupee,size: 18,),
                          Text("${remainingStatusModel.remainingPrincipal}")
                        ],
                      ),),SizedBox(
                        height: 10,
                      ),
                      Padding(padding: EdgeInsets.all(3),child:  Row(
                        children: <Widget>[
                          Text("Remaining Intrest Amount"),

                          Spacer(),
                          Text("${remainingStatusModel.remainingIntrest}")
                        ],
                      ),),SizedBox(
                        height: 10,
                      ),
                      Padding(padding: EdgeInsets.all(3),child:  Row(
                        children: <Widget>[
                          Text("Intrest Paid"),

                          Spacer(),
                          Icon(Icons.currency_rupee,size: 18,),
                          Text("${remainingStatusModel.intrestPaid}")
                        ],
                      ),),SizedBox(
                        height: 10,
                      ),
                      Padding(padding: EdgeInsets.all(3),child:  Row(
                        children: <Widget>[
                          Text("Closure Date"),

                          Spacer(),
                          Text("${statusModel.closureDate}")
                        ],
                      ),),
                    ],
                  )

              ),),
            SizedBox(
              height: 1,
            ),

            Padding(padding: EdgeInsets.all(0),
              child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                      width: 0,
                    ),
                  ),
                  height: 390,

                  child: Column(
                    children: [
                         Table(
                        defaultColumnWidth: FixedColumnWidth(94.0),
                        border: TableBorder.all(
                            color: Colors.green,
                            style: BorderStyle.solid,
                            width: 2),
                        children: [
                          TableRow(
                              children : [
                                Column(children:[Padding(padding: EdgeInsets.only(top: 14),child: Text('Component',)),SizedBox(
                                  height: 20,
                                )]),
                                Column(children:[Padding(padding: EdgeInsets.only(top: 14),child: Text('Due',)),SizedBox(
                                  height: 20,
                                )]),
                                Column(children:[Padding(padding: EdgeInsets.only(top: 14),child: Text('Reciept',)),SizedBox(
                                  height: 20,
                                )]),
                                Column(children:[Padding(padding: EdgeInsets.only(top: 14),child: Text('Overdue',)),SizedBox(
                                  height: 20,
                                )]),
                              ]
                          ),
                          TableRow(
                              children : [
                                Column(children:[
                                  Padding(padding: EdgeInsets.only(left: 10,top: 14),child: Text('Installment Amount')
                                  ),
                                  SizedBox(
                                    height: 20,
                                  )
                                ]),
                                Column(children:[
                                  Padding(padding: EdgeInsets.only(left: 3,top: 14),child: Text.rich(
                                    TextSpan(
                                      children: [

                                        WidgetSpan(
                                          child: Icon(Icons.currency_rupee,size: 15,),
                                        ),
                                        TextSpan(
                                          text: '${remainingStatusModel.remainingInstallment}',
                                        )
                                      ],
                                    ),
                                  )
                                  ),
                                  SizedBox(
                                    height: 20,
                                  )
                                  ]),
                                Column(children:[
                                  Padding(padding: EdgeInsets.only(left: 3,top: 14),child:   Text.rich(
                                    TextSpan(
                                      children: [

                                        WidgetSpan(
                                          child: Icon(Icons.currency_rupee,size: 15,),
                                        ),
                                        TextSpan(
                                          text: '${remainingStatusModel.installmentPaid}',
                                        )
                                      ],
                                    ),
                                  )
                                  ),
                                  SizedBox(
                                    height: 20,
                                  )
                                ]),
                                Column(children:[
                                  Padding(padding: EdgeInsets.only(left: 3,top: 14),child:Text.rich(
                                    TextSpan(
                                      children: [

                                        WidgetSpan(
                                          child: Icon(Icons.currency_rupee,size: 15,),
                                        ),
                                        TextSpan(
                                          text: '0.0',
                                        )
                                      ],
                                    ),
                                  )
                                  ),
                                  SizedBox(
                                    height: 20,
                                  )
                                  ]),
                              ]
                          ),
                          TableRow(
                              children : [
                                Column(children:[  Padding(padding: EdgeInsets.only(left: 10,top: 14),child: Text('Principal Amount')
                                ),
                                SizedBox(
                                  height: 20,
                                )]),
                                Column(children:[
                                  Padding(padding: EdgeInsets.only(left: 3,top: 14),child: Text.rich(
                                    TextSpan(
                                      children: [

                                        WidgetSpan(
                                          child: Icon(Icons.currency_rupee,size: 15,),
                                        ),
                                        TextSpan(
                                          text: '${remainingStatusModel.remainingPrincipal}',
                                        )
                                      ],
                                    ),
                                  )
                                  ),
                                  SizedBox(
                                    height: 20,
                                  )
                                 ]),
                                Column(children:[
                                  Padding(padding: EdgeInsets.only(left: 3,top: 14),child:     Text.rich(
                                    TextSpan(
                                      children: [

                                        WidgetSpan(
                                          child: Icon(Icons.currency_rupee,size: 15,),
                                        ),
                                        TextSpan(
                                          text: '${remainingStatusModel.principalPaid}',
                                        )
                                      ],
                                    ),
                                  )
                                  ),
                                  SizedBox(
                                    height: 20,
                                  )
                             ]),
                                Column(children:[
                                  Padding(padding: EdgeInsets.only(left: 3,top: 14),child:Text.rich(
                                    TextSpan(
                                      children: [

                                        WidgetSpan(
                                          child: Icon(Icons.currency_rupee,size: 15,),
                                        ),
                                        TextSpan(
                                          text: '0.0',
                                        )
                                      ],
                                    ),
                                  )
                                  ),
                                  SizedBox(
                                    height: 20,
                                  )
                                  ]),
                              ]
                          ),
                          TableRow(
                              children : [
                                Column(children:[  Padding(padding: EdgeInsets.only(left: 10,top: 14),child: Text('Intrest Component')
                                ),SizedBox(
                                  height: 20,
                                )]),
                                Column(children:[
                                  Padding(padding: EdgeInsets.only(left: 3,top: 14),child: Text.rich(
                                    TextSpan(
                                      children: [

                                        WidgetSpan(
                                          child: Icon(Icons.currency_rupee,size: 15,),
                                        ),
                                        TextSpan(
                                          text: '${remainingStatusModel.remainingIntrest}',
                                        )
                                      ],
                                    ),
                                  )
                                  ),
                                  SizedBox(
                                    height: 20,
                                  )
                                 ]),
                                Column(children:[
                                  Padding(padding: EdgeInsets.only(left: 3,top: 14),child:Text.rich(
                                    TextSpan(
                                      children: [

                                        WidgetSpan(
                                          child: Icon(Icons.currency_rupee,size: 15,),
                                        ),
                                        TextSpan(
                                          text: '${remainingStatusModel.intrestPaid}',
                                        )
                                      ],
                                    ),
                                  )
                                  ),
                                  SizedBox(
                                    height: 20,
                                  )
                                  ]),
                                Column(children:[
                                  Padding(padding: EdgeInsets.only(left: 3,top: 14),child: Text.rich(
                                    TextSpan(
                                      children: [

                                        WidgetSpan(
                                          child: Icon(Icons.currency_rupee,size: 15,),
                                        ),
                                        TextSpan(
                                          text: '0.0',
                                        )
                                      ],
                                    ),
                                  )
                                  ),
                                  SizedBox(
                                    height: 20,
                                  )
                                 ]),
                              ]
                          ),
                          TableRow(
                              children : [
                                Column(children:[  Padding(padding: EdgeInsets.only(left: 10,top: 14),child: Text('Bounce Charges')
                                ),
                                SizedBox(
                                  height: 20,
                                )]),
                                Column(children:[
                                  Padding(padding: EdgeInsets.only(left: 3,top: 14),child:Text.rich(
                                    TextSpan(
                                      children: [

                                        WidgetSpan(
                                          child: Icon(Icons.currency_rupee,size: 15,),
                                        ),
                                        TextSpan(
                                          text: '0.0',
                                        )
                                      ],
                                    ),
                                  )
                                  ),
                                  SizedBox(
                                    height: 20,
                                  )

                                ]),
                                Column(children:[
                                  Padding(padding: EdgeInsets.only(left: 3,top: 14),child: Text.rich(
                                    TextSpan(
                                      children: [

                                        WidgetSpan(
                                          child: Icon(Icons.currency_rupee,size: 15,),
                                        ),
                                        TextSpan(
                                          text: '0.0',
                                        )
                                      ],
                                    ),
                                  )
                                  ),
                                  SizedBox(
                                    height: 20,
                                  )
                                 ]),
                                Column(children:[
                                  Padding(padding: EdgeInsets.only(left: 3,top: 14),child: Text.rich(
                                    TextSpan(
                                      children: [

                                        WidgetSpan(
                                          child: Icon(Icons.currency_rupee,size: 15,),
                                        ),
                                        TextSpan(
                                          text: '0.0',
                                        )
                                      ],
                                    ),
                                  )
                                  ),
                                  SizedBox(
                                    height: 20,
                                  )
                                 ]),
                              ]
                          ),
                          TableRow(
                              children : [
                                Column(children:[ Padding(padding: EdgeInsets.only(left: 10,top: 14),child:Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Other Recievables',
                                      )
                                    ],
                                  ),
                                )
                                ),
                                SizedBox(
                                  height: 20,
                                )]),
                                Column(children:[  Padding(padding: EdgeInsets.only(left: 3,top: 14),child:Text("NA")
                                ),
                                  SizedBox(
                                    height: 20,
                                  )]),
                                Column(children:[
                                  Padding(padding: EdgeInsets.only(left: 3,top: 14),child: Text("NA")
                                  ),
                                  SizedBox(
                                    height: 20,
                                  )
                                 ]),
                                Column(children:[
                                  Padding(padding: EdgeInsets.only(left: 3,top: 14),child: Text('NA')
                                  ),
                                  SizedBox(
                                    height: 20,
                                  )
                                 ]),
                              ]
                          ),
                        ],
                      ),



                    ],
                  )

              ),),
            // GestureDetector(
            //   onTap: getDetails,
            //   child:
            //     DropdownButtonFormField(items: [addressModel],
            //
            //     )
            //
            // )
          ],
        )
      ),


    );


  }


}
