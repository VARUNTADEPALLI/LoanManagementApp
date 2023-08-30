import 'dart:convert';
import 'dart:ffi';


import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:flutter/services.dart';
import 'package:expandable/expandable.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:loans/Model/CustomerModel.dart';
import 'package:loans/Model/LoanStatusModel.dart';
import 'package:loans/Model/RemainingPaymentModel.dart';
import 'package:loans/Model/StatementDateModel.dart';
import 'package:loans/Model/StatementDetails.dart';
import 'package:loans/Model/StatementTransactions.dart';
import 'package:loans/Model/TransactionDetailsModel.dart';
import 'package:loans/Screens/ForgotPassword.dart';
import 'package:loans/Screens/Home.dart';
import 'package:loans/Screens/NewUserRegistration.dart';

class Transactions extends StatefulWidget {
  StatementDetails details2;
  List<String> dates;
  List<String> formatted;
  StatementTransactions credit;
  StatementTransactions debit;
  List<TransactionDetailsModel> transactions;
  LoanStatusModel statusModel;
  RemainingPaymentModel remainingStatusModel;
  Transactions(this.dates,this.remainingStatusModel,this.statusModel,this.transactions,this.credit,this.debit,this.details2,this.formatted);
  @override
  State<StatefulWidget> createState() {
    return transactionsState(this.dates,this.remainingStatusModel,this.statusModel,this.transactions,this.credit,this.debit,this.details2,this.formatted);
  }
}



class transactionsState extends State<Transactions> {

  StatementDetails details2;
  StatementTransactions credit;
  StatementTransactions debit;
  List<TransactionDetailsModel> transactions;
  List<String> dates;
  List<String> formatted;
  var len = 0;
  LoanStatusModel statusModel;
  RemainingPaymentModel remainingStatusModel;
  transactionsState(this.dates,this.remainingStatusModel,this.statusModel,this.transactions,this.credit,this.debit,this.details2,this.formatted);
  StatementTransactions credit1  = new StatementTransactions();
  StatementTransactions debit1  = new StatementTransactions();
  LoanStatusModel statusModel2 = new LoanStatusModel();
  LoanStatusModel loanStatusModel = new LoanStatusModel();

  List<TransactionDetailsModel> transactions1  = [];

  StatementTransactions unbilledcredit  = new StatementTransactions();
  StatementTransactions unbilledcredit1  = new StatementTransactions();
  StatementTransactions unbilleddebit1  = new StatementTransactions();
  StatementTransactions unbilleddebit  = new StatementTransactions();


  StatementDetails details1 = new StatementDetails();
  
 
  
String dropdownvalue = "";
String temp = "";

  Future<StatementDetails> getTransactionDetailByStatement(String dropdownvalue)
  async{

    var month = int.parse(dropdownvalue.substring(0,1));
    var day  = int.parse(dropdownvalue.substring(2,3));
    String month1 = '';
    String day1 = '';
    if(month<10)
      {
        month1 = "0"+ dropdownvalue.substring(0,1);
      }
    else if(month>=10)
      {
        month1 =  dropdownvalue.substring(0,1);
      }
    if(day<10)
      {
        day1 = "0"+ dropdownvalue.substring(2,3);
      }
    else if(day>=10)
      {
        day1 = dropdownvalue.substring(2,3);
      }
    String date = dropdownvalue.substring(4,)+ "-" +month1+"-"+day1;
    print(date);
    String url = "http://10.0.2.2:8091/api/statement-summary/"+"${date}";
    var data = await http.post(url);
    var jsonData = json.decode(data.body);
    print(jsonData);
    StatementDetails details = new StatementDetails();
    details.statementDate =  DateFormat.yMMMd().format(DateTime.parse(jsonData["statementDate"]));
    details.loanId = jsonData["loanId"];
    details.thirtyDays = jsonData["thirtyDays"];
    details.sixtyDays = jsonData["sixtyDays"];
    details.overDueDays = jsonData["overDueDays"];
    details.overDueAmount = jsonData["overDueAmount"];
    details.oneTwentyDays = jsonData["oneTwentyDays"];
    details.oneFiftyDays = jsonData["oneFiftyDays"];
    details.oneEightyDays = jsonData["oneEightyDays"];
    details.oneEightyDaysPlus = jsonData["oneEightyDaysPlus"];
    details.ninetyDays = jsonData["ninetyDays"];
    details.currentDueAmount = jsonData["currentDueAmount"];
    details.balance = jsonData["balance"];
    return details;
  }

