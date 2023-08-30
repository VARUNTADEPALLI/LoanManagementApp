import 'dart:convert';
import 'dart:math';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart';
import 'package:loans/Model/ActiveLoansModel.dart';
import 'package:loans/Model/CustomerModel.dart';
import 'package:loans/Model/LoanStatusModel.dart';
import 'package:loans/Model/PaymentModel.dart';
import 'package:loans/Model/RemainingPaymentModel.dart';
import 'package:loans/Model/StatementDateModel.dart';
import 'package:loans/Model/StatementDetails.dart';
import 'package:loans/Model/StatementTransactions.dart';
import 'package:loans/Model/TermWiseDetails.dart';
import 'package:loans/Model/TransactionDetailsModel.dart';
import 'package:loans/Screens/LoanDetails.dart';
import 'package:loans/Screens/Login.dart';
import 'package:http/http.dart' as http;
import 'package:loans/Screens/Payment.dart';
import 'package:loans/Screens/PaymentSchedule.dart';
import 'package:loans/Screens/Transactions.dart';

class LoanStatus extends StatefulWidget{
  String todayDate;
  ActiveLaonsModel model;
  LoanStatus(this.model,this.todayDate);
  @override
  State<StatefulWidget> createState() {
    return LaonStatusState(this.model,this.todayDate);
  }

}


class LaonStatusState  extends State<LoanStatus>{
  ActiveLaonsModel model;
  String todayDate;
  LaonStatusState(this.model,this.todayDate);

  List<TransactionDetailsModel> transactions  = [];
  StatementTransactions credit  = new StatementTransactions();
  StatementTransactions debit  = new StatementTransactions();
  StatementTransactions unbilledcredit  = new StatementTransactions();
  StatementTransactions unbilleddebit  = new StatementTransactions();
  StatementTransactions unbilledcredit1  = new StatementTransactions();
  StatementTransactions unbilleddebit1  = new StatementTransactions();
  StatementDetails details2 = new StatementDetails();


