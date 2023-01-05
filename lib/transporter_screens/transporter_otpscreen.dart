import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gpsd_project/screens/home_screen.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class transporterOTP extends StatefulWidget {
  final String name;
  final String phone;
  final String verIDC;
  final String username;
  final String nic;
  final String phoneno;
  final String address;
  final String password;
  final String vehicleNum;
  final String vehicletype;
  final String vehicledistrict;
  final String vehicleprovince;
  final String vehicleweightcap;
  final File image;
  const transporterOTP({
    super.key,
    required this.phone,
    required this.verIDC,
    required this.username,
    required this.nic,
    required this.phoneno,
    required this.address,
    required this.password,
    required this.name,
    required this.vehicleNum,
    required this.vehicletype,
    required this.image,
    required this.vehicledistrict,
    required this.vehicleprovince,
    required this.vehicleweightcap,
  });

  @override
  State<transporterOTP> createState() => _transporterOTPState();
}

class _transporterOTPState extends State<transporterOTP> {
  var uuid = Uuid();
  String otpPin = " ";
  late SharedPreferences sharedPreferences;
  late String vehicleimgurl;

  Future<void> verifyOTP() async {
    try {
      await FirebaseAuth.instance
          .signInWithCredential(
        PhoneAuthProvider.credential(
            verificationId: widget.verIDC, smsCode: otpPin),
      )
          .then(
        (value) async {
          showSnackBarText('Verified');
          SendImage();

          sharedPreferences = await SharedPreferences.getInstance();

          //setting username for shared preferences

          sharedPreferences.setString('username', widget.username).then(
            (_) {
              // navigating to the home page
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));
            },
          );
        },
      ).whenComplete(() {});
    } catch (e) {
      FocusScope.of(context).unfocus();
      showSnackBarText('Invalid OTP');
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 109, 141, 110),
        elevation: 10,
        title: const Text(
          'Verify your phone number',
          style: TextStyle(
              color: Colors.black38, fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 40),
            child: Center(
              child: Text(
                'Verify ${widget.phone}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          //Padding(padding: EdgeInsets.symmetric(horizontal: screenwidth/12)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth / 12),
            child: PinCodeTextField(
              appContext: context,
              length: 6,
              pinTheme: PinTheme(
                activeColor: Color.fromARGB(255, 109, 141, 110),
                selectedColor: Color.fromARGB(255, 109, 141, 110),
                inactiveColor: Color.fromARGB(255, 109, 141, 110),
              ),
              onChanged: ((value) {
                setState(() {
                  otpPin = value;
                });
                print(otpPin);
              }),
            ),
          ),
          Container(
            width: 250,
            height: 50,
            margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
            child: ElevatedButton(
              onPressed: () {
                if (otpPin.length >= 6) {
                  verifyOTP();
                } else {
                  showSnackBarText("Enter OTP correctly!");
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith((states) {
                  if (states.contains(MaterialState.pressed)) {
                    return Color.fromARGB(66, 59, 83, 21);
                  }
                  return Color.fromARGB(255, 156, 150, 121);
                }),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
              ),
              child: const Text(
                "Continue",
                style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showSnackBarText(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text)),
    );
  }

  Future createUser({required User user}) async {
    // Reference to document
    final docUser = FirebaseFirestore.instance.collection('users').doc();
    user.id = docUser.id;

    final json = user.toJson();

    await docUser.set(json);
  }

  SendImage() async {
    final vehicleimgid = uuid.v1();
    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      var file;
      file = File(widget.image.path);
      await storage.ref().child('Productdata/$vehicleimgid').putFile(file);
      vehicleimgurl = await storage
          .ref()
          .child('Productdata/$vehicleimgid')
          .getDownloadURL();
      print("number of image 1");

      final user = User(
        name: widget.name,
        username: widget.username,
        nic: widget.nic,
        phoneno: widget.phone,
        address: widget.address,
        password: widget.password,
        vehicleNumber: widget.vehicleNum,
        vehicleType: widget.vehicletype,
        vehicleimgurl: vehicleimgurl,
        vehicleimgid: vehicleimgid,
        vehicledistrict: widget.vehicledistrict,
        vehicleprovince: widget.vehicleprovince,
        vehicleweightcap: widget.vehicleweightcap,
      );
      createUser(user: user);
    } catch (e) {
      print('error');
    }
  }
}

// vehicleNumber: widget.vehicleNum,
// vehicleType: widget.vehicletype,
class User {
  String id;
  String type;
  final String name;
  final String username;
  final String nic;
  final String phoneno;
  final String address;
  final String password;
  final String vehicleNumber;
  final String vehicleType;
  final String vehicleimgurl;
  final String vehicleimgid;
  final String vehicledistrict;
  final String vehicleprovince;
  final String vehicleweightcap;

  User({
    this.id = '',
    this.type = 'T',
    required this.name,
    required this.username,
    required this.nic,
    required this.phoneno,
    required this.address,
    required this.password,
    required this.vehicleNumber,
    required this.vehicleType,
    required this.vehicleimgurl,
    required this.vehicleimgid,
    required this.vehicledistrict,
    required this.vehicleprovince,
    required this.vehicleweightcap,
  });
  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type,
        'name': name,
        'username': username,
        'nic': nic,
        'phoneno': phoneno,
        'address': address,
        'password': password,
        'vehicleType': vehicleType,
        'vehicleNum': vehicleNumber,
        'vehicleimgurl': vehicleimgurl,
        'vehicleimgid': vehicleimgid,
        'vehicledistrict': vehicledistrict,
        'vehicleprovince': vehicleprovince,
        'vehicleweightcap': vehicleweightcap,
      };
}
