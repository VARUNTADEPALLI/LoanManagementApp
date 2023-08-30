import 'dart:convert';


PaymentModel _PaymentModelJson(String str)=>
    PaymentModel.fromJson(json.decode(str));

String _PaymentModelToJson(PaymentModel data) => json.encode(data.toJson());



class PaymentModel
{
  double? totalInstallmentAmount;
  double? totalPrincipalAmount;
  double? totalIntrestAmount;


  PaymentModel({this.totalInstallmentAmount,this.totalPrincipalAmount,this.totalIntrestAmount});

  factory PaymentModel.fromJson(Map<String,dynamic> json) => PaymentModel(
    totalInstallmentAmount: json["totalInstallmentAmount"],
    totalPrincipalAmount: json["totalPrincipalAmount"],
    totalIntrestAmount: json["totalIntrestAmount"],
  );

  Map<String,dynamic> toJson() =>
      {
        // "intrestPaid": intrestPaid,
        // "remainingIntrest" : remainingIntrest,
        // "remainingPrincipal":remainingPrincipal,
        // "installmentPaid" : installmentPaid,
        // "remainingInstallment" : remainingInstallment,
        // "principalPaid" : principalPaid

      };
double? get TotalIntrestAmount => totalIntrestAmount;
  double? get TotalPrincipalAmount => totalPrincipalAmount;
  double? get TotalInstallmentAmount => totalInstallmentAmount;




}