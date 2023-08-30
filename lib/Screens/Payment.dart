import 'dart:convert';
import 'dart:ffi';
import 'dart:math';
import 'dart:developer';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loans/Model/UnbilledTransactionModel.dart';
import 'package:loans/Screens/LoanStatus.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
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


class Payment extends StatefulWidget{
  ActiveLaonsModel model;
  double dueInstallment;
  String date;
  LoanStatusModel statusModel;
  RemainingPaymentModel remainingStatusModel;
  Payment(this.model,this.statusModel,this.remainingStatusModel,this.date,this.dueInstallment);
  @override
  State<StatefulWidget> createState() {
    return PaymentState(this.model,this.statusModel,this.remainingStatusModel,this.date,this.dueInstallment);
  }

}

Future<UnbilledTransactionModel?> getUnbilledDebitTransactionDetailByStatement(String paymentDate, double amt, String transactionType, String description)
async{
  var url = "http://10.0.2.2:8091/api/saveTransactionDetails";
  try
  {
    var response = await http.post(url,
        headers: {"Content-Type" : "application/json"},
        body:jsonEncode({
          "transactionDate": paymentDate,
          "transactionAmount" : amt,
          "transactionType" : transactionType,
          "description" : description,
        }));
  }
  catch(e) {
    debugPrint(e.toString());
  }
}
Future<void> updatePaymentSchedule(double amt)
async{
  String url = "http://10.0.2.2:8091/api/updatePaymentSchedule/"+"${amt}";
  var data = await http.post(url);


}


class PaymentState  extends State<Payment>{
  ActiveLaonsModel model;
  late Razorpay _razorpay;
  double dueInstallment;
  String date;
  FocusNode myFocusNode1 = new FocusNode();
  final amountController = TextEditingController();
  var _amount = "";
  bool isEnabled = true;
  LoanStatusModel statusModel;
  RemainingPaymentModel remainingStatusModel;
  PaymentState(this.model,this.statusModel,this.remainingStatusModel,this.date,this.dueInstallment);

  bool   tapped = false;
  bool installemntTapped = false;
  var ctr=0;
  var ctr1=0;
  var amt = 0.00;