  @override
  Widget build(BuildContext context) {
    ActiveLaonsModel activeLaonsModel= new ActiveLaonsModel();
    activeLaonsModel.name =model.name;
    activeLaonsModel.loanType = model.loanType;
    activeLaonsModel.mobilenumber = model.mobilenumber;
    activeLaonsModel.customerId = model.customerId;
    activeLaonsModel.loanAmount = model.loanAmount;
    activeLaonsModel.loanId = model.loanId;

    if(model.loanType=="Personal Loan")
    {
      model.loanType = "PL";
    }
    else if(model.loanType=="Auto Loan")
    {
      model.loanType = "AL";
    }

    Future<LoanStatusModel> getActiveLoanDetailsOfCustomer()
    async{
      String url = "http://10.0.2.2:8091/api/getLoanDetails/"+"${model.customerId}/"+"${model.loanType}/"+"${model.mobilenumber}";
      var data = await http.get(url);
      var jsonData = json.decode(data.body);
      print(jsonData);

      LoanStatusModel loanStatusModel = new LoanStatusModel();
      //DateFormat date_format = new DateFormat("dd-MM-yyyy");
        loanStatusModel.name = jsonData["name"];
        loanStatusModel.customerId = jsonData["customerId"];
         loanStatusModel.intrestStartDate = DateFormat.yMMMd().format(DateTime.parse(jsonData["intrestStartDate"]));
        loanStatusModel.mobilenumber = jsonData["mobilenumber"];
        loanStatusModel.emailId = jsonData["emailId"];
        loanStatusModel.closedLoans = jsonData["closedLoans"];
        loanStatusModel.activeLoans = jsonData["activeLoans"];
        loanStatusModel.totalLoans = jsonData["totalLoans"];
        loanStatusModel.intrestAmount = jsonData["intrestAmount"];
        loanStatusModel.paymentFrequency = jsonData["paymentFrequency"];
        loanStatusModel.disbursalDate = DateFormat.yMMMd().format(DateTime.parse(jsonData["disbursalDate"]));
        loanStatusModel.closureDate = DateFormat.yMMMd().format(DateTime.parse(jsonData["closureDate"]));
        loanStatusModel.finalDueDate = DateFormat.yMMMd().format(DateTime.parse(jsonData["finalDueDate"]));
        loanStatusModel.firstDueDate = DateFormat.yMMMd().format(DateTime.parse(jsonData["firstDueDate"]));
        loanStatusModel.installmentAmount = jsonData["installmentAmount"];
        loanStatusModel.currency = jsonData["currency"];
        loanStatusModel.intrestType = jsonData["intrestType"];
        loanStatusModel.intrestRate = jsonData["intrestRate"];
        loanStatusModel.nextTerm = jsonData["nextTerm"];
        loanStatusModel.remainingTerm = jsonData["remainingTerm"];
        loanStatusModel.status = jsonData["status"];
        loanStatusModel.term = jsonData["term"];
        loanStatusModel.loanAmount = jsonData["loanAmount"];
        loanStatusModel.loanId = jsonData["loanId"];
        loanStatusModel.loanType = jsonData["loanType"];
        loanStatusModel.overDueDays = jsonData["overDueDays"];
      loanStatusModel.overDueAmount = jsonData["overDueAmount"];
      loanStatusModel.currentDueAmount = jsonData["currentDueAmount"];
      loanStatusModel.thirtyDays = jsonData["thirtyDays"];
      loanStatusModel.sixtyDays = jsonData["sixtyDays"];
      loanStatusModel.ninetyDays = jsonData["ninetyDays"];
      loanStatusModel.oneTwentyDays = jsonData["oneTwentyDays"];
      loanStatusModel.oneFiftyDays = jsonData["oneFiftyDays"];
      loanStatusModel.oneEightyDays = jsonData["oneEightyDays"];
      loanStatusModel.oneEightyDaysPlus = jsonData["oneEightyDaysPlus"];
      loanStatusModel.balance = jsonData["balance"];


      print(loanStatusModel.intrestStartDate);
      return loanStatusModel;
    }

    Future<RemainingPaymentModel> getPaymentDetails()
    async{
      String url = "http://10.0.2.2:8091/api/getPaymentDetails/"+"${model.loanId}";
      var data = await http.get(url);
      var jsonData = json.decode(data.body);
      print(jsonData);

      RemainingPaymentModel remainingPaymentModel = new RemainingPaymentModel();
      remainingPaymentModel.intrestPaid = jsonData["intrestPaid"];
      remainingPaymentModel.remainingIntrest = jsonData["remainingIntrest"];
      remainingPaymentModel.remainingPrincipal = jsonData["remainingPrincipal"];
      remainingPaymentModel.principalPaid = jsonData["principalPaid"];
      remainingPaymentModel.installmentPaid = jsonData["installmentPaid"];
      remainingPaymentModel.remainingInstallment = jsonData["remainingInstallment"];
      print(remainingPaymentModel.remainingPrincipal);
      return remainingPaymentModel;
    }

    Future<PaymentModel> getTotalPaymentDetails()
    async{
      String url = "http://10.0.2.2:8091/api/totalAmounts/"+"${model.loanId}";
      var data = await http.post(url);
      var jsonData = json.decode(data.body);
      print(jsonData);

      PaymentModel paymentModel = new PaymentModel();
      paymentModel.totalInstallmentAmount = jsonData["totalInstallmentAmount"];
      paymentModel.totalPrincipalAmount = jsonData["totalPrincipalAmount"];
      paymentModel.totalIntrestAmount = jsonData["totalIntrestAmount"];
      return paymentModel;
    }


    Future<List<String>> getStatementDates()
    async{
      print("loan id" + "${activeLaonsModel.loanId}");
      String url = "http://10.0.2.2:8091/api/statementdates/"+"${activeLaonsModel.loanId}";
      var data = await http.get(url);
      var jsonData = json.decode(data.body);
      print(" loan id ${activeLaonsModel.loanId}");
      print(jsonData);

      List<String> model = [];
      for(var al in jsonData)
      {
        model.add(DateFormat.yMd().format(DateTime.parse(al["statementDate"])));
      }
      print(model);
      return model;
    }

    Future<List<String>> getStatementDatesInYMMMMDformat()
    async{
      print("loan id" + "${activeLaonsModel.loanId}");
      String url = "http://10.0.2.2:8091/api/statementdates/"+"${activeLaonsModel.loanId}";
      var data = await http.get(url);
      var jsonData = json.decode(data.body);
      print(" loan id ${activeLaonsModel.loanId}");
      print(jsonData);

      List<String> model = [];
      for(var al in jsonData)
      {
        model.add(DateFormat.yMMMMd().format(DateTime.parse(al["statementDate"])));
      }
      print(model);
      return model;
    }

    Future<String> getDueDates()
    async{
      LoanStatusModel loanmodel = await getActiveLoanDetailsOfCustomer();
      print("loan id" + "${activeLaonsModel.loanId}");
      String url = "http://10.0.2.2:8091/api/nextduedate/"+"${activeLaonsModel.loanId}/"+"${loanmodel.nextTerm}";
      var data = await http.post(url);
      var jsonData = json.decode(data.body);
      print(" loan id ${activeLaonsModel.loanId}");
      print(jsonData);
      String model = "";
        model = (DateFormat.yMMMMd().format(DateTime.parse(jsonData["statementDate"])));
      return model;
    }

    Future<double> getDueInstallment()
    async{
      String url = "http://10.0.2.2:8091/api/nextduedate/"+"${activeLaonsModel.loanId}";
      var data = await http.post(url);
      var jsonData = json.decode(data.body);
      print(jsonData);
      double model = 0.00;
      model = jsonData["totalDue"];
      return model;
    }

    Future<TermWiseDetails> getTermWiseDetails()
    async{
      String url = "http://10.0.2.2:8091/api/termWiseDetails/1";
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


    Future<StatementTransactions> getUnbilledCreditTransactionDetailByStatement()
    async{
      String url = "http://10.0.2.2:8091/api/UnbilledCreditTransactions/"+"${activeLaonsModel.loanId}";
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
      String url = "http://10.0.2.2:8091/api/UnbilledDebitTransactions/"+"${activeLaonsModel.loanId}";
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
        day1 = dropdownvalue.substring(2,4);
      }
      String date = dropdownvalue.substring(5,)+ "-" +month1+"-"+day1;
      String url = "http://10.0.2.2:8091/api/statementTransactions/"+"${date}/"+"${activeLaonsModel.loanId}";
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
        st.transactionDate = al["transactionDate"];
        details.add(st);
      }
      return details;
    }

