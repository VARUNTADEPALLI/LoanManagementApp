import 'dart:convert';

import 'package:loans/Model/OtpModel.dart';

EmailOtpVerificationModel _EmailOtpVerificationModellJson(String str)=>
    EmailOtpVerificationModel.fromJson(json.decode(str));

String _EmailOtpVerificationModelToJson(EmailOtpVerificationModel data) => json.encode(data.toJson());



class EmailOtpVerificationModel
{

  String? email;
  int? otp;
  EmailOtpVerificationModel({this.email,this.otp});

  factory EmailOtpVerificationModel.fromJson(Map<String,dynamic> json) => EmailOtpVerificationModel(
    email:json["email"],
    otp:json["otp"],);


  Map<String,dynamic> toJson() =>
      {
        "email": email,
        "otp":otp
      };


  String? get Email => email;
  int? get Otp => otp;
}