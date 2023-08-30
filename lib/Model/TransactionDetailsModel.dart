import 'dart:convert';
import 'dart:ffi';

import 'package:loans/Model/CustomerModel.dart';

TransactionDetailsModel _TransactionDetailsModelJson(String str)=>
    TransactionDetailsModel.fromJson(json.decode(str));

String _TransactionDetailsModelToJson(CustomerModel data) => json.encode(data.toJson());



class TransactionDetailsModel
{

  String? transactionDate;
  double? creditAmount;
  double? debitAmount;
  String? description;

  TransactionDetailsModel({this.description,this.transactionDate,this.creditAmount,this.debitAmount});

  factory TransactionDetailsModel.fromJson(Map<String,dynamic> json) => TransactionDetailsModel(
    debitAmount: json["debitAmount"],
    creditAmount: json["loanId"],
    transactionDate: json["transactionDate"],
    description: json["description"],


  );

  Map<String  ,dynamic> toJson() =>
      {
        //"statementDate": statementDate,

      };


String? get TransactionDate => transactionDate;
double? get CreditAmount => creditAmount;
  double? get DebitAmount => debitAmount;
  String? get Description => description;


}