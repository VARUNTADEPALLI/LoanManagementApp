import 'dart:convert';

import 'package:loans/Model/CustomerModel.dart';

StatementDateModel _statementDateModelJson(String str)=>
    StatementDateModel.fromJson(json.decode(str));

String _statementDateModelToJson(CustomerModel data) => json.encode(data.toJson());



class StatementDateModel
{
  String? statementDate;
  StatementDateModel({this.statementDate});

  factory StatementDateModel.fromJson(Map<String,dynamic> json) => StatementDateModel(
    statementDate: json["statementDate"],
    );

  Map<String  ,dynamic> toJson() =>
      {
        "statementDate": statementDate,

      };


  String? get StatementDate => statementDate;

}