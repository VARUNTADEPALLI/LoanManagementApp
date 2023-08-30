import 'dart:convert';

import 'package:loans/Model/CustomerModel.dart';

StatementDetails _statementDateModelJson(String str)=>
    StatementDetails.fromJson(json.decode(str));

String _statementDateModelToJson(CustomerModel data) => json.encode(data.toJson());



class StatementDetails
{
  String? statementDate;
  String? loanId;
  double? balance;
  int? overDueDays;
  double? currentDueAmount;
  double? overDueAmount;
  double? thirtyDays;
  double? sixtyDays;
  double? ninetyDays;
  double? oneTwentyDays;
  double? oneFiftyDays;
  double? oneEightyDays;
  double? oneEightyDaysPlus;


  StatementDetails({this.statementDate,this.loanId,this.balance,this.currentDueAmount,this.ninetyDays,this.oneEightyDays,this.oneEightyDaysPlus,
  this.oneFiftyDays,this.oneTwentyDays,this.overDueAmount,this.overDueDays,this.sixtyDays,this.thirtyDays});

  factory StatementDetails.fromJson(Map<String,dynamic> json) => StatementDetails(
    statementDate: json["statementDate"],
    loanId: json["loanId"],
    balance: json["balance"],
    overDueDays: json["overDueDays"],
    currentDueAmount: json["currentDueAmount"],
    overDueAmount: json["overDueAmount"],
    thirtyDays: json["thirtyDays"],
    sixtyDays: json["sixtyDays"],
    ninetyDays: json["ninetyDays"],
    oneTwentyDays: json["oneTwentyDays"],
    oneFiftyDays: json["oneFiftyDays"],
    oneEightyDays: json["oneEightyDays"],
    oneEightyDaysPlus: json["oneEightyDaysPlus"],
  );

  Map<String  ,dynamic> toJson() =>
      {
        "statementDate": statementDate,
        "loanId" :loanId,
        "balance" : balance,
        "overDueDays" : overDueDays,

      };


  String? get StatementDate => statementDate;

}