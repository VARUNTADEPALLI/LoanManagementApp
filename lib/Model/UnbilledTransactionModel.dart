import 'dart:convert';
import 'dart:ffi';

import 'package:loans/Model/CustomerModel.dart';

UnbilledTransactionModel _UnbilledTransactionModelJson(String str)=>
    UnbilledTransactionModel.fromJson(json.decode(str));

String _UnbilledTransactionModelToJson(CustomerModel data) => json.encode(data.toJson());



class UnbilledTransactionModel
{

  String? transactionDate;
  double? transactionAmount;
  String? transactionType;
  String? description;

  UnbilledTransactionModel({this.description,this.transactionDate,this.transactionType,this.transactionAmount});

  factory UnbilledTransactionModel.fromJson(Map<String,dynamic> json) => UnbilledTransactionModel(
    transactionAmount: json["transactionAmount"],
    transactionType: json["transactionType"],
    transactionDate: json["transactionDate"],
    description: json["description"],


  );

  Map<String  ,dynamic> toJson() =>
      {
        //"statementDate": statementDate,

      };


  String? get TransactionDate => transactionDate;
  String? get TransactionType => transactionType;
  double? get TransactionAmount => transactionAmount;
  String? get Description => description;


}