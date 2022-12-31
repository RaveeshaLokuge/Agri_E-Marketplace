import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../screens/product_screen.dart';

SizedBox formTextFieldString(
    String text, IconData icon, TextEditingController controller, int length) {
  return SizedBox(
    width: 350.0,
    child: TextField(
      controller: controller,
      maxLength: length,
      obscureText: false,
      enableSuggestions: true,
      autocorrect: true,
      cursorColor: Colors.black45,
      style: TextStyle(color: Colors.black.withOpacity(0.9)),
      decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          color: Colors.black45,
        ),
        labelText: text,
        labelStyle: TextStyle(color: Colors.black.withOpacity(0.9)),
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        fillColor: const Color.fromARGB(255, 185, 224, 186).withOpacity(0.3),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none),
        ),
      ),
    ),
  );
}

SizedBox formTextFieldint(
    String text, IconData icon, TextEditingController controller) {
  return SizedBox(
    width: 350.0,
    child: TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      obscureText: false,
      enableSuggestions: true,
      autocorrect: true,
      cursorColor: Colors.black45,
      style: TextStyle(color: Colors.black.withOpacity(0.9)),
      decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          color: Colors.black45,
        ),
        labelText: text,
        labelStyle: TextStyle(color: Colors.black.withOpacity(0.9)),
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        fillColor: const Color.fromARGB(255, 185, 224, 186).withOpacity(0.3),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none),
        ),
      ),
    ),
  );
}
// SizedBox formTextFieldString(
//     String text, IconData icon, TextEditingController controller) {
//   return SizedBox(
//     width: 350.0,
//     child: TextField(
//       controller: controller,
//       obscureText: false,
//       enableSuggestions: true,
//       autocorrect: true,
//       cursorColor: Colors.black45,
//       style: TextStyle(color: Colors.black.withOpacity(0.9)),
//       decoration: InputDecoration(
//         prefixIcon: Icon(
//           icon,
//           color: Color.fromARGB(80, 0, 0, 0),
//         ),
//         labelText: text,
//         labelStyle: TextStyle(color: Colors.black.withOpacity(0.6)),
//         filled: true,
//         floatingLabelBehavior: FloatingLabelBehavior.never,
//         fillColor: const Color.fromARGB(255, 185, 224, 186).withOpacity(0.3),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(30.0),
//           borderSide: const BorderSide(width: 0, style: BorderStyle.none),
//         ),
//       ),
//     ),
//   );
// }

SizedBox formTextField(
    String text, IconData icon, TextEditingController controller) {
  return SizedBox(
    width: 350.0,
    child: TextField(
      controller: controller,
      obscureText: false,
      enableSuggestions: true,
      autocorrect: true,
      cursorColor: Colors.black45,
      style: TextStyle(color: Colors.black.withOpacity(0.9)),
      decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          color: Color.fromARGB(80, 0, 0, 0),
        ),
        labelText: text,
        labelStyle: TextStyle(color: Colors.black.withOpacity(0.6)),
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        fillColor: const Color.fromARGB(255, 185, 224, 186).withOpacity(0.3),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none),
        ),
      ),
    ),
  );
}

Container signInSignUpButton(String text, Function onTap) {
  return Container(
    width: 250,
    height: 50,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.pressed)) {
            return Color.fromARGB(66, 59, 83, 21);
          }
          return Color.fromARGB(255, 156, 150, 121);
        }),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
            color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 16),
      ),
    ),
  );
}

// GestureDetector productCard() {
//   return GestureDetector(
//     behavior: HitTestBehavior.translucent,
//     onTap: () => ProductScreen(productid: 'abc',),
//     child: Container(
//       width: 250,
//       padding: const EdgeInsets.all(2.0),
//       decoration: const BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.all(Radius.circular(23)),
//         boxShadow: [
//           BoxShadow(
//             offset: Offset(5, 5),
//             blurRadius: 17,
//             spreadRadius: -15,
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           Container(
//             width: double.infinity,
//             decoration: const BoxDecoration(
//                 color: Color.fromARGB(255, 215, 230, 213),
//                 borderRadius: BorderRadius.all(Radius.circular(23))),
//             height: 250,
//             child: Image.asset("assets/images/onions.jpg"),
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           const Text(
//             "Onions",
//             textAlign: TextAlign.center,
//             style: TextStyle(color: Colors.black54),
//             textScaleFactor: 1.2,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: const [
//               Text(
//                 'price',
//                 textAlign: TextAlign.right,
//                 style: TextStyle(color: Colors.black),
//                 textScaleFactor: 1.15,
//               ),
//               Text(
//                 'weight',
//                 textAlign: TextAlign.right,
//                 style: TextStyle(color: Colors.black),
//                 textScaleFactor: 1.15,
//               ),
//             ],
//           ),
//         ],
//       ),
//     ),
//   );
// }

//login function
// void signIn(String username, String password) async{
//   if(_formKey.currentState!.validate()){
//     await _auth.signInWithEmailAndPassword(email: username, password: password).then((uid) => {
//       Fluttertoast.showToast(msg: "Login Successful"),
//       Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen())),});}}


