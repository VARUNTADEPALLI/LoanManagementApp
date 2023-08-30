import 'package:flutter/material.dart';
import 'package:loans/Screens/BNPLApplication.dart';
import 'package:loans/Screens/Home.dart';
import 'package:loans/Screens/LoanCalculator.dart';
import 'package:loans/Screens/Login.dart';
import 'package:loans/Screens/PersonalInformationScreen.dart';
import 'package:loans/Screens/SalaryInfo.dart';
import 'package:loans/Screens/TestElements.dart';

import 'Screens/Loans.dart';
import 'Screens/Login.dart';
import 'Screens/NewUserRegistration.dart';
import 'Screens/ForgotPassword.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Loans",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SalaryInfo(),
    );
  }
}
