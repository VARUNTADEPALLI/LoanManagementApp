import 'dart:convert';

import 'package:loans/Model/OtpModel.dart';

EmailOtpModel _EmailOtpModelJson(String str)=>
    EmailOtpModel.fromJson(json.decode(str));

String _EmailOtpModelToJson(EmailOtpModel data) => json.encode(data.toJson());



class EmailOtpModel
{

  String? to;
  String? subject;
  int? otp;
  EmailOtpModel({this.to,this.subject,this.otp});

  factory EmailOtpModel.fromJson(Map<String,dynamic> json) => EmailOtpModel(
      to:json["to"],
      subject: json["subject"],
      otp:json["otp"],);


  Map<String,dynamic> toJson() =>
      {
        "to": to,
        "subject" : subject,
        "otp":otp
      };


  String? get To => to;
  String? get Subject => subject;
  int? get Otp => otp;
}