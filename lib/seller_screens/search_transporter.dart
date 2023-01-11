import 'dart:math';

import 'package:flutter/material.dart';

import 'package:flutter_polyline_points/flutter_polyline_points.dart';

import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gpsd_project/seller_screens/orderssc.dart';

class SearchTransporter extends StatefulWidget {
  final double sellerlat;
  final double sellerlng;
  final String orderid;
  final String logedusername;
  const SearchTransporter(
      {super.key,
      required this.sellerlat,
      required this.sellerlng,
      required this.orderid,
      required this.logedusername});

  @override
  State<SearchTransporter> createState() => _SearchTransporterState();
}

class _SearchTransporterState extends State<SearchTransporter> {
  GoogleMapController? mapController; //contrller for Google map
  PolylinePoints polylinePoints = PolylinePoints();

  String googleAPiKey = "AIzaSyDaQ1Pz_1Qf22f9ms0tHa_a587Q16H_oUg";

  Set<Marker> markers = Set(); //markers for google map
  Map<PolylineId, Polyline> polylines = {}; //polylines to show direction

  double distance = 0.0;
  double distance1 = 0.0;
  double distance2 = 1000000000;
  late String selectedtransporter;
  late String selectedtransporterid;

  Widget buildtrasporter(Transporter transporter) => SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 350,
              child: Image(
                image: NetworkImage(transporter.vehicleimgurl),
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
                  final docOrder = FirebaseFirestore.instance
                      .collection('Order_Details')
                      .doc(widget.orderid);
                  final doctransporter = FirebaseFirestore.instance
                      .collection('users')
                      .doc(transporter.transporterid);
                  docOrder.update({
                    'transporterselected': true,
                    'transportername': transporter.name,
                    'transporterid': transporter.transporterid,
                    'transporterusername': transporter.transporterusername,
                  });

                  doctransporter.update({
                    'available': false,
                  });

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OrdersScreen(
                              logedusername: widget.logedusername)));
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
                  'Continue',
                  style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 40, 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    transporter.transporterusername,
                    style: TextStyle(color: Color.fromARGB(255, 150, 99, 34)),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  Future<Transporter?> getNearestTransporter() async {
    QuerySnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .where('type', isEqualTo: 'T')
        .where('available', isEqualTo: true)
        .get();

    int numberoftransporters = snap.size;

    for (var i = 0; i < numberoftransporters; i++) {
      double lat1 = await snap.docs[i]['latitude'];
      double lon1 = await snap.docs[i]['longitude'];
      double totalDistance = 0.0;
      LatLng startLocation = LatLng(widget.sellerlat, widget.sellerlng);
      LatLng endLocation = LatLng(lat1, lon1);

      print(startLocation);
      print(endLocation);

      List<LatLng> polylineCoordinates = [];

      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleAPiKey,
        PointLatLng(widget.sellerlat, widget.sellerlng),
        PointLatLng(lat1, lon1),
        travelMode: TravelMode.driving,
      );

      if (result.points.isNotEmpty) {
        result.points.forEach((PointLatLng point) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        });
      } else {
        print(result.errorMessage);
      }
      //polulineCoordinates is the List of longitute and latidtude.

      for (var j = 0; j < polylineCoordinates.length - 1; j++) {
        totalDistance += calculateDistance(
            polylineCoordinates[j].latitude,
            polylineCoordinates[j].longitude,
            polylineCoordinates[j + 1].latitude,
            polylineCoordinates[j + 1].longitude);
      }
      distance = totalDistance;

      //add to the list of poly line coordinates

      distance1 = distance;

      if (distance1 < distance2) {
        distance2 = distance;
        selectedtransporter = snap.docs[i]['username'];
        selectedtransporterid = snap.docs[i]['id'];
        print(distance2);
      }
    }

    final docTransporter = FirebaseFirestore.instance
        .collection('users')
        .doc(selectedtransporterid);
    final snapshot = await docTransporter.get();

    if (snapshot.exists) {
      return Transporter.fromJson(snapshot.data()!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculate Distance in Google Map"),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: FutureBuilder<Transporter?>(
        future: getNearestTransporter(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final transporter = snapshot.data;
            return buildtrasporter(transporter!);
          } else {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
        },
      ),
    );
  }
}

