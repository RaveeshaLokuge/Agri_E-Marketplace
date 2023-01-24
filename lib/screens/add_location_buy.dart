import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gpsd_project/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:confirm_dialog/confirm_dialog.dart';

class SelectLocationBuying extends StatefulWidget {
  final String sellerusername;
  final String productdocid;
  final String productid;
  final String title;
  final String productname;
  final String weight;
  final String price;
  final String province;
  final String district;
  final String village;
  final String id1;
  final String imgUrl1;
  final double sellerlat;
  final double sellerlng;

  const SelectLocationBuying({
    super.key,
    required this.sellerusername,
    required this.productdocid,
    required this.title,
    required this.productname,
    required this.weight,
    required this.price,
    required this.province,
    required this.district,
    required this.village,
    required this.id1,
    required this.imgUrl1,
    required this.sellerlat,
    required this.sellerlng,
    required this.productid,
  });

  @override
  State<SelectLocationBuying> createState() => _SelectLocationBuyingState();
}

class _SelectLocationBuyingState extends State<SelectLocationBuying> {
  late GoogleMapController googleMapController;
  static const double lat = 6.033214;
  static const double long = 80.216015;
  late SharedPreferences sharedPreferences;
  double loclat = 0.0;
  double loclng = 0.0;
  late String username;

  static const CameraPosition _defaultLocation =
      CameraPosition(target: LatLng(lat, long), zoom: 15);
  Set<Marker> markers = {};

  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions denied, we cannot request');
    }
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 141, 170, 137),
        //Color.fromARGB(255, 109, 141, 110),
        elevation: 10,
        title: const Text(
          "Select Location",
          style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontSize: 24,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            initialCameraPosition: _defaultLocation,
            markers: markers,
            onTap: (LatLng latlng) {
              Marker newMarker = Marker(
                  markerId: MarkerId('gramercy'),
                  position: LatLng(latlng.latitude, latlng.longitude),
                  infoWindow: InfoWindow(title: 'new place'),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueRed));
              markers.add(newMarker);

              setState(() {
                loclat = latlng.latitude;
                loclng = latlng.longitude;
                print(latlng);
              });
              // print(latlng);
            },
            // onMapCreated: (GoogleMapController controller) {
            //   googleMapController = controller;
            // }
          ),
          Container(
            padding: const EdgeInsets.only(top: 600, right: 12),
            alignment: Alignment.topCenter,
            child: Column(children: <Widget>[
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith((states) {
                    if (states.contains(MaterialState.pressed)) {
                      return const Color.fromARGB(66, 59, 83, 21);
                    }
                    return const Color.fromARGB(255, 156, 150, 121);
                  }),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                ),
                child: Text('Add Location'),
                onPressed: () async {
                  try {
                    sharedPreferences = await SharedPreferences.getInstance();
                    username = sharedPreferences.getString('username')!;
                    if (widget.sellerusername == username) {
                      showDialog(
                          context: context,
                          builder: (context) => const AlertDialog(
                                title: Text("You cannot buy your own products"),
                              ));
                    } else {
                      if (loclat == 0.0 || loclng == 0.0) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                                Text("Please select your location to deliver"),
                          ),
                        );
                      } else {
                        if (await confirm(
                          context,
                          title: const Text('Confirm'),
                          content: const Text('Would you like to buy?'),
                          textOK: const Text('Yes'),
                          textCancel: const Text('No'),
                        )) {
                          sharedPreferences =
                              await SharedPreferences.getInstance();
                          username = sharedPreferences.getString('username')!;
                          final order = Order_Details(
                            productid: widget.productid,
                            buyerid: username,
                            sellerusername: widget.sellerusername,
                            buyerlat: loclat,
                            buyerlng: loclng,
                            district: widget.district,
                            id1: widget.id1,
                            imgUrl1: widget.imgUrl1,
                            price: widget.price,
                            productdocid: widget.productdocid,
                            productname: widget.productname,
                            province: widget.province,
                            sellerlat: widget.sellerlat,
                            sellerlng: widget.sellerlng,
                            title: widget.title,
                            village: widget.village,
                            weight: widget.weight,
                          );
                          createOrder(order: order);
                          // navigating to product listing page

                          final docProduct = FirebaseFirestore.instance
                              .collection('Product_Data')
                              .doc(widget.productdocid);

                          docProduct.update({
                            'sold': true,
                          });
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomeScreen(),
                              ));
                        } else {
                          return print('pressedCancel');
                        }
                      }
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content:
                            Text("Please Sign on or Register before buying"),
                      ),
                    );
                  }
                },
              )
            ]),
          ),
          Container(
            padding: const EdgeInsets.only(top: 500, right: 12),
            alignment: Alignment.topRight,
            child: Column(children: <Widget>[
              FloatingActionButton(
                backgroundColor: Colors.green,
                child: const Icon(
                  Icons.location_searching,
                  size: 30,
                ),
                onPressed: () async {
                  try {
                    Position position = await _getCurrentLocation();
                    googleMapController.animateCamera(
                        CameraUpdate.newCameraPosition(CameraPosition(
                            target:
                                LatLng(position.latitude, position.longitude),
                            zoom: 15)));

                    markers.clear();
                  } catch (e) {
                    print('location access naa');
                  }
                  setState(() {});
                },
              )
            ]),
          ),
        ],
      ),
    );
  }

  Future createOrder({required Order_Details order}) async {
    // Reference to document
    final docUser =
        FirebaseFirestore.instance.collection('Order_Details').doc();
    order.id = docUser.id;

    final json = order.toJson();

    await docUser.set(json);
  }
}

class Order_Details {
  String id;
  final String productdocid;
  final String productid;
  final String buyerid;
  final String sellerusername;
  final double buyerlat;
  final double buyerlng;
  final String title;
  final String productname;
  final String weight;
  final String price;
  final String province;
  final String district;
  final String village;
  final String transporterid;
  final double sellerlat;
  final double sellerlng;
  final String id1;
  final String imgUrl1;
  bool transporterselected;
  bool transporteraccepted;
  bool shipped;
  bool completed;

  Order_Details({
    this.id = '',
    this.transporterselected = false,
    this.transporteraccepted = false,
    this.shipped = false,
    this.completed = false,
    this.transporterid = '',
    required this.productdocid,
    required this.productid,
    required this.buyerid,
    required this.sellerusername,
    required this.buyerlat,
    required this.buyerlng,
    required this.title,
    required this.productname,
    required this.weight,
    required this.price,
    required this.province,
    required this.district,
    required this.village,
    required this.sellerlat,
    required this.sellerlng,
    required this.id1,
    required this.imgUrl1,
  });
  Map<String, dynamic> toJson() => {
        'id': id,
        'transporterid': transporterid,
        'transporterselected': transporterselected,
        'transporteraccepted': transporteraccepted,
        'shipped': shipped,
        'completed': completed,
        'productdocid': productdocid,
        'productid': productid,
        'buyerid': buyerid,
        'sellerusername': sellerusername,
        'buyerlat': buyerlat,
        'buyerlng': buyerlng,
        'title': title,
        'productname': productname,
        'weight': weight,
        'price': price,
        'province': province,
        'district': district,
        'village': village,
        'sellerlat': sellerlat,
        'sellerlng': sellerlng,
        'id1': id1,
        'imgUrl1': imgUrl1,
      };
}
