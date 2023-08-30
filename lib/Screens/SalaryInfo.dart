import 'dart:convert';
import 'dart:ffi';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;
import 'package:loans/Screens/Login.dart';


class SalaryInfo extends StatefulWidget {

  SalaryInfo();
  @override
  SalaryInfoState createState() => SalaryInfoState();
}



class SalaryInfoState extends State<SalaryInfo> {

  SalaryInfoState();


  String? jobType = "";
  var numberOfDigits = 0;
  bool isSelected = false;

  final companyController = TextEditingController();
  final lastSalaryPaymentDateController = TextEditingController();
  final last4TinController = TextEditingController();
  final baseSalaryRateController = TextEditingController();
  final baseSalaryRateUnitController = TextEditingController();
  final grossSalaryLastPaidController = TextEditingController();
  final netSalaryLastPaidController = TextEditingController();
  final maxSalaryEarnedInPeriodController = TextEditingController();
  final minSalaryEarnedInPeriodController = TextEditingController();
  final averageSalaryEarnedInPeriodController = TextEditingController();
  final paymentFrequencyController = TextEditingController();
  final salaryAccountNumberController = TextEditingController();
  final abaNumberController = TextEditingController();

  var companyName = "";
  var grossSalary = "";
  var netSalary = "";
  var currentCompanyExperience = "";
  var experience = "";
  var designation = "";

  bool isEnabled = true;

  @override
  void dispose() {
    super.dispose();
    companyController.dispose();
    abaNumberController.dispose();
    averageSalaryEarnedInPeriodController.dispose();
    baseSalaryRateController.dispose();
    baseSalaryRateUnitController.dispose();
    grossSalaryLastPaidController.dispose();
    last4TinController.dispose();
    lastSalaryPaymentDateController.dispose();
    maxSalaryEarnedInPeriodController.dispose();
    minSalaryEarnedInPeriodController.dispose();
    grossSalaryLastPaidController.dispose();
    netSalaryLastPaidController.dispose();
    paymentFrequencyController.dispose();
    abaNumberController.dispose();
    salaryAccountNumberController.dispose();

  }