class Transporter {
  final String name;
  final String phoneno;
  final String vehicleimgurl;
  final String transporterusername;
  final String transporterid;

  Transporter({
    required this.name,
    required this.phoneno,
    required this.vehicleimgurl,
    required this.transporterusername,
    required this.transporterid,
  });

  Transporter.fromJson(Map<String, Object?> json)
      : this(
          name: json['name']! as String,
          phoneno: json['phoneno']! as String,
          vehicleimgurl: json['vehicleimgurl']! as String,
          transporterusername: json['username']! as String,
          transporterid: json['id']! as String,
        );
  Map<String, dynamic> toJson() => {
        'name': name,
        'phoneno': phoneno,
        'vehicleimgurl': vehicleimgurl,
        'username': transporterusername,
        'id': transporterid,
      };
}
  // @override
  // void initState() {
  //   getDirections(); //fetch direction polylines from Google API

  //   super.initState();
  // }

  // getDirections() async {
  //   List<LatLng> polylineCoordinates = [];

  //   PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
  //     googleAPiKey,
  //     PointLatLng(startLocation.latitude, startLocation.longitude),
  //     PointLatLng(endLocation.latitude, endLocation.longitude),
  //     travelMode: TravelMode.driving,
  //   );

  //   if (result.points.isNotEmpty) {
  //     result.points.forEach((PointLatLng point) {
  //       polylineCoordinates.add(LatLng(point.latitude, point.longitude));
  //     });
  //   } else {
  //     print(result.errorMessage);
  //   }

  //   //polulineCoordinates is the List of longitute and latidtude.
  //   double totalDistance = 0;
  //   for (var i = 0; i < polylineCoordinates.length - 1; i++) {
  //     totalDistance += calculateDistance(
  //         polylineCoordinates[i].latitude,
  //         polylineCoordinates[i].longitude,
  //         polylineCoordinates[i + 1].latitude,
  //         polylineCoordinates[i + 1].longitude);
  //   }
  //   print(totalDistance);
  //   distance = totalDistance;

  //   //add to the list of poly line coordinates
  //   addPolyLine(polylineCoordinates);
  // }

  // addPolyLine(List<LatLng> polylineCoordinates) {
  //   PolylineId id = PolylineId("poly");
  //   Polyline polyline = Polyline(
  //     polylineId: id,
  //     color: Colors.deepPurpleAccent,
  //     points: polylineCoordinates,
  //     width: 8,
  //   );
  //   polylines[id] = polyline;
  // }

  // late Position _currentPosition;
  // // List<Destination> destinationlist = destinations;

  // // @override
  // // void initState() {
  // //   _getCurrentLocation();
  // //   super.initState();
  // // }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       backgroundColor: Color.fromARGB(255, 141, 170, 137),
  //       //Color.fromARGB(255, 109, 141, 110),
  //       elevation: 10,
  //       title: const Text(
  //         "Search for a transporter",
  //         style: TextStyle(
  //             color: Color.fromARGB(255, 255, 255, 255),
  //             fontSize: 24,
  //             fontWeight: FontWeight.bold),
  //       ),
  //     ),
  //     body: FutureBuilder(
  //         future: getNearestTransporter(),
  //         builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
  //           if (snapshot.hasData) {
  //             final transporter = snapshot.data;
  //             return buildResult(transporter!);

  //             // Container(
  //             //   child: Text(transporter!),
  //             // );
  //           } else {
  //             return const Center(
  //               child: CircularProgressIndicator.adaptive(),
  //             );
  //           }
  //         }),
  //   );
  // }

  // Widget buildResult(String transporter) => SingleChildScrollView(
  //       child: Column(
  //         children: [
  //           Container(
  //             child: Text(transporter),
  //           )
  //         ],
  //       ),
  //     );

  // Future<String> getNearestTransporter() async {
  //   QuerySnapshot snap = await FirebaseFirestore.instance
  //       .collection('users')
  //       .where('type', isEqualTo: 'T')
  //       .get();

  //   int numberoftransporters = snap.size;
  //   late String selectedtransporter;
  //   print(numberoftransporters);

  //   double distance = 10000000.0;

  //   for (var i = 0; i < numberoftransporters; i++) {
  //     double lat1 = snap.docs[i]['latitude'];
  //     double lon1 = snap.docs[i]['longitude'];
  //     print(lat1);

  //     double distance1 = await getDistanceFromLatLonInKm(
  //         lat1, lon1, widget.sellerlat, widget.sellerlng);

  //     if (distance1 < distance) {
  //       distance = distance1;
  //       selectedtransporter = snap.docs[i]['username'];
  //     }
  //   }

  //   return await selectedtransporter;
  // }

  // double getDistanceFromLatLonInKm(lat1, lon1, lat2, lon2) {
  //   var p = 0.017453292519943295;
  //   var a = 0.5 -
  //       cos((lat2 - lat1) * p) / 2 +
  //       cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
  //   print(12742 * asin(sqrt(a)));
  //   return 12742 * asin(sqrt(a));
  //   // var R = 6371; // Radius of the earth in km
  //   // var dLat = deg2rad(lat2 - lat1); // deg2rad below
  //   // var dLon = deg2rad(lon2 - lon1);
  //   // var a = Math.sin(dLat / 2) * Math.sin(dLat / 2) +
  //   //     Math.cos(deg2rad(lat1)) *
  //   //         Math.cos(deg2rad(lat2)) *
  //   //         Math.sin(dLon / 2) *
  //   //         Math.sin(dLon / 2);
  //   // var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
  //   // var d = R * c; // Distance in km
  //   // print(d);
  //   // return d;
  // }

  // double deg2rad(deg) {
  //   return deg * (Math.pi / 180);
  // }


