import 'package:flutter/material.dart';
import 'package:gpsd_project/buyer_screens/buyer_signupsc.dart';
import 'package:gpsd_project/seller_screens/seller_signupsc.dart';
import 'package:gpsd_project/transporter_screens/transporter_signupsc.dart';

import '../reusable_widgets/reusable_widgets.dart';

class SignUpSelect extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 109, 141, 110),
        elevation: 10,
        title: const Text(
          "Sign Up As, ",
          style: TextStyle(
              color: Colors.black38, fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 125,
            ),
            signInSignUpButton('Buyer', () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => BuyerSignUp()));
            }),
            const SizedBox(
              height: 20,
            ),
            signInSignUpButton('Seller', () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SellerSignUp()));
            }),
            const SizedBox(
              height: 20,
            ),
            signInSignUpButton('Transporter', () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TransporterSignUp()));
            }),
          ],
        ),
      ),
    );
  }
}
