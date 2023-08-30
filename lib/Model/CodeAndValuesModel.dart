import 'dart:convert';

import 'package:loans/Model/CustomerModel.dart';

CodeAndValuesModel _CodeAndValuesModelJson(String str)=>
    CodeAndValuesModel.fromJson(json.decode(str));

String _CodeAndValuesModelToJson(CustomerModel data) => json.encode(data.toJson());



class CodeAndValuesModel
{
  String? code;
  String? description;
  String? value;
  CodeAndValuesModel({this.code ,this.description,this.value});

  factory CodeAndValuesModel.fromJson(Map<String,dynamic> json) => CodeAndValuesModel(
      code: json["code"],
      description: json["description"],
       value: json["value"]);




  String? get Code => code;
  String? get Description => description;
  String? get Value => value;
}