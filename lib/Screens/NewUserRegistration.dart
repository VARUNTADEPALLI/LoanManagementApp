
import 'dart:async';
import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;

import 'package:flutter/foundation.dart';
import 'package:loans/Model/CustomerModel.dart';

class NewUserRegistration extends StatefulWidget {
  @override
  newUserRegistrationState createState() => newUserRegistrationState();
}


Future<CustomerModel?> registerCustomer(
    { required String id,required String password,required BuildContext context,})
async{
  try{
    var url = "http://10.0.2.2:8091/api/saveCustomerDetails";
    var response = await http.post(url,
        headers: {"Content-Type" : "application/json"},
        body:jsonEncode({
          "id":id,
          "password":password,
        }));

    String responseString = response.body;
    if(response.statusCode == 200)
    {
      showDialog(context: context,barrierDismissible: true, builder: (BuildContext dialogContext){
        return AlertDialog(
          title: Text("Backend respnse"),
          content: Text(response.body),
        );
      });
    }
  }catch(e)
  {
    debugPrint(e.toString());
  }
}

class newUserRegistrationState extends State<NewUserRegistration> {



  var ctr = 0;
  var ctr1 = 0;
  var confirmpassflag = 0;

  // void _incrementCounter() {
  //     ctr++;
  // }
  //
  // void _decrementCounter() {
  //     ctr--;
  // }
  // void _sameCounter() {
  //     ctr = ctr;
  // }


  final minimumpadding = 5.0;

  FocusNode myFocusNode = new FocusNode();
  FocusNode myFocusNode1 = new FocusNode();
  FocusNode confirmFocusNode = new FocusNode();
  var _password = "";
  var _phone = "";

  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();

  @override
  void dispose() {
    passwordController.dispose();
    phoneNumberController.dispose();
    confirmpasswordController.dispose();
    super.dispose();
  }

  bool isEnabled = true;

  validate() {
    ctr = 0;
    ctr1 = 0;
    confirmpassflag = 0;

    if(confirmpasswordController.value.text.isEmpty){
      setState(() {
        isEnabled = false;
      });
      confirmpassflag++;
    }
    if (confirmpasswordController.value.text.isNotEmpty && confirmpasswordController.value.text.length < 6) {
      debugPrint('less than 6');
      if (confirmpassflag > 0) {
        confirmpassflag = confirmpassflag;
      }
      else {
        ++confirmpassflag;
      }
    }
    if (confirmpasswordController.value.text.isNotEmpty && confirmpasswordController.value.text.length >= 6) {
      if (confirmpassflag > 0) {
        confirmpassflag--;
      }
    }

    if (phoneNumberController.value.text.isEmpty) {
      setState(() {
        isEnabled = false;
      });
      ctr++;
    }
    if (passwordController.value.text.isEmpty) {
      setState(() {
        isEnabled = false;
      });
      ctr1++;
    }
    if (phoneNumberController.value.text.isNotEmpty &&
        phoneNumberController.value.text.length < 10) {
      if (ctr > 0) {
        ctr = ctr;
      }
      else {
        ctr++;
      }
    }
    if (phoneNumberController.value.text.isNotEmpty &&
        phoneNumberController.value.text.length == 10) {
      if (ctr > 0) {
        ctr--;
      }
    }
    if (passwordController.value.text.isNotEmpty &&
        passwordController.value.text.length < 6) {
      debugPrint('less than 6');
      if (ctr1 > 0) {
        ctr1 = ctr1;
      }
      else {
        ++ctr1;
      }
    }
    if (passwordController.value.text.isNotEmpty &&
        passwordController.value.text.length >= 6) {
      if (ctr1 > 0) {
        ctr1--;
      }
    }

    debugPrint('ctr: $ctr');
    debugPrint('ctr1: $ctr1');
    debugPrint('confirmpassflag: $confirmpassflag');
    if (ctr == 0 && ctr1 == 0 && confirmpassflag==0) {
      if(passwordController.value.text == confirmpasswordController.value.text)
        {
          registerCustomer(id: phoneNumberController.value.text, password: passwordController.value.text, context: context);
          // Navigator.pop(context);
          debugPrint('Password Match');
        }
      else
        {
          debugPrint('Password Mismatch');
        }
    }

     void postData()
    {

    }
  }



  @override
  Widget build(BuildContext context) {
    TextStyle? textstyle = Theme
        .of(context)
        .textTheme
        .subtitle2;

    return Scaffold(
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
                      top: minimumpadding * 2, bottom: minimumpadding)),
                  Text(
                    'Regsister',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold,
                        fontSize: 34,
                        color: Colors.indigo),

                  ),

                  Padding(padding: EdgeInsets.only(
                      top: 40)),
                  TextFormField(
                      focusNode: myFocusNode1,
                      decoration: InputDecoration(
                        labelText: "Mobile Number",
                        labelStyle: TextStyle(
                            color: myFocusNode1.hasFocus ? Colors.blue : Colors
                                .indigo
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.indigo, width: 3.0
                            )
                        ),
                        hintText: "Enter your  mobile number",
                        // errorText: _phoneNumberError,

                      ),
                      controller: phoneNumberController,
                      keyboardType: TextInputType.phone,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      maxLength: 10,
                      validator: (text) {
                        if (text!.isEmpty) {
                          return "Phone number can\'t be empty";
                        }
                        if (text.isNotEmpty && text.length < 10) {
                          return "Invalid phone number";
                        }
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onChanged: (number) {
                        if (number.isNotEmpty) {
                          setState(() {
                            isEnabled = true;
                          });
                        }
                        _phone;
                      }


                  ),
                  Padding(padding: EdgeInsets.only(
                      top: minimumpadding * 2, bottom: minimumpadding)),
                  TextFormField(
                      focusNode: myFocusNode,
                      decoration: InputDecoration(
                        labelText: "Password",

                        labelStyle: TextStyle(
                            color: myFocusNode.hasFocus ? Colors.blue : Colors
                                .indigo
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.indigo, width: 3.0)
                        ),

                        hintText: "Enter your password",
                        // errorText: _passwordError,
                      ),
                      validator: (text) {
                        if (text!.isEmpty) {
                          return "Password can\'t be empty";
                        }
                        if (text.isNotEmpty && text.length < 6) {
                          return "Password less than 6 characters";
                        }
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: passwordController,
                      enableSuggestions: false,
                      autocorrect: false,
                      obscureText: true,
                      onChanged: (pass) {
                        if (pass.isNotEmpty) {
                          setState(() {
                            isEnabled = true;
                          });
                        }
                        pass;
                      }


                  ),
                  Padding(padding: EdgeInsets.only(
                      top: minimumpadding * 5, bottom: minimumpadding)),
                  TextFormField(
                      focusNode: confirmFocusNode,
                      decoration: InputDecoration(
                        labelText: "Confirm Password",

                        labelStyle: TextStyle(
                            color: confirmFocusNode.hasFocus ? Colors.blue : Colors
                                .indigo
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.indigo, width: 3.0)
                        ),

                        hintText: "Confirm password",
                        // errorText: _passwordError,
                      ),
                      validator: (password) {
                        if (password!.isEmpty) {
                          return "Password can\'t be empty";
                        }
                        if (password.isNotEmpty && password.length < 6) {
                          return "Password less than 6 characters";
                        }
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: confirmpasswordController,
                      enableSuggestions: false,
                      autocorrect: false,
                      obscureText: true,
                      onChanged: (password) {
                        if (password.isNotEmpty) {
                          setState(() {
                            isEnabled = true;
                          });
                        }
                        password;
                      }

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
                    onPressed: validate,
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