  @override
  void initState() {
    super.initState();
    _razorpay = new Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
    _razorpay.clear();
  }

  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
    print("Payment Success");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Payment Success"),
      ),
    );
    verifySignature(
      signature: response.signature,
      paymentId: response.paymentId,
      orderId: response.orderId,
    );
    DateTime dateToday =new DateTime.now();
    var outputFormat = DateFormat('yyyy-MM-dd');
    var paymentDate = outputFormat.format(dateToday);
    String transactionType = "C";
    String description = "installment credit";
    await getUnbilledDebitTransactionDetailByStatement(paymentDate,amt,transactionType,description);
    await updatePaymentSchedule(amt);
   Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoanStatus(model, todayDate),));

  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("Payment Failed");

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Payment Failed"),
      ),
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
      print("External wallet");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.walletName ?? ''),
        ),
      );
  }
  void createOrder() async {
    String username = "rzp_test_OFmkfaixwq9ihi";
    String password = "EkIRoNi7tMO9kS06HJoyjr79";
    String basicAuth =
        'Basic ${base64Encode(utf8.encode('$username:$password'))}';

    Map<String, dynamic> body = {
      "amount": amt*100,
      "currency": "INR",
      "receipt": "rcptid_11"
    };
    var res = await http.post(
      Uri.https(
          "api.razorpay.com", "v1/orders"), //https://api.razorpay.com/v1/orders
      headers: <String, String>{
        "Content-Type": "application/json",
        'authorization': basicAuth,
      },
      body: jsonEncode(body),
    );

    if (res.statusCode == 200) {
      openGateway(jsonDecode(res.body)['id']);
    }
    print(res.body);
  }

  openGateway(String orderId) {
    var options = {
      'key': "rzp_test_OFmkfaixwq9ihi",
      'amount': amt*100, //in the smallest currency sub-unit.
      'name': 'Loan Managemant.',
      'order_id': orderId, // Generate order_id using Orders API
      'description': 'Loan payments',
      'timeout': 60 * 5, // in seconds // 5 minutes
      'prefill': {
        'contact': statusModel.mobilenumber,
        'email': statusModel.emailId,
      },'retry': {'enabled': true, 'max_count': 1},'send_sms_hash': true,
      "external" : {
        "wallets" : ["paytm"]
      }


    };
    _razorpay.open(options);
  }

  verifySignature({
    String? signature,
    String? paymentId,
    String? orderId,
  }) async {
    Map<String, dynamic> body = {
      'razorpay_signature': signature,
      'razorpay_payment_id': paymentId,
      'razorpay_order_id': orderId,
    };

    var parts = [];
    body.forEach((key, value) {
      parts.add('${Uri.encodeQueryComponent(key)}='
          '${Uri.encodeQueryComponent(value)}');
    });
    var formData = parts.join('&');
    var res = await http.post(
      Uri.https(
        "10.0.2.2", // my ip address , localhost
        "razorpay_signature_verify.php",
      ),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded", // urlencoded
      },
      body: formData,
    );

    print(res.body);
    if (res.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(res.body),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if(statusModel.closureDate == "Jan 1, 1900"){
      statusModel.closureDate = "\t";
    }

    TextStyle? textstyle = Theme.of(context).textTheme.subtitle2;
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment"),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
          child: Column(

            children: [
              Padding(padding: EdgeInsets.all(7),
                child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.green,
                        width: 2.2,
                      ),
                    ),
                    height: 251,

                    child: Column(
                      children: [
                        Padding(padding: EdgeInsets.all(3),child: Row(
                          children: <Widget>[
                            Text("Loan Amount",style: TextStyle(
                              fontWeight: FontWeight.bold
                            ),),

                            Spacer(),
                            // SizedBox(
                            //   width: 20,
                            // ),
                            Icon(Icons.currency_rupee,size: 18,),
                            Text("${statusModel.loanAmount}")
                          ],
                        ),),
                        Divider(
                          color: Colors.grey,
                          thickness: 1.2,
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Padding(padding: EdgeInsets.all(3),child:  Row(
                          children: <Widget>[
                            Text("Term",style: TextStyle(
                                fontWeight: FontWeight.bold
                            ),),

                            Spacer(),
                            Text("${statusModel.term}")
                          ],
                        ),),
                        Divider(
                          color: Colors.grey,
                          thickness: 1.2,
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Padding(padding: EdgeInsets.all(3),child: Row(
                          children: <Widget>[
                            Text("Intrest Rate",style: TextStyle(
                                fontWeight: FontWeight.bold
                            ),),

                            Spacer(),
                            Text("${statusModel.intrestRate}"+"%")
                          ],
                        ),),
                        Divider(
                          color: Colors.grey,
                          thickness: 1.2,
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Padding(padding: EdgeInsets.all(3),child: Row(
                          children: <Widget>[
                            Text("Intrest Type",style: TextStyle(
                                fontWeight: FontWeight.bold
                            ),),

                            Spacer(),
                            Text("${statusModel.intrestType}")
                          ],
                        ),),
                        Divider(
                          color: Colors.grey,
                          thickness: 1.2,
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Padding(padding: EdgeInsets.all(3),child:Row(
                          children: <Widget>[
                            Text("Installment",style: TextStyle(
                                fontWeight: FontWeight.bold
                            ),),

                            Spacer(),
                            Icon(Icons.currency_rupee,size: 18,),
                            Text("${statusModel.installmentAmount}")
                          ],
                        ),),
                        Divider(
                          color: Colors.grey,
                          thickness: 1.2,
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Padding(padding: EdgeInsets.all(3),child: Row(
                          children: <Widget>[
                            Text("Next Due Date",style: TextStyle(
                                fontWeight: FontWeight.bold
                            )),

                            Spacer(),
                            Text("${date}")
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

              Padding(padding: EdgeInsets.all(7),
                child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.green,
                        width: 2.2,
                      ),
                    ),
                    height: 299,

                    child: Column(
                      children: [
                        Padding(padding: EdgeInsets.all(3),child: Row(
                          children: <Widget>[
                            Text("Number of Installment's Remaining",style: TextStyle(
                                fontWeight: FontWeight.bold
                            )),

                            Spacer(),


                            Text("${statusModel.remainingTerm}")
                          ],
                        ),),
                        Divider(
                          color: Colors.grey,
                          thickness: 1.2,
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Padding(padding: EdgeInsets.all(3),child:  Row(
                          children: <Widget>[
                            Text("Principal Paid",style: TextStyle(
                                fontWeight: FontWeight.bold
                            )),

                            Spacer(),
                            Icon(Icons.currency_rupee,size: 18,),
                            Text("${remainingStatusModel.principalPaid}")
                          ],
                        ),),
                        Divider(
                          color: Colors.grey,
                          thickness: 1.2,
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Padding(padding: EdgeInsets.all(3),child: Row(
                          children: <Widget>[
                            Text("Intrest Paid",style: TextStyle(
                                fontWeight: FontWeight.bold
                            )),

                            Spacer(),
                            Icon(Icons.currency_rupee,size: 18,),
                            Text("${remainingStatusModel.intrestPaid}")
                          ],
                        ),),
                        Divider(
                          color: Colors.grey,
                          thickness: 1.2,
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Padding(padding: EdgeInsets.all(3),child: Row(
                          children: <Widget>[
                            Text("Principal outstanding",style: TextStyle(
                                fontWeight: FontWeight.bold
                            )),

                            Spacer(),
                            Icon(Icons.currency_rupee,size: 18,),
                            Text("${remainingStatusModel.remainingPrincipal}")
                          ],
                        ),),
                        Divider(
                          color: Colors.grey,
                          thickness: 1.2,
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Padding(padding: EdgeInsets.all(3),child:Row(
                          children: <Widget>[
                            Text("Principal overdue",style: TextStyle(
                                fontWeight: FontWeight.bold
                            )),

                            Spacer(),
                            Icon(Icons.currency_rupee,size: 18,),
                            Text("0.00")
                          ],
                        ),),
                        Divider(
                          color: Colors.grey,
                          thickness: 1.2,
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Padding(padding: EdgeInsets.all(3),child: Row(
                          children: <Widget>[
                            Text("Intrest Over Due",style: TextStyle(
                                fontWeight: FontWeight.bold
                            )),

                            Spacer(),
                            Icon(Icons.currency_rupee,size: 18,),
                            Text("0.00")
                          ],
                        ),),
                        Divider(
                          color: Colors.grey,
                          thickness: 1.2,
                        ),
                        SizedBox(
                          height:  4,
                        ),
                        Padding(padding: EdgeInsets.all(3),child: Row(
                          children: <Widget>[
                            Text("Other Dues",style: TextStyle(
                                fontWeight: FontWeight.bold
                            )),

                            Spacer(),
                            Text("0")
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
              Text("Please select which amount to pay",style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16
              ),),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          GestureDetector(

                            onTap: (){
                              setState(() {
                               tapped=!tapped;
                               installemntTapped = false;
                               ctr=1;
                               amt=dueInstallment;
                              });
                            },
                            child:  Card(
                              elevation: 6,
                              child: Container(
                                  alignment: Alignment.center,
                                  height: 70,
                                  width: 170,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: tapped==true ? Colors.yellow : Colors.white10 ,
                                          width: 3.7
                                      )
                                  ),
                                  child:Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: Column(
                                      children: [
                                        Text("Total Due",style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16
                                        ),),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.currency_rupee,size: 18,),
                                            Text("${dueInstallment}")
                                          ],
                                        )

                                      ],
                                    ),
                                  )

                              ),
                            ),

                          ),


                          GestureDetector(
                            onTap: (){
                              setState(() {
                                installemntTapped=!installemntTapped;
                               tapped = false;
                               ctr=1;
                               amt=statusModel.installmentAmount!;

                              });
                            },

                            child: Card(
                              elevation: 6,
                              child: Container(

                                alignment: Alignment.center,
                                height: 70,
                                width: 170,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: installemntTapped==true ? Colors.yellow : Colors.white10,
                                        width: 3.7
                                    )
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child:Column(
                                    children: [
                                      Text("Intsallment",style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16
                                      ),textAlign: TextAlign.center,),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.currency_rupee,size: 18,),
                                          Text("${statusModel.installmentAmount}")
                                        ],
                                      )





                                    ],
                                  ) ,
                                ),

                              ),
                            ),
                          )


                        ],
                      ),



                  )

                ],
              ),
              // SizedBox(
              //   height: 20,
              // ),
              // Padding(padding: EdgeInsets.only(left: 12,right: 12),child: Column(
              //   children: [
              //     TextFormField(
              //         focusNode: myFocusNode1,
              //         decoration: InputDecoration(
              //           labelText: "Amount",
              //           labelStyle: TextStyle(
              //               color: myFocusNode1.hasFocus ? Colors.blue : Colors
              //                   .indigo
              //           ),
              //           focusedBorder: UnderlineInputBorder(
              //               borderSide: BorderSide(
              //                   color: Colors.indigo, width: 3.0
              //               )
              //           ),
              //           hintText: "Enter amount to be paid",
              //           // errorText: _phoneNumberError,
              //
              //         ),
              //         controller: amountController,
              //         keyboardType: TextInputType.phone,
              //         inputFormatters: <TextInputFormatter>[
              //           FilteringTextInputFormatter.digitsOnly
              //         ],
              //         validator: (text) {
              //           if (text!.isEmpty) {
              //
              //             return "Phone number can\'t be empty";
              //           }
              //         },
              //         autovalidateMode: AutovalidateMode.onUserInteraction,
              //         onChanged: (number) {
              //           if (number.isNotEmpty) {
              //             setState(() {
              //               ctr1 = 1;
              //               isEnabled = true;
              //               amt = amountController.value as double;
              //             });
              //           }
              //           _amount;
              //         }
              //
              //
              //     ),
              //
              //   ],
              // ),),
              //



              Padding(padding: EdgeInsets.all(10),
              child:  SizedBox(
                width: double.infinity,
                child: ElevatedButton(

                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100)),
                    backgroundColor: Colors.indigo,

                  ),
                  onPressed: (){
                    if(ctr==1)
                      {
                        createOrder();
                      }

                  },
                  child: Text("Pay"),
                ),
              ),)





            ],
          )
      ),


    );


  }


}
