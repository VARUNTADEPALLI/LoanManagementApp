import 'dart:convert';

import 'package:loans/Model/ActiveLoansModel.dart';
import 'package:loans/Model/CustomerModel.dart';

LoanScheduleModel _LoanScheduleModelJson(String str)=>
    LoanScheduleModel.fromJson(json.decode(str));

String _LoanScheduleModeltoJson(LoanScheduleModel data) => json.encode(data.toJson());



class LoanScheduleModel
{
  double? loanAmount;
  double? installmentAmount;
  double? totalInterestAmount;
  double? totalInstallmentAmount;
  double? totalPrincipal;
  double? principal;
  double? interestAmount;
  double? principalOutstanding;
  String? firstDueDate;
  String? period;
  String? disbursalDate;
  double? intrestRate;
  int? term;
  String? paymentFrequency;



  LoanScheduleModel({this.totalInstallmentAmount,this.totalInterestAmount,this.totalPrincipal,this.paymentFrequency,this.principalOutstanding,this.principal,this.term,this.firstDueDate,this.disbursalDate,this.installmentAmount,this.intrestRate,this.loanAmount,this.interestAmount,this.period});

  factory LoanScheduleModel.fromJson(Map<String,dynamic> json) => LoanScheduleModel(
    paymentFrequency: json["paymentFrequency"],
    totalInstallmentAmount: json["totalInstallmentAmount"],
    totalInterestAmount: json["totalInterestAmount"],
    totalPrincipal: json["totalPrincipal"],
    principalOutstanding: json["principalOutstanding"],
    principal: json["principal"],
    term: json["term"],
    firstDueDate: json["firstDueDate"],
    disbursalDate: json["disbursalDate"],
    installmentAmount: json["installmentAmount"],
    intrestRate: json["intrestRate"],
    loanAmount: json["loanAmount"],
    period: json["period"],
  );





  String? get PaymentFrequency => paymentFrequency;
  double? get PrincipalOutstanding => principalOutstanding;
  double? get TotalInstallmentAmount => totalInstallmentAmount;
  double? get TotalInterestAmount => totalInterestAmount;
  double? get TotalPrincipal => totalPrincipal;

  double? get Principal => principal;
  int? get Term => term;
  String? get FirstDueDate => firstDueDate;
  String? get DisbursalDate => disbursalDate;
  double? get InstallmentAmount => installmentAmount;
  double? get IntrestRate => intrestRate;
  double? get LoanAmount => loanAmount;
  String? get Period => period;

  Object? toJson() {}
}

