import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gpsd_project/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BuyerProfile extends StatefulWidget {
  const BuyerProfile({super.key});

  @override
  State<BuyerProfile> createState() => _BuyerProfileState();
}

class _BuyerProfileState extends State<BuyerProfile> {
  late SharedPreferences sharedPreferences;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 141, 170, 137),
        //Color.fromARGB(255, 109, 141, 110),
        elevation: 10,
        title: const Text(
          "Buyer Profile",
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
          ],
        ),
      ),
    );
  }
}

// class _BuyerProfileState extends State<BuyerProfile> {
//   late SharedPreferences sharedPreferences;
//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     double height = MediaQuery.of(context).size.height;
//     return Stack(
//       fit: StackFit.expand,
//       children: [
//         Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [
//                 Color.fromRGBO(4, 9, 35, 1),
//                 Color.fromRGBO(39, 105, 171, 1),
//               ],
//               begin: FractionalOffset.bottomCenter,
//               end: FractionalOffset.topCenter,
//             ),
//           ),
//         ),
//         Scaffold(
//           backgroundColor: Colors.transparent,
//           body: SingleChildScrollView(
//             physics: BouncingScrollPhysics(),
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 73),
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Icon(
//                         Icons.arrow_left,
//                         color: Colors.white,
//                       ),
//                       Icon(
//                         Icons.logout,
//                         color: Colors.white,
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   Text(
//                     'My\nProfile',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 34,
//                       fontFamily: 'Nisebuschgardens',
//                     ),
//                   ),
//                   SizedBox(
//                     height: 22,
//                   ),
//                   Container(
//                     height: height * 0.43,
//                     child: LayoutBuilder(
//                       builder: (context, constraints) {
//                         double innerHeight = constraints.maxHeight;
//                         double innerWidth = constraints.maxWidth;
//                         return Stack(
//                           fit: StackFit.expand,
//                           children: [
//                             Positioned(
//                               bottom: 0,
//                               left: 0,
//                               right: 0,
//                               child: Container(
//                                 height: innerHeight * 0.72,
//                                 width: innerWidth,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(30),
//                                   color: Colors.white,
//                                 ),
//                                 child: Column(
//                                   children: [
//                                     SizedBox(
//                                       height: 80,
//                                     ),
//                                     Text(
//                                       'Jhone Doe',
//                                       style: TextStyle(
//                                         color: Color.fromRGBO(39, 105, 171, 1),
//                                         fontFamily: 'Nunito',
//                                         fontSize: 37,
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: 5,
//                                     ),
//                                     Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: [
//                                         Column(
//                                           children: [
//                                             Text(
//                                               'Orders',
//                                               style: TextStyle(
//                                                 color: Colors.grey[700],
//                                                 fontFamily: 'Nunito',
//                                                 fontSize: 25,
//                                               ),
//                                             ),
//                                             Text(
//                                               '10',
//                                               style: TextStyle(
//                                                 color: Color.fromRGBO(
//                                                     39, 105, 171, 1),
//                                                 fontFamily: 'Nunito',
//                                                 fontSize: 25,
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                         Padding(
//                                           padding: const EdgeInsets.symmetric(
//                                             horizontal: 25,
//                                             vertical: 8,
//                                           ),
//                                           child: Container(
//                                             height: 50,
//                                             width: 3,
//                                             decoration: BoxDecoration(
//                                               borderRadius:
//                                                   BorderRadius.circular(100),
//                                               color: Colors.grey,
//                                             ),
//                                           ),
//                                         ),
//                                         Column(
//                                           children: [
//                                             Text(
//                                               'Pending',
//                                               style: TextStyle(
//                                                 color: Colors.grey[700],
//                                                 fontFamily: 'Nunito',
//                                                 fontSize: 25,
//                                               ),
//                                             ),
//                                             Text(
//                                               '1',
//                                               style: TextStyle(
//                                                 color: Color.fromRGBO(
//                                                     39, 105, 171, 1),
//                                                 fontFamily: 'Nunito',
//                                                 fontSize: 25,
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             Positioned(
//                               top: 110,
//                               right: 20,
//                               child: Icon(
//                                 Icons.settings,
//                                 color: Colors.grey[700],
//                                 size: 30,
//                               ),
//                             ),
//                             Positioned(
//                               top: 0,
//                               left: 0,
//                               right: 0,
//                               child: Center(
//                                 child: Container(
//                                   child: Image.asset(
//                                     'assets/images/profile.png',
//                                     width: innerWidth * 0.45,
//                                     fit: BoxFit.fitWidth,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         );
//                       },
//                     ),
//                   ),
//                   SizedBox(
//                     height: 30,
//                   ),
//                   Container(
//                     height: height * 0.5,
//                     width: width,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(30),
//                       color: Colors.white,
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 15),
//                       child: Column(
//                         children: [
//                           SizedBox(
//                             height: 20,
//                           ),
//                           Text(
//                             'My Orders',
//                             style: TextStyle(
//                               color: Color.fromRGBO(39, 105, 171, 1),
//                               fontSize: 27,
//                               fontFamily: 'Nunito',
//                             ),
//                           ),
//                           Divider(
//                             thickness: 2.5,
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           Container(
//                             height: height * 0.15,
//                             decoration: BoxDecoration(
//                               color: Colors.grey,
//                               borderRadius: BorderRadius.circular(30),
//                             ),
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           Container(
//                             height: height * 0.15,
//                             decoration: BoxDecoration(
//                               color: Colors.grey,
//                               borderRadius: BorderRadius.circular(30),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }

// class _SellerProfileState extends State<SellerProfile> {
//   late SharedPreferences sharedPreferences;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color.fromARGB(255, 141, 170, 137),
//         //Color.fromARGB(255, 109, 141, 110),
//         elevation: 10,
//         title: const Text(
//           "Seller Profile",
//           style: TextStyle(
//               color: Color.fromARGB(255, 255, 255, 255),
//               fontSize: 24,
//               fontWeight: FontWeight.bold),
//         ),
//       ),
//       body: Container(
//         width: 250,
//         height: 50,
//         margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
//         decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
//         child: ElevatedButton(
//           onPressed: () async {
//             sharedPreferences = await SharedPreferences.getInstance();
//             await sharedPreferences.clear();
//             Navigator.of(context).pushReplacement(
//               MaterialPageRoute(
//                 builder: (context) => HomeScreen(),
//               ),
//             );
//           },
//           style: ButtonStyle(
//             backgroundColor: MaterialStateProperty.resolveWith((states) {
//               if (states.contains(MaterialState.pressed)) {
//                 return Color.fromARGB(66, 59, 83, 21);
//               }
//               return Color.fromARGB(255, 156, 150, 121);
//             }),
//             shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
//             ),
//           ),
//           child: const Text(
//             'Log out',
//             style: TextStyle(
//                 color: Colors.black87,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 16),
//           ),
//         ),
//       ),
//     );
//   }
// }
