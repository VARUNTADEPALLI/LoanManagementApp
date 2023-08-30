import 'dart:convert';

import 'package:loans/Model/CustomerModel.dart';

CustomerModel _customerModelJson(String str)=>
    CustomerModel.fromJson(json.decode(str));

String _customerModelToJson(CustomerModel data) => json.encode(data.toJson());



class CustomerModel
{
  String id;
  String password;
  CustomerModel({required this.id,required this.password});

  factory CustomerModel.fromJson(Map<String,dynamic> json) => CustomerModel(
      id: json["id"],
      password: json["password"]);

  Map<String,dynamic> toJson() =>
      {
        "id": id,
        "password" : password,
      };


  String get Id => id;
  String get Password => password;
}