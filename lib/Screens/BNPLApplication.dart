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
import 'package:loans/Model/EmailOtpModel.dart';
import 'package:loans/Model/LoanScheduleModel.dart';
import 'package:loans/Model/OtpModel.dart';
import 'package:loans/Screens/ForgotPassword.dart';
import 'package:loans/Screens/Home.dart';
import 'package:loans/Screens/LoanSchedule.dart';
import 'package:loans/Screens/NewUserRegistration.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:loans/Screens/OTPVerification.dart';

class BNPLApplication extends StatefulWidget {

  BNPLApplication();
  @override
  BNPLApplicationState createState() => BNPLApplicationState();
}

Future<OtpModel?> getOtp()
async{
  try{
    var url = "http://10.0.2.2:8091/api/getOtp";
    var response = await http.post(url,
        headers: {"Content-Type" : "application/json"},
        body:jsonEncode({

          "phoneNumber" : "+918978234625",
        }));

  }catch(e)
  {
    debugPrint(e.toString());
  }
}

Future<EmailOtpModel?> getEmailOtp()
async{
  try{
    var url = "http://10.0.2.2:8091/send-email";
    var response = await http.post(url,
        headers: {"Content-Type" : "application/json"},
        body:jsonEncode({
          "to": "varuninmail@gmail.com",
          "subject": "Email verification",
        }));

  }catch(e)
  {
    debugPrint(e.toString());
  }
}

class BNPLApplicationState extends State<BNPLApplication> {

  BNPLApplicationState();
  var firstNameflag = 0;
  var lastNameflag = 0;
  var mobileflag = 0;
  var emailflag = 0;
  final minimumpadding = 5.0;
  var firstName = "";
  var lastName = "";
  var mobile = "";
  var email = "";
  var middleName = "";

  FocusNode firstNameFocusNode = new FocusNode();
  FocusNode middleNameFocusNode = new FocusNode();
  FocusNode lastNameFocusNode = new FocusNode();
  FocusNode mobileFocus = new FocusNode();
  FocusNode emailFocus = new FocusNode();
  var _password = "";
  var _amount = "";
  var dropdownvalue = "";
  var dropdownvalue1 = "";
  var interstType = "";
  var paymentFreq = "";
  final lastNameController = TextEditingController();
  final middleNameController = TextEditingController();
  final firstNameController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();

  @override
  void dispose() {
    lastNameController.dispose();
    firstNameController.dispose();
    mobileController.dispose();
    emailController.dispose();
    middleNameController.dispose();
    super.dispose();
  }

  bool isEnabled = true;



  validate(String interestTypes, String paymentFrequency) async {

    debugPrint(paymentFrequency);
    firstNameflag = 0;
    lastNameflag = 0;
    mobileflag = 0;
    emailflag = 0;

    if (firstNameController.value.text.isEmpty) {
      setState(() {
        isEnabled = false;
      });
      firstNameflag=1;
    }
    else if(firstNameflag==1 && firstNameController.value.text.isNotEmpty)
    {
      firstNameflag=0;
    }
    if (lastNameController.value.text.isEmpty) {
      setState(() {
        isEnabled = false;
      });
      lastNameflag=1;
    }
    else if(lastNameflag==1 && lastNameController.value.text.isNotEmpty)
    {
      lastNameflag=0;
    }
    if (mobileController.value.text.isEmpty) {
      setState(() {
        isEnabled = false;
      });
      mobileflag=1;
    }
    else if(mobileflag==1 && mobileController.value.text.isNotEmpty)
    {
      mobileflag=0;
    }

    if (emailController.value.text.isEmpty) {
      setState(() {
        isEnabled = false;
      });
      emailflag=1;
    }
    else if(emailflag==1 && emailController.value.text.isNotEmpty)
    {
      emailflag=0;
    }


    if (emailflag == 0 && mobileflag == 0 && lastNameflag==0 &&  firstNameflag==0) {
      // checkLoginValidity(id: phoneNumberController.value.text, password: passwordController.value.text, context: context);
      getOtp();
      getEmailOtp();
       Navigator.of(context).push(MaterialPageRoute(builder: (context)=>OTPVerification(),),);
      debugPrint("hey hey hey ehye hye");

    }

  }