    TextStyle? textstyle = Theme.of(context).textTheme.subtitle2;

    return Scaffold(
      appBar: AppBar(
        title: Text("Loan Status"),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
          child:Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                height: 100,
                padding: EdgeInsets.symmetric(
                  horizontal: 6,
                ),

                child: Row(
                  children: <Widget>[
                    Expanded(
                        child:GestureDetector(
                            onTap: (){
                              // ActiveLaonsModel model = model1[index];
                              // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoanStatus(model),),);
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(
                                      color: Colors.green,
                                      width: 2
                                  )
                              ),

                              child: Column(

                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  ListTile(
                                    title: Text("${activeLaonsModel.name}",),


                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 18,
                                      ),
                                      Text("${activeLaonsModel.loanId}"),
                                      SizedBox(
                                        width: 111,
                                      ),
                                      Text("${activeLaonsModel.loanType}",style: TextStyle(
                                        color: Colors.red,
                                      ),),
                                      SizedBox(
                                        width: 30,
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

              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 180,
                padding: EdgeInsets.symmetric(
                  horizontal: 6,
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child:GestureDetector(
                          onTap: () async {
                            LoanStatusModel statusModel = await getActiveLoanDetailsOfCustomer();
                            RemainingPaymentModel remainingStatusModel = await getPaymentDetails();
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoanDetails(statusModel,remainingStatusModel),),);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.green,
                                width: 2,
                              ),
                                borderRadius: BorderRadius.circular(10)
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
                                    child: Image.asset("assets/loan_status.jpg"),
                                  ),
                                ),
                                Text('loan status',style: TextStyle(
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
                            // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Login(),),);
                            //LoanStatusModel statusModel = await getActiveLoanDetailsOfCustomer();
                            List<String> dates = await getStatementDates();
                            List<String> formatted = await getStatementDatesInYMMMMDformat();

                            transactions = await getTransactionDetailsByStatement(dates[0]);
                            LoanStatusModel statusModel = await getActiveLoanDetailsOfCustomer();
                            setState(() {
                              details2.overDueDays = statusModel.overDueDays;
                              details2.currentDueAmount = statusModel.currentDueAmount;
                              details2.thirtyDays = statusModel.thirtyDays;
                              details2.sixtyDays = statusModel.sixtyDays;
                              details2.ninetyDays = statusModel.ninetyDays;
                              details2.oneFiftyDays = statusModel.oneFiftyDays;
                              details2.oneTwentyDays = statusModel.oneTwentyDays;
                              details2.oneEightyDaysPlus = statusModel.oneEightyDaysPlus;
                              details2.oneEightyDays = statusModel.oneEightyDays;
                              details2.overDueAmount = statusModel.overDueAmount;
                              details2.balance = statusModel.balance;
                              details2.loanId = statusModel.loanId;


                            });
                            RemainingPaymentModel remainingStatusModel = await getPaymentDetails();
                            unbilledcredit1 = await getUnbilledCreditTransactionDetailByStatement();
                            setState(() {
                              unbilledcredit =unbilledcredit1;
                              credit.id = unbilledcredit1.id;
                              credit.transactionAmount = unbilledcredit.transactionAmount;
                            });
                            unbilleddebit1 = await getUnbilledDebitTransactionDetailByStatement();
                            setState(() {
                              unbilleddebit =unbilleddebit1;
                              debit.id = unbilleddebit.id;
                              debit.transactionAmount = unbilleddebit.transactionAmount;
                            });

                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Transactions(dates,remainingStatusModel,statusModel,transactions,credit,debit,details2,formatted),),);

                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.green,
                                width: 2,
                              ),
                                borderRadius: BorderRadius.circular(10)
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
                                    child: Image.asset("assets/transactions.jpg"),
                                  ),
                                ),
                                Text('transactions',style: TextStyle(
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
                  horizontal: 6,
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child:GestureDetector(
                          onTap: () async {
                            LoanStatusModel statusModel = await getActiveLoanDetailsOfCustomer();
                            RemainingPaymentModel remainingStatusModel = await getPaymentDetails();
                            PaymentModel payemtModel = await getTotalPaymentDetails();
                            TermWiseDetails termdetails  =  await getTermWiseDetails();
                            print(payemtModel.totalInstallmentAmount);
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PaymentSchedule(remainingStatusModel,statusModel,payemtModel,termdetails),),);

                            // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Login(),),);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.green,
                                width: 2,
                              ),
                                borderRadius: BorderRadius.circular(10)
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
                                    child: Image.asset("assets/view_schedule.jpg"),
                                  ),
                                ),
                                Text('view schedule',style: TextStyle(
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
                            LoanStatusModel statusModel = await getActiveLoanDetailsOfCustomer();
                            RemainingPaymentModel remainingStatusModel = await getPaymentDetails();
                            String date=  await getDueDates();
                            double dueInstallment = await getDueInstallment();
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Payment(model,statusModel,remainingStatusModel,date,dueInstallment),),);

                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.green,
                                width: 2,
                              ),
                                borderRadius: BorderRadius.circular(10)
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
                                    child: Image.asset("assets/payment.png"),
                                  ),
                                ),
                                Text('payment',style: TextStyle(
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
                            // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Login(),),);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.green,
                                width: 2,
                              ),
                                borderRadius: BorderRadius.circular(10)
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
                                    child: Image.asset("assets/intrest_certificate.png"),
                                  ),
                                ),
                                Text('intrest certificate',style: TextStyle(
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
                            // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Login(),),);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.green,
                                width: 2,
                              ),
                                borderRadius: BorderRadius.circular(10)
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
                                    child: Image.asset("assets/forclosure.png"),
                                  ),
                                ),
                                Text('forclosure',style: TextStyle(
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
                            // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Login(),),);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.green,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(10)
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
                                    child: Image.asset("assets/setup_auto_debit.jpg"),
                                  ),
                                ),
                                Text('setup auto debit',style: TextStyle(
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
                            // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Login(),),);
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
                                    // child: Image.asset("assets/setup_auto_debit.jpg"),
                                  ),
                                ),
                                // Text('setup auto debit',style: TextStyle(
                                //     fontSize: 15
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
