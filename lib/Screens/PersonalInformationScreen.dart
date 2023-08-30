import 'dart:convert';
import 'dart:ffi';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;
import 'package:loans/Screens/AddressInfoScreen.dart';


class PersonalInformationScreen extends StatefulWidget {

  PersonalInformationScreen();
  @override
  PersonalInformationScreenState createState() => PersonalInformationScreenState();
}



class PersonalInformationScreenState extends State<PersonalInformationScreen> {

  PersonalInformationScreenState();


  String? identityType = "";
  var numberOfDigits = 0;
  bool isSelected = false;
  final dobController = TextEditingController();
  final identityController = TextEditingController();
  final countryController = TextEditingController();
  final aadharController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final zipController = TextEditingController();
  final addressController1 = TextEditingController();
  final addressController2 = TextEditingController();

  var dob = "";
  var aadharNumber = "";
  var address1 = "";
  var address2 = "";
  var country = "";
  var city = "";
  var state = "";
  var zip = "";

  bool isEnabled = true;
  List<String> identities = ["Aadhar number","Pan number"];

  @override
  void dispose() {
    super.dispose();
    dobController.dispose();
    aadharController.dispose();
    countryController.dispose();
    identityController.dispose();
    cityController.dispose();
    stateController.dispose();
    zipController.dispose();
    addressController1.dispose();
    addressController2.dispose();
  }

  validate() async {

    var dobFlag = 0;
    var identityFlag = 0;

    if (dobController.value.text.isEmpty) {
      setState(() {
        isEnabled = false;
      });
      dobFlag=1;
    }
    else if(dobFlag==1 && dobController.value.text.isNotEmpty)
    {
      dobFlag=0;
    }
    if (aadharController.value.text.isEmpty) {
      setState(() {
        isEnabled = false;
      });
      identityFlag=1;
    }
    else if(aadharController.value.text.length<numberOfDigits && aadharController.value.text.isNotEmpty)
    {
      identityFlag=1;
    }
    else if(aadharController.value.text.isNotEmpty && aadharController.value.text.length==numberOfDigits)
      {
        identityFlag=0;
      }
    if (identityFlag == 0 && dobFlag == 0 && identityType!="") {
      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddressInfoScreen(),),);
      debugPrint("hey hey hey ehye hye");

    }

  }

  @override
  Widget build(BuildContext context) {

    if(identityType == "Aadhar number")
      {
        numberOfDigits = 12;
      }
    else
      {
        numberOfDigits = 10;
      }
    TextStyle? textstyle = Theme
        .of(context)
        .textTheme
        .subtitle2;

    return Scaffold(
      appBar: AppBar(
        title: Text("Personal Information"),
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
                        prefixIcon: Icon(Icons.calendar_month,color: Colors.black),
                        labelText: "Date of birth",
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.circular(13),

                        ),
                        //  hintText: "Enter first name",
                      ),
                      readOnly: true,
                      controller: dobController,
                      validator: (dob) {
                        if (dob!.isEmpty) {
                          return "Dob can\'t be empty";
                        }
                      },
                      onTap: () async{
                        DateTime? dob = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(1947), lastDate: DateTime(2101));
                        if(dob != null)
                        {
                          String formattedDate = DateFormat("yyyy-MM-dd").format(dob);
                          setState(() {
                            dobController.text = formattedDate.toString();
                            debugPrint(dobController.value.text);
                          });
                        }
                      },
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
                      value: identities.first,
                      validator: (type) {
                        if (type!.isEmpty) {
                          return "identity type can\'t be empty";
                        }
                      },
                      onChanged: (String? newValue) async {
                        setState(()  {
                          identityType = newValue!;
                        });
                      },
                      items: identities.map((String items) {
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
                          prefixIcon: Icon(Icons.perm_identity_rounded,color: Colors.black),
                          labelText: "${identityType}",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(13),
                          ),
                        ),
                        controller: aadharController,
                        keyboardType: TextInputType.number,
                        maxLength: numberOfDigits,
                        validator: (aadharNumber) {
                          if (aadharNumber!.isEmpty) {
                            return "Aadhar number can\'t be empty";
                          }
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onChanged: (aadharNumber) {
                          if (aadharNumber.isNotEmpty) {
                            setState(() {
                              isEnabled = true;
                            });
                          }
                          aadharNumber;
                        }
                    ),
                    SizedBox(
                      height: 20,
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
