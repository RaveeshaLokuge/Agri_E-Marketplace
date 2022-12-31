import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gpsd_project/screens/home_screen.dart';
import 'package:gpsd_project/transporter_screens/transporter_otpscreen.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import 'package:image_picker/image_picker.dart';

import '../reusable_widgets/reusable_widgets.dart';

const List<String> vehicle = <String>['Type1', 'Type2', 'Type3', 'Type4'];

class TransporterSignUp extends StatefulWidget {
  const TransporterSignUp({Key? key}) : super(key: key);

  @override
  State<TransporterSignUp> createState() => _TransporterSignUpState();
}

class _TransporterSignUpState extends State<TransporterSignUp> {
  File? image;
  String verID = " ";
  bool showpassword = true;
  String countryDial = "+94";
  int screenState = 0;
  bool passswordvisibe = true;
  String vehicleType = vehicle.first;
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _userNameTextController = TextEditingController();
  final TextEditingController _passwordVerifyController =
      TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _AddressController = TextEditingController();
  final TextEditingController _NICNoController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _vehicleNumberController =
      TextEditingController();

  void showSnackBarText(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 141, 170, 137),
        //Color.fromARGB(255, 109, 141, 110),
        elevation: 10,
        title: const Text(
          "Sign Up As a Transporter",
          style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontSize: 24,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const Align(
              alignment: Alignment.center,
            ),
            const SizedBox(
              height: 105,
            ),
            //Enter your name text field
            formTextField(
                "Enter Your Name", FontAwesomeIcons.user, _nameController),
            const SizedBox(
              height: 20,
            ),
            //Enter your nic text field
            formTextField(
                "NIC Number", FontAwesomeIcons.idCard, _NICNoController),
            const SizedBox(
              height: 20,
            ),
            //Enter Mobile number text field
            SizedBox(
              width: 350.0,
              child: IntlPhoneField(
                controller: _phoneNumberController,
                showCountryFlag: true,
                showDropdownIcon: true,
                initialValue: countryDial,
                onCountryChanged: (country) {
                  setState(() {
                    countryDial = "+" + country.dialCode;
                  });
                },
                cursorColor: Colors.black45,
                style: TextStyle(color: Colors.black.withOpacity(0.6)),
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    FontAwesomeIcons.phone,
                    color: Color.fromARGB(80, 0, 0, 0),
                  ),
                  hintText: "Mobile Number",
                  filled: true,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  fillColor:
                      const Color.fromARGB(255, 185, 224, 186).withOpacity(0.3),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide:
                        const BorderSide(width: 0, style: BorderStyle.none),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            //Enter address text field
            formTextField(
                "Address", FontAwesomeIcons.house, _AddressController),

            const SizedBox(
              height: 20,
            ),
            formTextField("Vehicle registration number", FontAwesomeIcons.truck,
                _vehicleNumberController),

            const SizedBox(
              height: 20,
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 40, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Select Your Vehical Type',
                    style: TextStyle(
                        color: Color.fromARGB(255, 83, 77, 69),
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            //Dropdown menu
            Container(
                width: 350,
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 185, 224, 186).withOpacity(0.3),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    dropdownColor: Color.fromARGB(255, 246, 248, 246),
                    value: vehicleType,
                    iconSize: 36,
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black,
                    ),
                    isExpanded: true,
                    items: vehicle.map(buildMenuItem).toList(),
                    onChanged: (value) => setState(() => vehicleType = value!),
                  ),
                )),
            const SizedBox(
              height: 20,
            ),

