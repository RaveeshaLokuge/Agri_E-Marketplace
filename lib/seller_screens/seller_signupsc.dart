import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gpsd_project/screens/home_screen.dart';
import 'package:gpsd_project/seller_screens/seller_otpscreen.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../reusable_widgets/reusable_widgets.dart';

class SellerSignUp extends StatefulWidget {
  const SellerSignUp({Key? key}) : super(key: key);

  @override
  State<SellerSignUp> createState() => _SellerSignUpState();
}

class _SellerSignUpState extends State<SellerSignUp> {
  String verID = " ";
  bool showpassword = true;
  String countryDial = "+94";
  int screenState = 0;
  bool passswordvisibe = true;
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _userNameTextController = TextEditingController();
  TextEditingController _passwordVerifyController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _AddressController = TextEditingController();
  TextEditingController _NICNoController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
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
          "Sign Up As a Seller",
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
            ), //Enter your name text field
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
                      .collection("users")
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
            builder: (context) => SellerOTP(
                  phone: countryDial + _phoneNumberController.text,
                  verIDC: verID,
                  address: _AddressController.text,
                  nic: _NICNoController.text,
                  password: _passwordTextController.text,
                  phoneno: _phoneNumberController.text,
                  username: _userNameTextController.text,
                  name: _nameController.text,
                )));
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }
}
