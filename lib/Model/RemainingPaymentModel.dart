import 'dart:convert';


RemainingPaymentModel _RemainingPaymentModelJson(String str)=>
    RemainingPaymentModel.fromJson(json.decode(str));

String _RemainingPaymentModelToJson(RemainingPaymentModel data) => json.encode(data.toJson());



class RemainingPaymentModel
{
  double? remainingPrincipal;
  double? remainingIntrest;
  double? intrestPaid;
  double? principalPaid;
  double? remainingInstallment;
  double? installmentPaid;

  RemainingPaymentModel({this.remainingPrincipal,this.remainingIntrest,this.intrestPaid,this.installmentPaid,this.principalPaid,this.remainingInstallment});

  factory RemainingPaymentModel.fromJson(Map<String,dynamic> json) => RemainingPaymentModel(
      intrestPaid: json["intrestPaid"],
      remainingIntrest: json["remainingIntrest"],
      remainingPrincipal: json["remainingPrincipal"],
      principalPaid : json["principalPaid"],
      remainingInstallment : json["remainingInstallment"],
      installmentPaid : json["installmentPaid"]
  );

  Map<String,dynamic> toJson() =>
      {
        "intrestPaid": intrestPaid,
        "remainingIntrest" : remainingIntrest,
        "remainingPrincipal":remainingPrincipal,
        "installmentPaid" : installmentPaid,
        "remainingInstallment" : remainingInstallment,
        "principalPaid" : principalPaid

      };


  double? get RemainingPrincipal => remainingPrincipal;
  double? get RemainingIntrest => remainingIntrest;
  double? get IntrestPaid => intrestPaid;
  double? get PrincipalPaid => principalPaid;
  double? get RemainingInstallment => remainingInstallment;
  double? get InstallmentPaid => installmentPaid;

}