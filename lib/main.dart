import 'package:flutter/material.dart';
import 'package:gpsd_project/screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    theme: ThemeData(primaryColor: Colors.green),
    debugShowCheckedModeBanner: false,
    home: HomeScreen(),
  ));
}
