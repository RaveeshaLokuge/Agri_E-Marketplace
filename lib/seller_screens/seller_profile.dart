import 'package:flutter/material.dart';
import 'package:gpsd_project/screens/home_screen.dart';
import 'package:gpsd_project/seller_screens/product_listsc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SellerProfile extends StatefulWidget {
  const SellerProfile({super.key});

  @override
  State<SellerProfile> createState() => _SellerProfileState();
}

class _SellerProfileState extends State<SellerProfile> {
  late SharedPreferences sharedPreferences;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 141, 170, 137),
        //Color.fromARGB(255, 109, 141, 110),
        elevation: 10,
        title: const Text(
          "Seller Profile",
          style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontSize: 24,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 250,
              height: 50,
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(90)),
              child: ElevatedButton(
                onPressed: () async {
                  sharedPreferences = await SharedPreferences.getInstance();
                  await sharedPreferences.clear();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ),
                  );
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
                  'Log out',
                  style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
            ),
            Container(
              width: 250,
              height: 50,
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(90)),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductList(
                                lat: 0.0,
                                lng: 0.0,
                                descreption: null,
                                district: null,
                                img: [],
                                name: null,
                                price: null,
                                province: null,
                                title: null,
                                village: null,
                                weight: null,
                              )));
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
                  'List',
                  style: TextStyle(
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
}