  Future<StatementTransactions> getCreditTransactionDetailByStatement(String dropdownvalue)
  async{

    var month = int.parse(dropdownvalue.substring(0,1));
    var day  = int.parse(dropdownvalue.substring(2,3));
    String month1 = '';
    String day1 = '';
    if(month<10)
    {
      month1 = "0"+ dropdownvalue.substring(0,1);
    }
    else if(month>=10)
    {
      month1 =  dropdownvalue.substring(0,1);
    }
    if(day<10)
    {
      day1 = "0"+ dropdownvalue.substring(2,3);
    }
    else if(day>=10)
    {
      day1 = dropdownvalue.substring(2,3);
    }
    String date = dropdownvalue.substring(4,)+ "-" +month1+"-"+day1;
    String url = "http://10.0.2.2:8091/api/statementCreditTransactions/"+"${date}/"+"${statusModel.loanId}";
    var data = await http.post(url);
    var jsonData = json.decode(data.body);
    print(jsonData);
    StatementTransactions details = new StatementTransactions();
    details.transactionAmount = jsonData["transactionAmount"];
    details.id = jsonData["id"];
    details.description = jsonData["description"];
    return details;
  }

  Future<StatementTransactions> getDebitTransactionDetailByStatement(String dropdownvalue)
  async{

    var month = int.parse(dropdownvalue.substring(0,1));
    var day  = int.parse(dropdownvalue.substring(2,3));
    String month1 = '';
    String day1 = '';
    if(month<10)
    {
      month1 = "0"+ dropdownvalue.substring(0,1);
    }
    else if(month>=10)
    {
      month1 =  dropdownvalue.substring(0,1);
    }
    if(day<10)
    {
      day1 = "0"+ dropdownvalue.substring(2,3);
    }
    else if(day>=10)
    {
      day1 = dropdownvalue.substring(2,3);
    }
    String date = dropdownvalue.substring(4,)+ "-" +month1+"-"+day1;
    String url = "http://10.0.2.2:8091/api/statementDebitTransactions/"+"${date}/"+"${statusModel.loanId}";
    var data = await http.post(url);
    var jsonData = json.decode(data.body);
    print(jsonData);
    StatementTransactions details = new StatementTransactions();

    details.transactionAmount = jsonData["transactionAmount"];
    details.id = jsonData["id"];

    return details;
  }


  Future<List<TransactionDetailsModel>> getTransactionDetailsByStatement(String dropdownvalue)
  async{
    var month = int.parse(dropdownvalue.substring(0,1));
    var day  = int.parse(dropdownvalue.substring(2,3));
    String month1 = '';
    String day1 = '';
    if(month<10)
    {
      month1 = "0"+ dropdownvalue.substring(0,1);
    }
    else if(month>=10)
    {
      month1 =  dropdownvalue.substring(0,1);
    }
    if(day<10)
    {
      day1 = "0"+ dropdownvalue.substring(2,3);
    }
    else if(day>=10)
    {
      day1 = dropdownvalue.substring(2,3);
    }
    String date = dropdownvalue.substring(4,)+ "-" +month1+"-"+day1;
    String url = "http://10.0.2.2:8091/api/statementTransactions/"+"${date}/"+"${statusModel.loanId}";
    var data = await http.post(url);
    var jsonData = json.decode(data.body);
    print(jsonData);
    List<TransactionDetailsModel> details = [];
    for(var al in jsonData)
    {
      TransactionDetailsModel st = new TransactionDetailsModel();
      st.creditAmount = al["creditAmount"];
      st.debitAmount = al["debitAmount"];
      st.description = al["description"];
      st.transactionDate = DateFormat.yMMMMd().format(DateTime.parse(al["transactionDate"]));
      details.add(st);
    }
    return details;
  }


  Future<StatementTransactions> getUnbilledCreditTransactionDetailByStatement()
  async{
    String url = "http://10.0.2.2:8091/api/UnbilledCreditTransactions/"+"${statusModel.loanId}";
    var data = await http.post(url);
    var jsonData = json.decode(data.body);
    print(jsonData);
    StatementTransactions details = new StatementTransactions();
    details.transactionAmount = jsonData["transactionAmount"];
    details.id = jsonData["id"];
    return details;
  }


  Future<StatementTransactions> getUnbilledDebitTransactionDetailByStatement()
  async{
    String url = "http://10.0.2.2:8091/api/UnbilledDebitTransactions/"+"${statusModel.loanId}";
    var data = await http.post(url);
    var jsonData = json.decode(data.body);
    print(jsonData);
    StatementTransactions details = new StatementTransactions();
    details.transactionAmount = jsonData["transactionAmount"];
    details.id = jsonData["id"];
    return details;
  }

