import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gpsd_project/reusable_widgets/reusable_widgets.dart';
import 'package:gpsd_project/screens/home_screen.dart';
import 'package:gpsd_project/screens/select_signupsc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _userNameTextController = TextEditingController();
  bool passswordvisibe = true;
  late SharedPreferences sharedPreferences;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: 2000,
          height: 900,
          //width: Device.screenWidth,
          //height: Device.screenHeight,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 234, 252, 230),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 80,
              ),
              //logo image for sign in
              Image.asset(
                'assets/images/logsc.png',
                scale: 2,
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'Farmers Place',
                style: TextStyle(
                    color: Color.fromARGB(255, 22, 34, 2),
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 510,
                width: 450,
                child: Container(
                  height: 480,
                  width: 325,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        'Welcome!',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Please Login to your Account',
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      // User name text field
                      formTextField('Enter User Name', FontAwesomeIcons.user,
                          _userNameTextController),
                      const SizedBox(
                        height: 25,
                      ),

                      // Enter Passsword text field
                      SizedBox(
                        width: 350.0,
                        child: TextFormField(
                          controller: _passwordTextController,
                          enableSuggestions: false,
                          autocorrect: false,
                          cursorColor: Colors.black45,
                          style:
                              TextStyle(color: Colors.black.withOpacity(0.9)),
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              FontAwesomeIcons.key,
                              color: Colors.black45,
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
                            labelStyle:
                                TextStyle(color: Colors.black.withOpacity(0.9)),
                            filled: true,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            fillColor: Color.fromARGB(255, 185, 224, 186)
                                .withOpacity(0.3),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: const BorderSide(
                                  width: 0, style: BorderStyle.none),
                            ),
                          ),
                          obscureText: passswordvisibe,
                        ),
                      ),
                      Container(
                        width: 250,
                        height: 50,
                        margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(90)),
                        child: ElevatedButton(
                          // onPressed
                          onPressed: () async {
                            FocusScope.of(context).unfocus();
                            String? usrename =
                                _userNameTextController.text.trim();
                            String password =
                                _passwordTextController.text.trim();

                            if (usrename.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Username is still empty"),
                                ),
                              );
                            } else if (password.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Password is still empty"),
                                ),
                              );
                            } else {
                              // Getting the document relevent to the user name from database
                              QuerySnapshot snap = await FirebaseFirestore
                                  .instance
                                  .collection("users")
                                  .where('username', isEqualTo: usrename)
                                  .get();
                              try {
                                // Comparing password in the document and user entered password
                                if (password == snap.docs[0]['password']) {
                                  sharedPreferences =
                                      await SharedPreferences.getInstance();

                                  //setting username for shared preferences

                                  sharedPreferences
                                      .setString('username', usrename)
                                      .then(
                                    (_) {
                                      // navigating to the home page
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HomeScreen()));
                                    },
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Password is not correct"),
                                    ),
                                  );
                                }
                              } catch (e) {
                                print(e);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("User name does not exist"),
                                  ),
                                );
                              }
                            }
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith((states) {
                              if (states.contains(MaterialState.pressed)) {
                                return const Color.fromARGB(66, 59, 83, 21);
                              }
                              return const Color.fromARGB(255, 156, 150, 121);
                            }),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                            ),
                          ),
                          child: const Text(
                            'LOGIN',
                            style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 5, 40, 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'Or',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 5, 5, 5)),
                            ),
                          ],
                        ),
                      ),

                      Container(
                        width: 250,
                        height: 50,
                        margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(90)),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUpSelect()));
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith((states) {
                              if (states.contains(MaterialState.pressed)) {
                                return Color.fromARGB(66, 59, 83, 21);
                              }
                              return Color.fromARGB(255, 156, 150, 121);
                            }),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                            ),
                          ),
                          child: const Text(
                            "Register",
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
