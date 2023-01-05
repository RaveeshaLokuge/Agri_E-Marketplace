import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart';

class LocationHandling extends StatefulWidget {
  const LocationHandling({super.key});

  @override
  State<LocationHandling> createState() => _LocationHandlingState();
}

class _LocationHandlingState extends State<LocationHandling> {
  late SharedPreferences sharedPreferences;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 141, 170, 137),
        //Color.fromARGB(255, 109, 141, 110),
        elevation: 10,
        title: const Text(
          "Location traking settings",
          style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontSize: 24,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            TextButton(
                onPressed: () async {
                  _listenLocation();
                },
                child: const Text('Enable live location tracking'))
          ],
        ),
      ),
    );
  }

  final loc.Location location = loc.Location();
  StreamSubscription<loc.LocationData>? _locationSubscription;

  @override
  void initState() {
    super.initState();
    _requestPermission();
    location.changeSettings(interval: 300, accuracy: loc.LocationAccuracy.high);
    location.enableBackgroundMode(enable: true);
  }

  Future<void> _listenLocation() async {
    _locationSubscription = location.onLocationChanged.handleError((onError) {
      print(onError);
      _locationSubscription?.cancel();
      setState(() {
        _locationSubscription = null;
      });
    }).listen((loc.LocationData currentlocation) async {
      sharedPreferences = await SharedPreferences.getInstance();

      QuerySnapshot snap = await FirebaseFirestore.instance
          .collection('users')
          .where('username', isEqualTo: sharedPreferences.getString('username'))
          .get();

      final docProduct = FirebaseFirestore.instance
          .collection('users')
          .doc(snap.docs[0]['id']);

      docProduct.update({
        'latitude': currentlocation.latitude,
        'longitude': currentlocation.longitude,
      });
    });
  }

  _requestPermission() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      print('done');
    } else if (status.isDenied) {
      _requestPermission();
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }
}