  List<String> jobTypes = ["Private","Public"];
  validate() async {

    var companyFlag = 0;
    var experienceFlag = 0;
    var  currentCompanyExperienceFlag = 0;
    var grossSalaryFlag = 0;
    var netSalaryFlag = 0;
    var designationFlag = 0;
    var hireDateFlag = 0;

    if (companyController.value.text.isEmpty) {
      setState(() {
        isEnabled = false;
      });
      companyFlag=1;
    }
    else if(companyFlag==1 && companyController.value.text.isNotEmpty)
    {
      companyFlag=0;
    }

    if (salaryAccountNumberController.value.text.isEmpty) {
      setState(() {
        isEnabled = false;
      });
      hireDateFlag=1;
    }
    else if(hireDateFlag==1 && salaryAccountNumberController.value.text.isNotEmpty)
    {
      hireDateFlag=0;
    }

    if (paymentFrequencyController.value.text.isEmpty) {
      setState(() {
        isEnabled = false;
      });
      designationFlag=1;
    }
    else if(designationFlag==1 && paymentFrequencyController.value.text.isNotEmpty)
    {
      designationFlag=0;
    }

    if (abaNumberController.value.text.isEmpty) {
      setState(() {
        isEnabled = false;
      });
      experienceFlag=1;
    }
    else if(experienceFlag==1 && abaNumberController.value.text.isNotEmpty)
    {
      experienceFlag=0;
    }
    if (averageSalaryEarnedInPeriodController.value.text.isEmpty) {
      setState(() {
        isEnabled = false;
      });
      currentCompanyExperienceFlag=1;
    }
    else if(currentCompanyExperienceFlag==1 && averageSalaryEarnedInPeriodController.value.text.isNotEmpty)
    {
      currentCompanyExperienceFlag=0;
    }
    if (grossSalaryLastPaidController.value.text.isEmpty) {
      setState(() {
        isEnabled = false;
      });
      grossSalaryFlag=1;
    }
    else if(grossSalaryFlag==1 && grossSalaryLastPaidController.value.text.isNotEmpty)
    {
      grossSalaryFlag=0;
    }
    if (netSalaryLastPaidController.value.text.isEmpty) {
      setState(() {
        isEnabled = false;
      });
      netSalaryFlag=1;
    }
    else if(netSalaryFlag==1 && netSalaryLastPaidController.value.text.isNotEmpty)
    {
      netSalaryFlag=0;
    }
    // var sum  = address2Flag+address1Flag+cityFlag+countryFlag+stateFlag+zipFlag;
    // debugPrint(sum as String?);
    if (companyFlag == 0 && hireDateFlag ==0 && experienceFlag == 0 && currentCompanyExperienceFlag == 0 && grossSalaryFlag == 0 && netSalaryFlag == 0 && designationFlag==0 && jobType!="" ) {
      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Login(),),);
      debugPrint("hey hey hey ehye hye");
    }

  }


  @override
  Widget build(BuildContext context) {
    TextStyle? textstyle = Theme
        .of(context)
        .textTheme
        .subtitle2;

    return Scaffold(
      appBar: AppBar(
        title: Text("Salary Information"),
        centerTitle: false,
      ),

      body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Padding(padding: EdgeInsets.all(10),),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.add_business,color: Colors.black),
                          labelText: "Employer",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(13),
                          ),
                        ),
                        controller: companyController,
                        keyboardType: TextInputType.text,
                        validator: (companyName) {
                          if (companyName!.isEmpty) {
                            return "Comapany name can\'t be empty";
                          }
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onChanged: (companyName) {
                          if (companyName.isNotEmpty) {
                            setState(() {
                              isEnabled = true;
                            });
                          }
                          companyName;
                        }
                    ),

                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.credit_card,color: Colors.black),
                          labelText: "Last4Tin",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(13),
                          ),
                        ),
                        controller: last4TinController,
                        keyboardType: TextInputType.number,
                        maxLength: 4,
                        validator: (Last4Tin) {
                          if (Last4Tin!.isEmpty) {
                            return "Last4Tin can\'t be empty";
                          }
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onChanged: (Last4Tin) {
                          if (Last4Tin.isNotEmpty) {
                            setState(() {
                              isEnabled = true;
                            });
                          }
                          designation;
                        }
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.home,color: Colors.black),
                          labelText: "Base Salary Rate",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(13),
                          ),
                        ),
                        controller: baseSalaryRateController,
                        textAlign: TextAlign.end,
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                        validator: (baseSalaryRate) {
                          if (baseSalaryRate!.isEmpty) {
                            return "Base Salary Rate can\'t be empty";
                          }
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onChanged: (baseSalaryRate) {
                          if (baseSalaryRate.isNotEmpty) {
                            setState(() {
                              isEnabled = true;
                            });
                          }
                          baseSalaryRate;
                        }
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.location_city,color: Colors.black),
                          labelText: "Base Salary Rate Unit",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(13),
                          ),
                        ),
                        controller: baseSalaryRateUnitController,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.end,
                        validator: (baseSalaryRateUnit) {
                          if (baseSalaryRateUnit!.isEmpty) {
                            return "Base Salary Rate Unit can\'t be empty";
                          }
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onChanged: (baseSalaryRateUnit) {
                          if (baseSalaryRateUnit.isNotEmpty) {
                            setState(() {
                              isEnabled = true;
                            });
                          }
                          baseSalaryRateUnit;
                        }
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.calendar_month,color: Colors.black),
                        labelText: "Gross Salary Last Paid",
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.circular(13),

                        ),
                        //  hintText: "Enter first name",
                      ),
                      readOnly: true,
                      controller: grossSalaryLastPaidController,
                      validator: (grossSalaryLastPaid) {
                        if (grossSalaryLastPaid!.isEmpty) {
                          return "Last Salary Paymemt Date can\'t be empty";
                        }
                      },
                      onTap: () async{
                        DateTime? grossSalaryLastPaid = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(1947), lastDate: DateTime(2101));
                        if(grossSalaryLastPaid != null)
                        {
                          String formattedDate = DateFormat("yyyy-MM-dd").format(grossSalaryLastPaid);
                          setState(() {
                            grossSalaryLastPaidController.text = formattedDate.toString();
                            debugPrint(grossSalaryLastPaidController.value.text);
                          });
                        }
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.calendar_month,color: Colors.black),
                        labelText: "Net Salary Last Paid",
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.circular(13),

                        ),
                        //  hintText: "Enter first name",
                      ),
                      readOnly: true,
                      controller: netSalaryLastPaidController,
                      validator: (netSalaryLastPaid) {
                        if (netSalaryLastPaid!.isEmpty) {
                          return "Last Salary Paymemt Date can\'t be empty";
                        }
                      },
                      onTap: () async{
                        DateTime? netSalaryLastPaid = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(1947), lastDate: DateTime(2101));
                        if(netSalaryLastPaid != null)
                        {
                          String formattedDate = DateFormat("yyyy-MM-dd").format(netSalaryLastPaid);
                          setState(() {
                            netSalaryLastPaidController.text = formattedDate.toString();
                            debugPrint(netSalaryLastPaidController.value.text);
                          });
                        }
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.calendar_month,color: Colors.black),
                        labelText: "Last Salary Paymemt Date",
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.circular(13),

                        ),
                        //  hintText: "Enter first name",
                      ),
                      readOnly: true,
                      controller: lastSalaryPaymentDateController,
                      validator: (lastSalaryPaymentDate) {
                        if (lastSalaryPaymentDate!.isEmpty) {
                          return "Last Salary Paymemt Date can\'t be empty";
                        }
                      },
                      onTap: () async{
                        DateTime? dob = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(1947), lastDate: DateTime(2101));
                        if(dob != null)
                        {
                          String formattedDate = DateFormat("yyyy-MM-dd").format(dob);
                          setState(() {
                            lastSalaryPaymentDateController.text = formattedDate.toString();
                            debugPrint(lastSalaryPaymentDateController.value.text);
                          });
                        }
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.location_on,color: Colors.black),
                          labelText: "Max Salary Earned In Period",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(13),
                          ),
                        ),
                        controller: maxSalaryEarnedInPeriodController,
                        textAlign: TextAlign.end,
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                        validator: (maxSalaryEarnedInPeriod) {
                          if (maxSalaryEarnedInPeriod!.isEmpty) {
                            return "Max Salary Earned In Period can\'t be empty";
                          }
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onChanged: (maxSalaryEarnedInPeriod) {
                          if (maxSalaryEarnedInPeriod.isNotEmpty) {
                            setState(() {
                              isEnabled = true;
                            });
                          }
                          maxSalaryEarnedInPeriod;
                        }
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.location_on,color: Colors.black),
                          labelText: "Min Salary Earned In Period",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(13),
                          ),
                        ),
                        controller: minSalaryEarnedInPeriodController,
                        textAlign: TextAlign.end,
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                        validator: ( minSalaryEarnedInPeriod) {
                          if ( minSalaryEarnedInPeriod!.isEmpty) {
                            return "Min Salary Earned In Period can\'t be empty";
                          }
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onChanged: ( minSalaryEarnedInPeriod) {
                          if ( minSalaryEarnedInPeriod.isNotEmpty) {
                            setState(() {
                              isEnabled = true;
                            });
                          }
                          minSalaryEarnedInPeriod;
                        }
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.location_on,color: Colors.black),
                          labelText: "Average Salary Earned In Period",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(13),
                          ),
                        ),
                        controller: averageSalaryEarnedInPeriodController,
                        textAlign: TextAlign.end,
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                        validator: (averageSalaryEarnedInPeriod) {
                          if (averageSalaryEarnedInPeriod!.isEmpty) {
                            return "Average Salary Earned In Period can\'t be empty";
                          }
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onChanged: (averageSalaryEarnedInPeriod) {
                          if (averageSalaryEarnedInPeriod.isNotEmpty) {
                            setState(() {
                              isEnabled = true;
                            });
                          }
                          averageSalaryEarnedInPeriod;
                        }
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.location_on,color: Colors.black),
                          labelText: "Payment frequency",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(13),
                          ),
                        ),
                        controller: paymentFrequencyController,
                        keyboardType: TextInputType.text,
                        validator: (paymentFrequency) {
                          if (paymentFrequency!.isEmpty) {
                            return "Payment frequency can\'t be empty";
                          }
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onChanged: (paymentFrequency) {
                          if (paymentFrequency.isNotEmpty) {
                            setState(() {
                              isEnabled = true;
                            });
                          }
                          paymentFrequency;
                        }
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.location_on,color: Colors.black),
                          labelText: "Salary Account Number",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(13),
                          ),
                        ),
                        controller: salaryAccountNumberController,
                        keyboardType: TextInputType.number,
                        validator: (salaryAccountNumber) {
                          if (salaryAccountNumber!.isEmpty) {
                            return "Salary Account Number can\'t be empty";
                          }
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onChanged: (salaryAccountNumber) {
                          if (salaryAccountNumber.isNotEmpty) {
                            setState(() {
                              isEnabled = true;
                            });
                          }
                          salaryAccountNumber;
                        }
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.location_on,color: Colors.black),
                          labelText: "abaNumber",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(13),
                          ),
                        ),
                        controller: abaNumberController,
                        keyboardType: TextInputType.number,
                        validator: (abaNumber) {
                          if (abaNumber!.isEmpty) {
                            return "abaNumber can\'t be empty";
                          }
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onChanged: (abaNumber) {
                          if (abaNumber.isNotEmpty) {
                            setState(() {
                              isEnabled = true;
                            });
                          }
                          abaNumber;
                        }
                    ),


                    Padding(padding: EdgeInsets.only(
                        top: 5 * 2, bottom: 5)),
                    isEnabled == false ? Text(
                      "Feilds can't be empty", style: TextStyle(
                        color: Colors.red
                    ),) : Text(""),

                    SizedBox(
                      width: 250,
                      child:   ElevatedButton(
                        style: ElevatedButton.styleFrom(

                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100)),
                            backgroundColor: Colors.black
                        ),
                        onPressed: validate,
                        child: Text("Next"),
                      ),
                    ),
                  ],
                ) ,
              )
            ],
          )



      ),
    );
  }
}