//   // get Current Location
//   _getCurrentLocation() {
//     Geolocator.getCurrentPosition(
//             desiredAccuracy: LocationAccuracy.best,
//             forceAndroidLocationManager: true)
//         .then((Position position) {
//       distanceCalculation(position);
//       setState(() {
//         _currentPosition = position;
//       });
//     }).catchError((e) {
//       print(e);
//     });
//   }

//   distanceCalculation(Position position) {
//     for (var d in destinations) {
//       var km = getDistanceFromLatLonInKm(
//           position.latitude, position.longitude, d.lat, d.lng);
//       // var m = Geolocator.distanceBetween(position.latitude,position.longitude, d.lat,d.lng);
//       // d.distance = m/1000;
//       d.distance = km;
//       destinationlist.add(d);
//       // print(getDistanceFromLatLonInKm(position.latitude,position.longitude, d.lat,d.lng));
//     }
//     setState(() {
//       destinationlist.sort((a, b) {
//         return a.distance.compareTo(b.distance);
//       });
//     });
//   }
// }

// class Destination {
//   double lat;
//   double lng;
//   String name;
//   double distance = 0.0;

//   Destination(
//     this.lat,
//     this.lng,
//     this.name,
//   );
// }

// var destinations = [
//   Destination(37.4274684, -122.1698161, "Standford University"),
//   Destination(37.4083327, -122.0776016, "Taco Bell"),
//   Destination(37.4259071, -122.1095606, "Ramos Park"),
//   Destination(37.8711583, -122.336457, "Bekerly"),
//   Destination(37.7586968, -122.3053474, "Oakland"),
//   Destination(37.4420794, -122.1432758, "Palo Alto"),
//   Destination(37.5206515, -122.064364, "New wark")
// ];
