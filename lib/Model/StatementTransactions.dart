import 'dart:convert';
import 'dart:ffi';

import 'package:loans/Model/CustomerModel.dart';

StatementTransactions _StatementTransactionsModelJson(String str)=>
    StatementTransactions.fromJson(json.decode(str));

String _StatementTransactionsModelToJson(CustomerModel data) => json.encode(data.toJson());



class StatementTransactions
{

  int? id;
  String? statementDate;
  String? loanId;
  String? transactionDate;
  double? transactionAmount;
  String? transactionType;
  String? description;

  StatementTransactions({this.statementDate,this.loanId,this.description,this.id,this.transactionAmount,this.transactionDate,this.transactionType});

  factory StatementTransactions.fromJson(Map<String,dynamic> json) => StatementTransactions(
    id: json["id"],
    statementDate: json["statementDate"],
    loanId: json["loanId"],
    transactionDate: json["transactionDate"],
    transactionAmount: json["transactionAmount"],
    transactionType: json["transactionType"],
    description: json["description"],


  );

  Map<String  ,dynamic> toJson() =>
      {
        "statementDate": statementDate,

      };


  String? get StatementDate => statementDate;

}