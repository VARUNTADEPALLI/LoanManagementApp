import 'dart:convert';
import 'dart:ffi';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;
import 'package:loans/Screens/Login.dart';


class EmploymentInfoScreen extends StatefulWidget {

  EmploymentInfoScreen();
  @override
  EmploymentInfoScreenState createState() => EmploymentInfoScreenState();
}



class EmploymentInfoScreenState extends State<EmploymentInfoScreen> {

  EmploymentInfoScreenState();


  String? jobType = "";
  var numberOfDigits = 0;
  bool isSelected = false;

  final companyController = TextEditingController();
  final hireDateController = TextEditingController();
  final designationController = TextEditingController();
  final experienceController = TextEditingController();
  final currentCompanyExperienceController = TextEditingController();
  final grossSalaryController = TextEditingController();
  final netSalaryController = TextEditingController();

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
    experienceController.dispose();
    currentCompanyExperienceController.dispose();
    grossSalaryController.dispose();
    netSalaryController.dispose();
    designationController.dispose();
    hireDateController.dispose();
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

    if (hireDateController.value.text.isEmpty) {
      setState(() {
        isEnabled = false;
      });
      hireDateFlag=1;
    }
    else if(hireDateFlag==1 && hireDateController.value.text.isNotEmpty)
    {
      hireDateFlag=0;
    }

    if (designationController.value.text.isEmpty) {
      setState(() {
        isEnabled = false;
      });
      designationFlag=1;
    }
    else if(designationFlag==1 && designationController.value.text.isNotEmpty)
    {
      designationFlag=0;
    }

    if (experienceController.value.text.isEmpty) {
      setState(() {
        isEnabled = false;
      });
      experienceFlag=1;
    }
    else if(experienceFlag==1 && experienceController.value.text.isNotEmpty)
    {
      experienceFlag=0;
    }
    if (currentCompanyExperienceController.value.text.isEmpty) {
      setState(() {
        isEnabled = false;
      });
      currentCompanyExperienceFlag=1;
    }
    else if(currentCompanyExperienceFlag==1 && currentCompanyExperienceController.value.text.isNotEmpty)
    {
      currentCompanyExperienceFlag=0;
    }
    if (grossSalaryController.value.text.isEmpty) {
      setState(() {
        isEnabled = false;
      });
      grossSalaryFlag=1;
    }
    else if(grossSalaryFlag==1 && grossSalaryController.value.text.isNotEmpty)
    {
      grossSalaryFlag=0;
    }
    if (netSalaryController.value.text.isEmpty) {
      setState(() {
        isEnabled = false;
      });
      netSalaryFlag=1;
    }
    else if(netSalaryFlag==1 && netSalaryController.value.text.isNotEmpty)
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
        title: Text("Address Information"),
        centerTitle: false,
      ),

      body: SingleChildScrollView(

          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: ListView(
                  shrinkWrap:  true,
                  children: [
                    Padding(padding: EdgeInsets.all(10),),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.home,color: Colors.black),
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
                          prefixIcon: Icon(Icons.home,color: Colors.black),
                          labelText: "Designation",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(13),
                          ),
                        ),
                        controller: designationController,
                        keyboardType: TextInputType.text,
                        validator: (designation) {
                          if (designation!.isEmpty) {
                            return "Designation can\'t be empty";
                          }
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onChanged: (designation) {
                          if (designation.isNotEmpty) {
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
                        prefixIcon: Icon(Icons.calendar_month,color: Colors.black),
                        labelText: "Hire Date",
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.circular(13),

                        ),
                        //  hintText: "Enter first name",
                      ),
                      readOnly: true,
                      controller: hireDateController,
                      validator: (hireDate) {
                        if (hireDate!.isEmpty) {
                          return "Hire date can\'t be empty";
                        }
                      },
                      onTap: () async{
                        DateTime? hireDate = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(1947), lastDate: DateTime(2101));
                        if(hireDate != null)
                        {
                          String formattedDate = DateFormat("yyyy-MM-dd").format(hireDate);
                          setState(() {
                            hireDateController.text = formattedDate.toString();
                            debugPrint(hireDateController.value.text);
                          });
                        }
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.home,color: Colors.black),
                          labelText: "Work Experience",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(13),
                          ),
                        ),
                        controller: experienceController,
                        keyboardType: TextInputType.number,
                        maxLength: 2,
                        validator: (experience) {
                          if (experience!.isEmpty) {
                            return "Work experience can\'t be empty";
                          }
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onChanged: (experience) {
                          if (experience.isNotEmpty) {
                            setState(() {
                              isEnabled = true;
                            });
                          }
                          experience;
                        }
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    DropdownButtonFormField(
                      decoration: InputDecoration(
                        labelText: "Select government id type",
                        enabledBorder: OutlineInputBorder(

                          borderSide: BorderSide(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        filled: true,
                        fillColor: Colors.white10,
                      ),
                      // dropdownColor: Colors.white,
                      value: jobTypes.first,
                      validator: (jobType) {
                        if (jobType!.isEmpty) {
                          return "jobType type can\'t be empty";
                        }
                      },
                      onChanged: (String? newValue) async {
                        setState(()  {
                          jobType = newValue!;
                        });
                      },
                      items: jobTypes.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.location_city,color: Colors.black),
                          labelText: "Current Company Experience",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(13),
                          ),
                        ),
                        controller: currentCompanyExperienceController,
                        keyboardType: TextInputType.number,
                        maxLength: 2,
                        validator: (currentCompanyExperience) {
                          if (currentCompanyExperience!.isEmpty) {
                            return "Current company experience can\'t be empty";
                          }
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onChanged: (currentCompanyExperience) {
                          if (currentCompanyExperience.isNotEmpty) {
                            setState(() {
                              isEnabled = true;
                            });
                          }
                          currentCompanyExperience;
                        }
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.location_on,color: Colors.black),
                          labelText: "Gross Salary",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(13),
                          ),
                        ),
                        controller: grossSalaryController,
                        keyboardType: TextInputType.number,
                        validator: (grossSalary) {
                          if (grossSalary!.isEmpty) {
                            return "Gross salary can\'t be empty";
                          }
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onChanged: (grossSalary) {
                          if (grossSalary.isNotEmpty) {
                            setState(() {
                              isEnabled = true;
                            });
                          }
                          grossSalary;
                        }
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.location_on,color: Colors.black),
                          labelText: "Net Salary",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(13),
                          ),
                        ),
                        controller: netSalaryController,
                        keyboardType: TextInputType.number,
                        validator: (netSalary) {
                          if (netSalary!.isEmpty) {
                            return "Net salary can\'t be empty";
                          }
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onChanged: (netSalary) {
                          if (netSalary.isNotEmpty) {
                            setState(() {
                              isEnabled = true;
                            });
                          }
                          netSalary;
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