            //Enter password text field
            SizedBox(
              width: 350.0,
              child: TextFormField(
                controller: _passwordTextController,
                enableSuggestions: false,
                autocorrect: false,
                cursorColor: Colors.black45,
                style: TextStyle(color: Colors.black.withOpacity(0.9)),
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    FontAwesomeIcons.key,
                    color: Color.fromARGB(80, 0, 0, 0),
                  ),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        passswordvisibe = !passswordvisibe;
                      });
                    },
                    child: Icon(passswordvisibe
                        ? Icons.visibility
                        : Icons.visibility_off),
                  ),
                  labelText: 'Enter password',
                  labelStyle: TextStyle(color: Colors.black.withOpacity(0.6)),
                  filled: true,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  fillColor:
                      Color.fromARGB(255, 185, 224, 186).withOpacity(0.3),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide:
                        const BorderSide(width: 0, style: BorderStyle.none),
                  ),
                ),
                obscureText: passswordvisibe,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            //Verify password text field
            SizedBox(
              width: 350.0,
              child: TextFormField(
                controller: _passwordVerifyController,
                enableSuggestions: false,
                autocorrect: false,
                cursorColor: Colors.black45,
                style: TextStyle(color: Colors.black.withOpacity(0.9)),
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    FontAwesomeIcons.key,
                    color: Color.fromARGB(80, 0, 0, 0),
                  ),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        passswordvisibe = !passswordvisibe;
                      });
                    },
                    child: Icon(passswordvisibe
                        ? Icons.visibility
                        : Icons.visibility_off),
                  ),
                  labelText: 'Re-enter password',
                  labelStyle: TextStyle(color: Colors.black.withOpacity(0.6)),
                  filled: true,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  fillColor:
                      Color.fromARGB(255, 185, 224, 186).withOpacity(0.3),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide:
                        const BorderSide(width: 0, style: BorderStyle.none),
                  ),
                ),
                obscureText: passswordvisibe,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            // Enter User Name Text Field
            formTextField("Enter User Name", FontAwesomeIcons.user,
                _userNameTextController),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 40, 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Text(
                    'Remember this for your future logins',
                    style: TextStyle(color: Colors.orangeAccent),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _getPhoto(),
            ),

            image != null
                ? Image.file(
                    image!,
                    width: 160,
                    height: 160,
                    fit: BoxFit.cover,
                  )
                : FlutterLogo(
                    size: 160,
                  ),
            const SizedBox(
              height: 30,
            ),

            // Sign Up Button
            Container(
              width: 150,
              height: 50,
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(90)),
              child: ElevatedButton(
                onPressed: () async {
                  FocusScope.of(context).unfocus();
                  String? usrename = _userNameTextController.text.trim();
                  QuerySnapshot snap = await FirebaseFirestore.instance
                      .collection("buyer")
                      .where('username', isEqualTo: usrename)
                      .get();
                  try {
                    if (snap.docs[0]['username'] != null) {
                      showSnackBarText(
                          "User name exist! \nPlease enter a different user name!");
                    }
                  } catch (e) {
                    if (_nameController.text.isEmpty) {
                      showSnackBarText("Name is still empty!");
                    } else if (_NICNoController.text.isEmpty) {
                      showSnackBarText("NIC Number is still empty!");
                    } else if (_phoneNumberController.text.isEmpty) {
                      showSnackBarText("Phone number is still empty!");
                    } else if (_AddressController.text.isEmpty) {
                      showSnackBarText("Address is still empty!");
                    } else if (_vehicleNumberController.text.isEmpty) {
                      showSnackBarText("Vehicle number is empty");
                    } else if (_passwordTextController.text.isEmpty) {
                      showSnackBarText("Password is still empty!");
                    } else if (_passwordVerifyController.text.isEmpty) {
                      showSnackBarText("Password verification is still empty!");
                    } else if (_passwordVerifyController.text !=
                        _passwordTextController.text) {
                      showSnackBarText("Passwords are not equal");
                    } else if (_userNameTextController.text.isEmpty) {
                      showSnackBarText("Username is still empty!");
                    } else {
                      verifyPhone(countryDial + _phoneNumberController.text);
                    }
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith((states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Color.fromARGB(255, 130, 187, 37);
                    }
                    return Color.fromARGB(255, 211, 196, 123);
                  }),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                ),
                child: const Text(
                  "Sign Up",
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> verifyPhone(String number) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: number,
      timeout: const Duration(seconds: 100),
      verificationCompleted: (PhoneAuthCredential credential) {
        showSnackBarText("Auth Completed!");
      },
      verificationFailed: (FirebaseException e) {
        showSnackBarText("Auth Failed!");
      },
      codeSent: (String verificationId, int? resendToken) {
        showSnackBarText("OTP Sent!");
        verID = verificationId;
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => transporterOTP(
                  phone: countryDial + _phoneNumberController.text,
                  verIDC: verID,
                  address: _AddressController.text,
                  nic: _NICNoController.text,
                  password: _passwordTextController.text,
                  phoneno: _phoneNumberController.text,
                  username: _userNameTextController.text,
                  name: _nameController.text,
                  vehicleNum: _vehicleNumberController.text,
                  vehicletype: vehicleType,
                  image: image!,
                )));
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 1),
          child: Text(
            item,
            style:
                TextStyle(fontSize: 20, color: Colors.black.withOpacity(0.8)),
            textAlign: TextAlign.center,
          ),
        ),
      );
  Widget _getPhoto() {
    return RawMaterialButton(
      onPressed: () {
        _showModalBottomSheet(context);
      },
      elevation: 2.0,
      fillColor: Colors.white,
      padding: const EdgeInsets.all(40.0),
      shape: const CircleBorder(),
      child: const Icon(
        CupertinoIcons.camera,
        size: 20,
      ),
    );
  }

  Future _showModalBottomSheet(context) async {
    //popup view
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) => CupertinoActionSheet(
              actions: [
                CupertinoActionSheetAction(
                    child: const Text("Pick Image from Camera",
                        style: TextStyle(
                            color: Color.fromARGB(179, 2, 0, 0),
                            fontWeight: FontWeight.bold)),
                    onPressed: () {
                      _pickImage(ImageSource.camera);
                    }),
                CupertinoActionSheetAction(
                    child: const Text("Pick Image from Gallery",
                        style: TextStyle(
                            color: Color.fromARGB(179, 0, 0, 0),
                            fontWeight: FontWeight.bold)),
                    onPressed: () {
                      _pickImage(ImageSource.gallery);
                    }),
                SizedBox(
                  height: 20,
                ),
              ],
            ));
  }

  void _pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() => this.image = imageTemporary);
    } catch (e) {
      print('Failed to pick image: $e');
    }
  }
}
