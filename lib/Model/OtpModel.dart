import 'dart:convert';

import 'package:loans/Model/OtpModel.dart';

OtpModel _OtpModelJson(String str)=>
    OtpModel.fromJson(json.decode(str));

String _OtpModelToJson(OtpModel data) => json.encode(data.toJson());



class OtpModel
{

  int? otp;
  String? phoneNumber;
  OtpModel({this.otp,this.phoneNumber});

  factory OtpModel.fromJson(Map<String,dynamic> json) => OtpModel(
    otp:json["otp"],
      phoneNumber: json["phoneNumber"]);

  Map<String,dynamic> toJson() =>
      {
        "otp": otp,
        "phoneNumber" : phoneNumber,
      };


  int? get Otp => otp;
  String? get PhoneNumber => phoneNumber;
}