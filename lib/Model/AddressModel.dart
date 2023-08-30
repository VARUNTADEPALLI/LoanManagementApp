import 'dart:convert';

import 'package:loans/Model/CustomerModel.dart';

AddressModel _addressModelJson(String str)=>
    AddressModel.fromJson(json.decode(str));

String _addressModelToJson(AddressModel data) => json.encode(data.toJson());



class AddressModel
{
  String? customerId;
  String? addressType;
  String? description;
  String? houseNumber;
  String? streetName;
  String? city;
  String? state;
  String? pincode;
  String? country;

  AddressModel({this.customerId,this.addressType,this.city,this.country,this.description,this.houseNumber,this.pincode,this.state,this.streetName});

  factory AddressModel.fromJson(Map<String,dynamic> json) => AddressModel(
      customerId: json["customerId"],
    addressType: json["addressType"],
    description: json["description"],
    houseNumber : json["houseNumber"],
    streetName: json["streetName"],
    city: json["city"],
    state: json["state"],
    pincode: json["pincode"],
    country: json["country"],
  );

  Map<String,dynamic> toJson() =>
      {
        "customerId": customerId,
        "addressType" : addressType,
        "description":description,
        "houseNumber":houseNumber,
        "streetName":streetName,
        "city":city,
        "state":state,
        "pincode":pincode,
        "country":country



      };


  String? get CustomerId => customerId;
  String? get AddressType => addressType;
  String? get Description => description;
  String? get HouseNumber => houseNumber;
  String? get StreetName => streetName;
  String? get City => city;
  String? get State => state;
  String? get Pincode => pincode;
  String? get Country => country;

}