import 'dart:convert';

import 'package:loans/Model/ActiveLoansModel.dart';
import 'package:loans/Model/CustomerModel.dart';

LoanStatusModel _loanStatusModelJson(String str)=>
    LoanStatusModel.fromJson(json.decode(str));

String _loanStatusModelToJson(LoanStatusModel data) => json.encode(data.toJson());



class LoanStatusModel
{
  String? loanId;
  String? customerId;
  String? status;
  int? term;
  double? loanAmount;
  int? remainingTerm;
  int? nextTerm;
  String? loanType;
  double? intrestRate;
  String? intrestType;
  String? currency;
  double? installmentAmount;
  String? firstDueDate;
  String? finalDueDate;
  String? closureDate;
  String? disbursalDate;
  String? paymentFrequency;
  double? intrestAmount;
  int? totalLoans;
  int? activeLoans;
  int? closedLoans;
  String? intrestStartDate;
  String? mobilenumber;
  String? name;
  String? emailId;
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

  LoanStatusModel({this.loanId,
    this.customerId,
    this.status,
    this.term,
    this.loanAmount,
    this.remainingTerm,
    this.nextTerm,
    this.loanType,
    this.intrestRate,
    this.intrestType,
    this.currency,
    this.installmentAmount,
    this.firstDueDate,
    this.finalDueDate,
    this.closureDate,
    this.disbursalDate,
    this.paymentFrequency,
    this.intrestAmount,
    this.totalLoans,
    this.activeLoans,
    this.closedLoans,
    this.intrestStartDate,
    this.mobilenumber,
    this.name,
    this.emailId,this.balance,this.oneEightyDays,this.oneFiftyDays,this.oneEightyDaysPlus,this.oneTwentyDays
  ,this.ninetyDays,this.sixtyDays,this.thirtyDays,this.currentDueAmount,this.overDueAmount,this.overDueDays}
      );

  factory LoanStatusModel.fromJson(Map<String,dynamic> json) => LoanStatusModel(
      balance: json["balance"],
      oneEightyDays: json["oneEightyDays"],
      oneFiftyDays: json["oneFiftyDays"],
      oneEightyDaysPlus: json["oneEightyDaysPlus"],
      oneTwentyDays: json["oneTwentyDays"],
      ninetyDays: json["ninetyDays"],
      overDueDays: json["overDueDays"],
      sixtyDays: json["sixtyDays"],
      thirtyDays: json["thirtyDays"],
      currentDueAmount: json["currentDueAmount"],
      overDueAmount: json["overDueAmount"],
    name: json["name"],
    loanType: json["loanType"],
    loanId: json["loanId"],
    loanAmount: json["loanAmount"],
    customerId : json["customerId"],
    status : json["status"],
    term : json["term"],
    remainingTerm : json["remainingTerm"],
    nextTerm : json["nextTerm"],
    intrestRate : json["intrestRate"],
    intrestType : json["intrestType"],
    currency : json["currency"],
    installmentAmount : json["installmentAmount"],
    firstDueDate : json["firstDueDate"],
    finalDueDate : json["finalDueDate"],
    closureDate : json["closureDate"],
    disbursalDate : json["disbursalDate"],
    paymentFrequency : json["paymentFrequency"],
    intrestAmount : json["intrestAmount"],
    totalLoans : json["totalLoans"],
    activeLoans : json["activeLoans"],
    closedLoans : json["closedLoans"],
    intrestStartDate : json["intrestStartDate"],
    mobilenumber : json["mobilenumber"],
    emailId: json["emailId"]
  );

  Map<String,dynamic> toJson() =>
      {
        "name" : name,
        "loanType" : loanType,
        "loanId" : loanId,
        "loanAmount" : loanAmount,
        "mobilenumber" : mobilenumber,
        "customerId" : customerId,
        "status" : status,
        "intrestType" : intrestType,
        "activeLoans" : activeLoans,
        "totalLoans" : totalLoans,
        "term" : term,
        "nextTerm" : nextTerm,
        "disbursalDate" : disbursalDate,
        "intrestStartDate": intrestStartDate,
        "closureDate" : closureDate,
        "closedLoans" : closedLoans,
        "emailId" : emailId,
        "intrestAmount" : intrestAmount,
        "intrestRate" : intrestRate,
        "firstDueDate" : firstDueDate,
        "finalDueDate" : finalDueDate,
        "remainingTerm" : remainingTerm,
        "paymentFrequency" : paymentFrequency,
        "installmentAmount" : installmentAmount,
        "currency" : currency
      };


  String? get Name => name;
  String? get LoanType => loanType;
  String? get LaonId => loanId;
  double? get LoanAmount => loanAmount;
  String? get CustomerId => customerId;
  String? get Status => status;
  int?  get Term => term;
  int? get RemainingTerm => remainingTerm;
  int? get NextTerm => nextTerm;
  double? get IntrestRate => intrestRate;
  String? get IntrestType => intrestType;
  String? get Currency => currency;
  double? get InstallmentAmount => installmentAmount;
  String? get FirstDueDate => firstDueDate;
  String? get FinalDueDate => finalDueDate;
  String? get ClosureDate => closureDate;
  String? get DisbursalDate => disbursalDate;
  String? get PaymentFrequency => paymentFrequency;
  double? get IntrestAmount => intrestAmount;
  int? get TotalLoans => totalLoans;
  int? get ActiveLoans => activeLoans;
  int? get ClosedLoans => closedLoans;
  String? get IntrestStartDate => intrestStartDate;
  String? get Mobilenumber => mobilenumber;
  String? get EmailId => emailId;
}