  @override
  Widget build(BuildContext context) {
    TextStyle? textstyle = Theme
        .of(context)
        .textTheme
        .subtitle2;

    return Scaffold(
      appBar: AppBar(
        title: Text("BNPL"),
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
                    height: 10,
                  ),
                  
                  Text("Customer Verification",style: TextStyle(
                    fontSize: 34,
                    color: Colors.indigo
                  ),textAlign: TextAlign.center,),
                  SizedBox(
                    height: 60,
                  ),
                  TextFormField(
                      focusNode: firstNameFocusNode,

                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        labelText: "First Name",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 10),
                          borderRadius: BorderRadius.circular(13),

                        ),
                      //  hintText: "Enter first name",
                      ),
                      controller: firstNameController,
                      keyboardType: TextInputType.text,
                      validator: (text) {
                        if (text!.isEmpty) {
                          return "first name can\'t be empty";
                        }
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onChanged: (number) {
                        if (number.isNotEmpty) {
                          setState(() {
                            isEnabled = true;
                          });
                        }
                        firstName;
                      }


                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                      focusNode: middleNameFocusNode,

                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        labelText: "Middle Name",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 10),
                          borderRadius: BorderRadius.circular(13),

                        ),
                        //  hintText: "Enter first name",
                      ),
                      controller: middleNameController,
                      keyboardType: TextInputType.text,
                      validator: (text) {
                        if (text!.isEmpty) {
                          return "middle name can\'t be empty";
                        }
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onChanged: (name) {
                        if (name.isNotEmpty) {
                          setState(() {
                            isEnabled = true;
                          });
                        }
                        middleName;
                      }


                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                      focusNode: lastNameFocusNode,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        labelText: "Last Name",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 1),
                          borderRadius: BorderRadius.circular(13),
                        ),

                     //   hintText: "Last Name",
                        // errorText: _passwordError,
                      ),
                      validator: (text) {
                        if (text!.isEmpty) {
                          return "last name can\'t be empty";
                        }
                      },
                      keyboardType: TextInputType.text,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: lastNameController,
                      enableSuggestions: false,
                      autocorrect: false,
                      onChanged: (pass) {
                        if (pass.isNotEmpty) {
                          setState(() {
                            isEnabled = true;
                          });
                        }
                        lastName;
                      }


                  ),
                  SizedBox(
                    height: 20,
                  ),

                  TextFormField(
                      focusNode: mobileFocus,

                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.call),
                        labelText: "Mobile Number",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 1),
                          borderRadius: BorderRadius.circular(13),
                        ),
                       // hintText: "Mobile Number",
                        // errorText: _passwordError,
                      ),


                      validator: (text) {
                        if (text!.isEmpty) {
                          return "mobile number  can\'t be empty";
                        }
                      },

                      keyboardType: TextInputType.number,
                      maxLength: 10,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: mobileController,
                      enableSuggestions: false,
                      autocorrect: false,
                      onChanged: (mobile) {
                        if (mobile.isNotEmpty) {
                          setState(() {
                            isEnabled = true;
                          });
                        }
                        mobile;
                      }
                  ),


                  TextFormField(
                      focusNode: emailFocus,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        labelText: "Email Address",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 1),
                          borderRadius: BorderRadius.circular(13),
                        ),

                       // hintText: "Email Address",
                        // errorText: _passwordError,
                      ),
                      validator: (email) {
                        if (email!.isEmpty) {
                          return "email can\'t be empty";
                        }
                        if(!RegExp(r'\S+@\S+\.\S+').hasMatch(email))
                          {
                            return "Please enter a valid email address";
                          }
                      },
                      keyboardType: TextInputType.emailAddress,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: emailController,
                      enableSuggestions: false,
                      autocorrect: false,
                      onChanged: (email) {
                        if (email.isNotEmpty) {
                          setState(() {
                            isEnabled = true;
                          });
                        }
                        email;
                      }


                  ),
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
                      top: minimumpadding , bottom: minimumpadding)),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100)),
                      backgroundColor: Colors.indigo,
                    ),
                    onPressed: () => validate(interstType,paymentFreq),
                    child: Text("Register"),
                  ),



                ],

              ),

            ),

          )


      ),
    );
  }
}
