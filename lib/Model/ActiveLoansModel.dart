import 'dart:convert';

import 'package:loans/Model/ActiveLoansModel.dart';
import 'package:loans/Model/CustomerModel.dart';

ActiveLaonsModel _activeLoansModelJson(String str)=>
    ActiveLaonsModel.fromJson(json.decode(str));

String _activeLoansModeltoJson(ActiveLaonsModel data) => json.encode(data.toJson());



class ActiveLaonsModel
{
  String? name;
  String? mobilenumber;
  String? loanType;
  String? loanId;
  String? customerId;
  double? loanAmount;

  ActiveLaonsModel({this.name,this.loanType,this.loanId,this.loanAmount,this.mobilenumber,this.customerId});

  factory ActiveLaonsModel.fromJson(Map<String,dynamic> json) => ActiveLaonsModel(
      name: json["name"],
      customerId: json["customerId"],
      mobilenumber: json["mobilenumber"],
      loanType: json["loanType"],
      loanId: json["loanId"],
    loanAmount: json["loanAmount"],
  );

  Map<String,dynamic> toJson() =>
      {
        "name" : name,
        "customerId" : customerId,
        "loanType" : loanType,
        "mobilenumber": mobilenumber,
         "loanId" : loanId,
         "loanAmount" : loanAmount,
      };


  String? get Name => name;
  String? get LoanType => loanType;
  String? get LaonId => loanId;
  String? get CustomerId => customerId;
  String? get Mobilenumber => mobilenumber;
  double? get LoanAmount => loanAmount;
}