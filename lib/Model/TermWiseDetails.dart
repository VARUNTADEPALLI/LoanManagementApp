import 'dart:convert';


TermWiseDetails _TermWiseDetailsJson(String str)=>
    TermWiseDetails.fromJson(json.decode(str));

String _TermWiseDetailsToJson(TermWiseDetails data) => json.encode(data.toJson());



class TermWiseDetails
{
  double? principalOutstanding;
  double? installment;
  double? intrestPaid;
  double? principalPaid;
  double? principal;
  double? intrest;
  String? dueDate;

  TermWiseDetails({this.principalOutstanding,this.installment,this.intrestPaid,this.principalPaid,this.principal,this.intrest,this
  .dueDate});

  factory TermWiseDetails.fromJson(Map<String,dynamic> json) => TermWiseDetails(
      intrestPaid: json["intrestPaid"],
      principalOutstanding: json["principaOutstanding"],
      installment: json["installment"],
      principalPaid : json["principalPaid"],
      principal : json["principal"],
    intrest : json["intrest"],
    dueDate : json["dueDate"],

  );

  Map<String,dynamic> toJson() =>
      {
        "intrestPaid": intrestPaid,
        // "remainingIntrest" : remainingIntrest,
        // "remainingPrincipal":remainingPrincipal,
        // "installmentPaid" : installmentPaid,
        // "remainingInstallment" : remainingInstallment,
        "principalPaid" : principalPaid

      };



}