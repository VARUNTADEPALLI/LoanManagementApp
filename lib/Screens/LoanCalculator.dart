import 'dart:convert';
import 'dart:ffi';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:loans/Model/CodeAndValuesModel.dart';
import 'package:loans/Model/CustomerModel.dart';
import 'package:loans/Model/LoanScheduleModel.dart';
import 'package:loans/Screens/ForgotPassword.dart';
import 'package:loans/Screens/Home.dart';
import 'package:loans/Screens/LoanSchedule.dart';
import 'package:loans/Screens/NewUserRegistration.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';

class LoanCalculator extends StatefulWidget {
  List<String> interestRateType;
  List<String> paymentFrequency;
  String todayDate;
  LoanCalculator(this.interestRateType,this.paymentFrequency,this.todayDate);
  @override
  LoanCalculatorState createState() => LoanCalculatorState(this.interestRateType,this.paymentFrequency,this.todayDate);
}



class LoanCalculatorState extends State<LoanCalculator> {
  List<String> interestRateType;
  List<String> paymentFrequency;
  String todayDate;
  LoanCalculatorState(this.interestRateType,this.paymentFrequency,this.todayDate);
  var amtflag = 0;
  var termflag = 0;
  var intrstflag = 0;
  final minimumpadding = 5.0;
  var amount =0;
  var interest = 0;
  var term =0;

  FocusNode myFocusNode = new FocusNode();
  FocusNode myFocusNode1 = new FocusNode();
  FocusNode termfocus = new FocusNode();
  var _password = "";
  var _amount = "";
var dropdownvalue = "";
  var dropdownvalue1 = "";
  var interstType = "";
  var paymentFreq = "";
  final amountController = TextEditingController();
  final interestController = TextEditingController();
  final termController = TextEditingController();

  @override
  void dispose() {
    termController.dispose();
    interestController.dispose();
    amountController.dispose();
    super.dispose();
  }

  bool isEnabled = true;



