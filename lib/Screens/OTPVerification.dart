import 'dart:convert';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:loans/Model/MobileOtpModel.dart';
import 'package:loans/Model/OtpModel.dart';
import 'package:loans/Screens/Emailverification.dart';


class OTPVerification extends StatefulWidget {

  OTPVerification();
  @override
  OTPVerificationState createState() => OTPVerificationState();
}


class OTPVerificationState extends State<OTPVerification> {
  String code = "";
  Future<MobileOtpModel?> checkOtp(int otp)
  async{
    try{
      var url = "http://10.0.2.2:8091/verifyMobileOtp";
      var response = await http.post(url,
          headers: {"Content-Type" : "application/json"},
          body:jsonEncode({
            "otp":otp,
            "phone" : "+918978234625",
          }));

      if(response.body == "correct Otp")
      {
        debugPrint("correst");
        Navigator.of((context) as BuildContext).push(MaterialPageRoute(builder: (context)=>Emailverification(),),);

      }

    }catch(e)
    {
      debugPrint(e.toString());
    }
  }
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
      checkOtp(otp);
    }

    // if(ctr>0)
    // {
    //   debugPrint(' counter :$ctr');
    // }
  }

  OTPVerificationState();

  @override
  void dispose() {
    super.dispose();
  }

  bool isEnabled = true;

  @override
  Widget build(BuildContext context) {
    TextStyle? textstyle = Theme
        .of(context)
        .textTheme
        .subtitle2;

    return Scaffold(
      appBar: AppBar(
        title: Text("Loan Calculator"),
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
        Text("Enter the verification code sent to your mobile",style: TextStyle(
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
              onPressed:validate,
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
