import 'dart:convert';
import 'dart:ffi';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;
import 'package:loans/Screens/EmploymentInfoScreen.dart';
import 'package:loans/Screens/Login.dart';


class AddressInfoScreen extends StatefulWidget {

  AddressInfoScreen();
  @override
  AddressInfoScreenState createState() => AddressInfoScreenState();
}



class AddressInfoScreenState extends State<AddressInfoScreen> {

  AddressInfoScreenState();


  String? identityType = "";
  var numberOfDigits = 0;
  bool isSelected = false;

  final countryController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final zipController = TextEditingController();
  final addressController1 = TextEditingController();
  final addressController2 = TextEditingController();

  var address1 = "";
  var address2 = "";
  var country = "";
  var city = "";
  var state = "";
  var zip = "";

  bool isEnabled = true;

  @override
  void dispose() {
    super.dispose();
    countryController.dispose();
    cityController.dispose();
    stateController.dispose();
    zipController.dispose();
    addressController1.dispose();
    addressController2.dispose();
  }
  validate() async {

    var countryFlag = 0;
    var cityFlag = 0;
    var  stateFlag = 0;
    var zipFlag = 0;
    var address1Flag = 0;
    var address2Flag = 0;

    if (cityController.value.text.isEmpty) {
      setState(() {
        isEnabled = false;
      });
      cityFlag=1;
    }
    else if(cityFlag==1 && cityController.value.text.isNotEmpty)
    {
      cityFlag=0;
    }
    if (stateController.value.text.isEmpty) {
      setState(() {
        isEnabled = false;
      });
      stateFlag=1;
    }
    else if(stateFlag==1 && stateController.value.text.isNotEmpty)
    {
      stateFlag=0;
    }
    if (zipController.value.text.isEmpty) {
      setState(() {
        isEnabled = false;
      });
      zipFlag=1;
    }
    else if(zipController.value.text.isNotEmpty && zipController.value.text.length<6)
    {
      zipFlag=1;
    }
    else if(zipFlag==1 && zipController.value.text.isNotEmpty && zipController.value.text.length==6)
      {
        zipFlag=0;
      }
    if (countryController.value.text.isEmpty) {
      setState(() {
        isEnabled = false;
      });
      countryFlag=1;
    }
    else if(countryFlag==1 && countryController.value.text.isNotEmpty)
    {
      countryFlag=0;
    }
    if (addressController1.value.text.isEmpty) {
      setState(() {
        isEnabled = false;
      });
      address1Flag=1;
    }
    else if(address1Flag==1 && addressController1.value.text.isNotEmpty)
    {
      address1Flag=0;
    }
    if (addressController2.value.text.isEmpty) {
      setState(() {
        isEnabled = false;
      });
      address2Flag=1;
    }
    else if(address2Flag==1 && addressController2.value.text.isNotEmpty)
    {
      address2Flag=0;
    }
    // var sum  = address2Flag+address1Flag+cityFlag+countryFlag+stateFlag+zipFlag;
    // debugPrint(sum as String?);
    if (address2Flag == 0 && address1Flag == 0 && cityFlag == 0 && countryFlag == 0 && stateFlag == 0 && zipFlag == 0 ) {
      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>EmploymentInfoScreen(),),);
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
                          labelText: "Address line 1",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(13),
                          ),
                        ),
                        controller: addressController1,
                        keyboardType: TextInputType.streetAddress,
                        validator: (address) {
                          if (address!.isEmpty) {
                            return "Address can\'t be empty";
                          }
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onChanged: (address) {
                          if (address.isNotEmpty) {
                            setState(() {
                              isEnabled = true;
                            });
                          }
                          address1;
                        }
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.home,color: Colors.black),
                          labelText: "Address line 2",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(13),
                          ),
                        ),
                        controller: addressController2,
                        keyboardType: TextInputType.streetAddress,
                        validator: (address) {
                          if (address!.isEmpty) {
                            return "Address can\'t be empty";
                          }
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onChanged: (address) {
                          if (address.isNotEmpty) {
                            setState(() {
                              isEnabled = true;
                            });
                          }
                          address2;
                        }
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.location_city,color: Colors.black),
                          labelText: "City",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(13),
                          ),
                        ),
                        controller: cityController,
                        keyboardType: TextInputType.text,
                        validator: (city) {
                          if (city!.isEmpty) {
                            return "City can\'t be empty";
                          }
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onChanged: (city) {
                          if (city.isNotEmpty) {
                            setState(() {
                              isEnabled = true;
                            });
                          }
                          city;
                        }
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.location_on,color: Colors.black),
                          labelText: "State",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(13),
                          ),
                        ),
                        controller: stateController,
                        keyboardType: TextInputType.streetAddress,
                        validator: (state) {
                          if (state!.isEmpty) {
                            return "state can\'t be empty";
                          }
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onChanged: (state) {
                          if (state.isNotEmpty) {
                            setState(() {
                              isEnabled = true;
                            });
                          }
                          state;
                        }
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.location_on,color: Colors.black),
                          labelText: "Country",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(13),
                          ),
                        ),
                        controller: countryController,
                        keyboardType: TextInputType.streetAddress,
                        validator: (country) {
                          if (country!.isEmpty) {
                            return "country can\'t be empty";
                          }
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onChanged: (country) {
                          if (country.isNotEmpty) {
                            setState(() {
                              isEnabled = true;
                            });
                          }
                          country;
                        }
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.numbers_sharp,color: Colors.black),
                          labelText: "Zipcode",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(13),
                          ),
                        ),
                        controller: zipController,
                        maxLength: 6,
                        keyboardType: TextInputType.number,
                        validator: (zip) {
                          if (zip!.isEmpty) {
                            return "Zipcode can\'t be empty";
                          }
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onChanged: (zip) {
                          if (zip.isNotEmpty) {
                            setState(() {
                              isEnabled = true;
                            });
                          }
                          zip;
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
