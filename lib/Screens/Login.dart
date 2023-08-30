import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:loans/Model/CustomerModel.dart';
import 'package:loans/Screens/ForgotPassword.dart';
import 'package:loans/Screens/Home.dart';
import 'package:loans/Screens/NewUserRegistration.dart';

class Login extends StatefulWidget {
  @override
  loginState createState() => loginState();
}
DateTime dateToday =new DateTime.now();
String todayDate = dateToday.toString().substring(0,10);

Future<CustomerModel?> checkLoginValidity(
    { required String id,required String password, required BuildContext context,})
async{
  try{
    var url = "http://10.0.2.2:8091/api/login";
    var response = await http.post(url,
        headers: {"Content-Type" : "application/json"},
        body:jsonEncode({
          "id" : id,
          "password" : password,
        }));

    String responseString = response.body;

    if(response.body == "Invalid Login Credentials!!")
    {
      debugPrint("ERROR");
      showDialog(context: context, builder: (BuildContext context){
        return AlertDialog(
          title: Text("Backend respnse"),
          content: Text(response.body),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new ElevatedButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
    }
    else
      {
          debugPrint("YAY");

          Navigator.of(context).push(
              MaterialPageRoute(builder: (context)  => Home(id,todayDate)));


      }
  }catch(e)
  {
    debugPrint(e.toString());
  }

}

class loginState extends State<Login> {
  var ctr = 0;
  var ctr1 = 0;
  final minimumpadding = 5.0;

  FocusNode myFocusNode = new FocusNode();
  FocusNode myFocusNode1 = new FocusNode();
  var _password = "";
  var _phone = "";

  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    passwordController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  bool isEnabled = true;



  validate() {
    ctr = 0;
    ctr1 = 0;

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

    debugPrint('counnter: $ctr');
    if (ctr == 0 && ctr1 == 0) {
      checkLoginValidity(id: phoneNumberController.value.text, password: passwordController.value.text, context: context);
      // debugPrint("Login success");
    }

    // if(ctr>0)
    // {
    //   debugPrint(' counter :$ctr');
    // }
  }

  @override
  Widget build(BuildContext context) {
    TextStyle? textstyle = Theme
        .of(context)
        .textTheme
        .subtitle2;

    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Login"),
      //   centerTitle: true,
      // ),

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
                    'Login',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold,
                        fontSize: 34,
                        color: Colors.indigo),

                  ),

                  Padding(padding: EdgeInsets.only(
                      top: minimumpadding * 2, bottom: minimumpadding)),
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
                    child: Text("Login"),
                  ),


                  Row(
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ForgotPassword()));
                          },
                          child: Text("Forgot Password",
                            style: TextStyle(color: Colors.indigo),
                          )

                      ),
                      Padding(padding: EdgeInsets.only(
                          left: minimumpadding * 23, right: minimumpadding)),

                      TextButton(onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => NewUserRegistration()));
                      },
                          child: Text("New User?",
                            style: TextStyle(color: Colors.indigo),)),
                    ],
                  )
                ],

              ),

            ),

          )


      ),
    );
  }
}