  validate(String interestTypes, String paymentFrequency) async {

    debugPrint(paymentFrequency);
    amtflag = 0;
    termflag = 0;
    intrstflag = 0;

    if (amountController.value.text.isEmpty) {
      setState(() {
        isEnabled = false;
      });
      amtflag=1;
    }
    else if(amtflag==1 && amountController.value.text.isNotEmpty)
      {
        amtflag=0;
      }
    if (interestController.value.text.isEmpty) {
      setState(() {
        isEnabled = false;
      });
      intrstflag=1;
    }
    else if(intrstflag==1 && interestController.value.text.isNotEmpty)
    {
      intrstflag=0;
    }
    if (termController.value.text.isEmpty) {
      setState(() {
        isEnabled = false;
      });
      termflag=1;
    }
    else if(termflag==1 && termController.value.text.isNotEmpty)
    {
      termflag=0;
    }


    if (amtflag == 0 && intrstflag == 0 && termflag==0 && interestTypes.isNotEmpty   && paymentFrequency.isNotEmpty) {
     // checkLoginValidity(id: phoneNumberController.value.text, password: passwordController.value.text, context: context);
     // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoanSchedule(),),);
      String currency = "${amountController.value.text.substring(1,)}";
      var  amount = NumberFormat().parse(currency);
      String term1 = termController.value.text;
      var  term = NumberFormat().parse(term1);
      String interest1 = interestController.value.text;
      var  interest = NumberFormat().parse(interest1);


      var remainingvalue = 0;
      List<LoanScheduleModel?> model = await GetLoanSchedule(amount,term,interest,paymentFrequency,interestTypes,remainingvalue);
      //debugPrint(model[0]!.period);
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context)  => LoanSchedule(model)));


    }

  }
  Future<List<LoanScheduleModel?>> GetLoanSchedule(num amount, num term, num interest, String paymentFrequency, String interestTypes, int remainingvalue)
  async{
    var url = "http://10.0.2.2:8091/api/getLoanSchedule";
    var response = await http.post(url,
        headers: {"Content-Type" : "application/json"},
        body:jsonEncode({
          "loanAmount" : amount,
          "intrestRate" : interest,
          "paymentFrequency": paymentFrequency,
          "term" : term,
          "remainingValue" : remainingvalue
        }));
    var jsonData = json.decode(response.body);
    print(jsonData);
    List<LoanScheduleModel> schedulemodel = [];
    for(var al in jsonData)
    {
      LoanScheduleModel loanScheduleModel = new LoanScheduleModel();
      loanScheduleModel.term = al["term"];
      loanScheduleModel.period = DateFormat.yMMMd().format(DateTime.parse(al["period"]));
      loanScheduleModel.interestAmount = al["interestAmount"];
      loanScheduleModel.loanAmount = al["loanAmount"];
      loanScheduleModel.intrestRate = al["intrestRate"];
      loanScheduleModel.installmentAmount = al["installmentAmount"];
      loanScheduleModel.disbursalDate =  DateFormat.yMMMd().format(DateTime.parse(al["disbursalDate"]));
      loanScheduleModel.firstDueDate = DateFormat.yMMMd().format(DateTime.parse(al["firstDueDate"]));
      loanScheduleModel.principal = al["principal"];
      loanScheduleModel.principalOutstanding = al["principalOutstanding"];
      loanScheduleModel.paymentFrequency = al["paymentFrequency"];
      loanScheduleModel.totalPrincipal = al["totalPrincipal"];
      loanScheduleModel.totalInterestAmount = al["totalInterestAmount"];
      loanScheduleModel.totalInstallmentAmount = al["totalInstallmentAmount"];


      schedulemodel.add(loanScheduleModel);
    }
    print(schedulemodel[0].firstDueDate);
    return schedulemodel;

  }
  @override
  Widget build(BuildContext context) {
    dropdownvalue = interestRateType[0] as String;
    dropdownvalue1 = paymentFrequency[0] as String;
    TextStyle? textstyle = Theme
        .of(context)
        .textTheme
        .subtitle2;

    return Scaffold(
      appBar: AppBar(
        title: Text("Loan Calculator"),
        centerTitle: false,
      ),

      body: Center(
          child: Container(
            padding: EdgeInsets.all(minimumpadding * 4),
            child: Padding(
              padding: EdgeInsets.only(top: minimumpadding * 2,
                  bottom: minimumpadding,
                  left: minimumpadding,
                  right: minimumpadding),

              child: ListView(
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(
                      top: minimumpadding *2, bottom: minimumpadding)),

                  SizedBox(
                    height: 0,
                  ),
                  Row(
                    children: [
                      RichText(
                          text: TextSpan(
                              text: 'Amount',
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
                    height: 20,
                  ),
                  TextFormField(
                      focusNode: myFocusNode1,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1),
                        borderRadius: BorderRadius.circular(5),

                        ),
                        hintText: "Enter amount",
                      ),
                      textAlign: TextAlign.end,
                      controller: amountController,
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: <TextInputFormatter>[
                        //FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                        CurrencyTextInputFormatter(
                          decimalDigits: 0,
                          symbol: '₹ ',)
                      ],
                      validator: (text) {
                        if (text!.isEmpty) {
                          return "Amount can\'t be empty";
                        }
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onChanged: (number) {
                        if (number.isNotEmpty) {
                          setState(() {
                            isEnabled = true;
                          });
                        }
                        _amount;
                      }


                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      RichText(
                          text: TextSpan(
                              text: 'Interest',
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
                    height: 20,
                  ),
                  TextFormField(
                      focusNode: myFocusNode,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 1),
                          borderRadius: BorderRadius.circular(5),
                        ),

                        hintText: "Enter interest",
                        // errorText: _passwordError,
                      ),
                      textAlign: TextAlign.end,
                      validator: (text) {
                        if (text!.isEmpty) {
                          return "Interest can\'t be empty";
                        }
                      },
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: interestController,
                      enableSuggestions: false,
                      autocorrect: false,
                      onChanged: (pass) {
                        if (pass.isNotEmpty) {
                          setState(() {
                            isEnabled = true;
                          });
                        }
                        pass;
                      }


                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      RichText(
                          text: TextSpan(
                              text: 'Interest Type',
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
                    height: 20,
                  ),
                    DropdownButtonFormField(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      filled: true,
                      fillColor: Colors.white10,
                    ),
                    dropdownColor: Colors.white,
                    value: dropdownvalue.isNotEmpty ? dropdownvalue:null,
                 //   hint: Text("Select interst type"),
                    onChanged: (String? newValue) async {
                      setState(()  {
                        dropdownvalue = newValue!;
                      });
                      setState(() {
                        interstType = dropdownvalue;
                      });

                   //   debugPrint(interstType);
                    },
                    //  validator: (value) => value!.isEmpty ? "Feild required": null,

                    items: interestRateType.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      RichText(
                          text: TextSpan(
                              text: 'Term',
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
                  TextFormField(
                      focusNode: termfocus,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 1),
                          borderRadius: BorderRadius.circular(5),
                        ),

                        hintText: "Enter term",
                        // errorText: _passwordError,
                      ),
                      textAlign: TextAlign.end,
                      validator: (text) {
                        if (text!.isEmpty) {
                          return "Term can\'t be empty";
                        }
                      },
                      keyboardType: TextInputType.number,
                      maxLength: 3,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: termController,
                      enableSuggestions: false,
                      autocorrect: false,
                      onChanged: (term) {
                        if (term.isNotEmpty) {
                          setState(() {
                            isEnabled = true;
                          });
                        }
                        term;
                      }
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      RichText(
                          text: TextSpan(
                              text: 'Interest Type',
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
                    height: 20,
                  ),
                  DropdownButtonFormField(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      filled: true,
                      fillColor: Colors.white10,
                    ),
                    dropdownColor: Colors.white,
                    value: dropdownvalue1.isNotEmpty ? dropdownvalue1:null,
                    onChanged: (String? newValue) async {
                      setState(()  {
                        dropdownvalue1 = newValue!;
                      });
                      setState(() {
                        paymentFreq = dropdownvalue1;
                      });
                    },
                    items: paymentFrequency.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),),
                  SizedBox(
                    height: 20,
                  ),

                  Padding(padding: EdgeInsets.only(
                      top: minimumpadding * 2, bottom: minimumpadding)),
                  isEnabled == false ? Text(
                    "Feilds can't be empty", style: TextStyle(
                      color: Colors.red
                  ),) : Text(""),
                  Padding(padding: EdgeInsets.only(
                      top: minimumpadding * 2, bottom: minimumpadding)),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100)),
                      backgroundColor: Colors.indigo,
                    ),
                    onPressed: () => validate(interstType,paymentFreq),
                    child: Text("Calculate"),
                  ),



                ],

              ),

            ),

          )


      ),
    );
  }
}
