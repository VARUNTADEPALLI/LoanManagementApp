import 'dart:convert';

import 'package:loans/Model/OtpModel.dart';

MobileOtpModel _MobileOtpModelJson(String str)=>
    MobileOtpModel.fromJson(json.decode(str));

String _MobileOtpModelToJson(MobileOtpModel data) => json.encode(data.toJson());



class MobileOtpModel
{

  int? otp;
  String? phone;
  MobileOtpModel({this.otp,this.phone});

  factory MobileOtpModel.fromJson(Map<String,dynamic> json) => MobileOtpModel(
      otp:json["otp"],
      phone: json["phone"]);

  Map<String,dynamic> toJson() =>
      {
        "otp": otp,
        "phone" : phone,
      };


  int? get Otp => otp;
  String? get PhoneNumber => phone;
}