  Future<List<DateTime>> getStatementDates()
  async{
    print("loan id" + "${statusModel.loanId}");
    String url = "http://10.0.2.2:8091/api/statementdates/"+"${statusModel.loanId}";
    var data = await http.get(url);
    var jsonData = json.decode(data.body);
    print(" loan id ${statusModel.loanId}");
    print(jsonData);

    List<DateTime> model = [];
    for(var al in jsonData)
    {
      model.add(al["statementDate"]);
    }
    print(model);
    return model;
  }


  @override
  Widget build(BuildContext context) {
   dropdownvalue = formatted[0];
   final rows = <TableRow>[];
   // for (var rowData in transactions) {
   //   rows.add(
   //       TableRow(
   //     children : [
   //       Column(children:[Padding(padding: EdgeInsets.only(top: 14,left: 5),child: Text('${rowData.transactionDate}')),SizedBox(
   //         height: 20,
   //       )]),
   //       Column(children:[Padding(padding: EdgeInsets.only(top: 14),child: Text('${rowData.creditAmount}')),SizedBox(
   //         height: 20,
   //       )]),
   //       Column(children:[Padding(padding: EdgeInsets.only(top: 14),child: Text('${rowData.debitAmount}')),SizedBox(
   //         height: 20,
   //       )]),
   //       Column(children:[Padding(padding: EdgeInsets.only(top: 14),child: Text('${rowData.description}')),SizedBox(
   //         height: 20,
   //       )]),
   //     ],
   //   ));
   // }

    TextStyle? textstyle = Theme
        .of(context)
        .textTheme
        .subtitle2;

    return Scaffold(
      appBar: AppBar(
        title: Text("Transactions"),

      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 20),


          child :Padding(
              padding: EdgeInsets.all(15),
              child:  Column(
                  children: [
                    Row(
                      children: [
                        RichText(
                            text: TextSpan(
                                text: 'Statement Date',
                                style: TextStyle(
                                    color: Colors.black
                                ),
                                children: [
                                  TextSpan(
                                      text: ' *',
                                      style: TextStyle(
                                        color: Colors.red,
                                      ))
                                ]),
                            maxLines: 1,
                            textAlign: TextAlign.end),
                      ],
                    ),

                    SizedBox(
                      height: 10,
                    ),
                    DropdownButtonFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 3),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      dropdownColor: Colors.white,
                      value: dropdownvalue.isNotEmpty ? dropdownvalue:null,
                      onChanged: (String? newValue) async {
                        setState(()  {
                          dropdownvalue = newValue!;
                        });
                        for(int i=0;i<formatted.length;i++)
                          {
                            if(dropdownvalue==formatted[i])
                              {
                                dropdownvalue = dates[i];
                                break;
                              }
                          }
                        temp=dropdownvalue;
                        if(temp==dates[0])
                          {
                            unbilledcredit1 = await getUnbilledCreditTransactionDetailByStatement();
                            setState(() {
                              unbilledcredit =unbilledcredit1;
                              credit.id = unbilledcredit1.id;
                              credit.transactionAmount = unbilledcredit.transactionAmount;
                            });
                            unbilleddebit1 = await getUnbilledDebitTransactionDetailByStatement();
                              setState(() {
                                unbilleddebit =unbilleddebit1;
                                debit.id = unbilleddebit1.id;
                                debit.transactionAmount = unbilleddebit.transactionAmount;
                              });


                            print(temp);
                          }

                        else
                          {
                            details1  = await getTransactionDetailByStatement(temp);
                            setState(()  {
                              details2 = details1;
                            });

                            credit1  = await getCreditTransactionDetailByStatement(temp);
                            setState(()  {
                              credit = credit1;
                            });
                            debit1  = await getDebitTransactionDetailByStatement(temp);
                            setState(()  {
                              debit = debit1;
                            });
                            transactions1 = await getTransactionDetailsByStatement(temp);setState(()  {
                              transactions = transactions1;
                            });
                            len = transactions.length;

                            print("${credit.transactionAmount}");
                          }





                      },
                      items: formatted.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),),
                    SizedBox(
                      height: 30,
                    ),
                  //   Text("${transactions[0].transactionDate}"),
                    ListTileTheme(
                      tileColor: Colors.deepPurple,
                      child:  ExpansionTile(
                        title: Text("Current Outstanding",
                          style: TextStyle(
                              color: Colors.white
                          ),),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text("Remaining Term"),
                                    Spacer(),
                                    Text("${statusModel.remainingTerm}")
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text("Principal Outstanding"),
                                    Spacer(),
                                    Icon(Icons.currency_rupee,size: 18,),
                                    Text("${remainingStatusModel.remainingPrincipal}")
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text("Intrest Outstanding"),
                                    Spacer(),
                                    Icon(Icons.currency_rupee,size: 18,),
                                    Text("${remainingStatusModel.remainingIntrest}")
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text("Other Outstanding"),
                                    Spacer(),
                                    Icon(Icons.currency_rupee,size: 18,),
                                    Text("0.0")
                                  ],
                                )

                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),

                    ListTileTheme(
                      tileColor: Colors.deepPurple,
                      child:  ExpansionTile(
                        title: Text("Deliquency",
                          style: TextStyle(
                              color: Colors.white
                          ),),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text("Over Due Days"),
                                    Spacer(),
                                    Text("${details2.overDueDays}")
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text("Over Due amount"),
                                    Spacer(),
                                    Icon(Icons.currency_rupee,size: 18,),
                                    Text("${details2.overDueAmount}")
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text("Current Due Amount"),
                                    Spacer(),
                                    Icon(Icons.currency_rupee,size: 18,),
                                    Text("${details2.currentDueAmount}")
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text("1-30 Days"),
                                    Spacer(),
                                    Icon(Icons.currency_rupee,size: 18,),
                                    Text("${details2.thirtyDays}")
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text("31-60 Days"),
                                    Spacer(),
                                    Icon(Icons.currency_rupee,size: 18,),
                                    Text("${details2.sixtyDays}")
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text("61-90 Days"),
                                    Spacer(),
                                    Icon(Icons.currency_rupee,size: 18,),
                                    Text("${details2.ninetyDays}")
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text("91-120 Days"),
                                    Spacer(),
                                    Icon(Icons.currency_rupee,size: 18,),
                                    Text("${details2.oneTwentyDays}")
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text("121-150 Days"),
                                    Spacer(),
                                    Icon(Icons.currency_rupee,size: 18,),
                                    Text("${details2.oneFiftyDays}")
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text("151-180 Days"),
                                    Spacer(),
                                    Icon(Icons.currency_rupee,size: 18,),
                                    Text("${details2.oneEightyDays}")
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text("180+ Days"),
                                    Spacer(),
                                    Icon(Icons.currency_rupee,size: 18,),
                                    Text("${details2.oneEightyDaysPlus}")
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                // Row(
                                //   children: [
                                //     Text("1-30 Days"),
                                //     Spacer(),
                                //     Icon(Icons.currency_rupee,size: 18,),
                                //     Text("${details2.currentDueAmount}")
                                //   ],
                                // )

                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    ListTileTheme(
                      tileColor: Colors.deepPurple,
                      child:  ExpansionTile(
                        title: Text("Account Movement",
                          style: TextStyle(
                              color: Colors.white
                          ),),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text("Credits"),
                                    Spacer(),
                                    Text("${credit.id}")
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text("Debits"),
                                    Spacer(),
                                    //Icon(Icons.currency_rupee,size: 18,),
                                    Text("${debit.id}")
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text("Credit Amount"),
                                    Spacer(),
                                    Icon(Icons.currency_rupee,size: 18,),
                                    Text("${credit.transactionAmount}")
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text("Debit Amount"),
                                    Spacer(),
                                    Icon(Icons.currency_rupee,size: 18,),
                                    Text("${debit.transactionAmount}")
                                  ],
                                )

                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),

                  ListTileTheme(
                    tileColor: Colors.deepPurple,
                    child:  ExpansionTile(
                      title: Text("Transaction Details",
                        style: TextStyle(
                            color: Colors.white
                        ),),
                      children: [
                        temp==dates[0] ? Padding(padding: EdgeInsets.all(12),
                        child: Text("No Transactions Available") ,)
                        : Padding(
    padding: const EdgeInsets.all(12.0),
    child: Column(
    children: [
    Row(
    children: [
    Text("Transaction Date"),
    Spacer(),
    Text("Credit"),
    Spacer(),
    Text("Debit"),
    Spacer(),
    Text("Description"),
    ],

    ),
    SizedBox(
    height: 20,
    ),
    ListView.builder(scrollDirection: Axis.vertical,
    shrinkWrap: true,itemCount: transactions.length,itemBuilder:(BuildContext context,int index){

    return Row(
    children: [
    Text("${transactions[index].transactionDate}"),
    Spacer(),
    Text("${transactions[index].creditAmount}"),
    Spacer(),
    Text("${transactions[index].debitAmount}"),
    Spacer(),
    Text("${transactions[index].description}"),

    ],
    );
    }),
    ],
    )
    ),
                      ],
                      // children: [
                      //
                      // ],
                    ),
                  )



                      ]
                      )

                      )



                      )
                      ,
    );
  }
}
extension MyDateExtension on DateTime {
  DateTime getOnlyDate(){
    return DateTime(this.year, this.month, this.day);
  }
}



