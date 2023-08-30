import 'dart:convert';
import 'dart:ffi';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;
import 'package:loans/Model/EmailOtpVerificationModel.dart';
import 'package:loans/Screens/BNPLApplication.dart';
import 'package:loans/Screens/Login.dart';


class Emailverification extends StatefulWidget {

  Emailverification();
  @override
  EmailverificationState createState() => EmailverificationState();
}



class EmailverificationState extends State<Emailverification> {

  EmailverificationState();

  String code = "";
  Future<EmailOtpVerificationModel?> checkEmailOtp(int otp)
  async{
    try{
      var url = "http://10.0.2.2:8091/verifyEmailOtp";
      var response = await http.post(url,
          headers: {"Content-Type" : "application/json"},
          body:jsonEncode({
            "otp":otp,
            "email": "varuninmail@gmail.com",
          }));

      debugPrint(response.body);
      if(response.body == "correct Otp")
      {
        debugPrint("correst11111");
        Navigator.of((context) as BuildContext).push(MaterialPageRoute(builder: (context)=>BNPLApplication(),),);
      }

    }catch(e)
    {
      debugPrint(e.toString());
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool isEnabled = true;


  validate() {
    var ctr = 0;

    if (code.isEmpty) {
      setState(() {
        isEnabled = false;
      });
      ctr = 1;
    }
    else if(!code.isEmpty)
    {
      setState(() {
        isEnabled = true;
      });
      ctr = 0;
    }

    debugPrint('counnter: $ctr');
    if (ctr == 0) {
      int otp  = 0;
      otp = int.parse(code);
      checkEmailOtp(otp);
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
      appBar: AppBar(
        title: Text("Email verification"),
        centerTitle: false,
      ),

      body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child:Column(
              children: [
                Text("CO\nDE",style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 80.0
                ),),
                SizedBox(
                  height: 30,
                ),
                Text("Verification".toUpperCase(),style: Theme.of(context).textTheme.titleLarge,),
                SizedBox(
                  height: 40,
                ),
                Text("Enter the verification code sent to your email",style: TextStyle(
                    fontSize: 18
                ),),
                SizedBox(
                  height: 66,
                ),
                OtpTextField(
                  numberOfFields: 6,
                  fillColor: Colors.black.withOpacity(0.1),
                  filled: true,
                  onSubmit: (value){
                    setState(() {
                      code = value;
                    });
                    print(value);
                  },
                ),
                SizedBox(
                  height: 66,
                ),
                SizedBox(
                  width: 250,
                  child:   ElevatedButton(
                    style: ElevatedButton.styleFrom(

                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100)),
                        backgroundColor: Colors.black
                    ),
                    onPressed: validate,
                    child: Text("Next"),
                  ),
                ),
              ],
            ),
          )

      ),
    );
  }
}
