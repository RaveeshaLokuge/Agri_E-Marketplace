import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gpsd_project/seller_screens/product_listsc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectLocation extends StatefulWidget {
  final String weight,
      price,
      province,
      district,
      descreption,
      title,
      name,
      village;
  final double lng, lat;
  List<XFile> img = [];
  SelectLocation({
    super.key,
    required this.weight,
    required this.price,
    required this.province,
    required this.district,
    required this.descreption,
    required this.title,
    required this.name,
    required this.village,
    required this.lat,
    required this.lng,
    required this.img,
  });

  @override
  State<SelectLocation> createState() => _SelectLocationState();
}

class _SelectLocationState extends State<SelectLocation> {
  static const double lat = 6.033214;
  static const double long = 80.216015;
  late GoogleMapController googleMapController;
  Set<Marker> markers = {};
  double loclat = 0.0;
  double loclng = 0.0;
  late SharedPreferences sharedPreferences;
  Position? _currentPosition;

  static const CameraPosition _defaultLocation =
      CameraPosition(target: LatLng(lat, long), zoom: 15);

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<Position> _getCurrentLocation() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) {
      return Future.error('Location services are disabled');
    }
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      return _currentPosition;
    }).catchError((e) {
      debugPrint(e);
    });
    return await Geolocator.getCurrentPosition();
    // bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    // if (!serviceEnabled) {
    //   return Future.error('Location services are disabled');
    // }

    // LocationPermission permission = await Geolocator.checkPermission();
    // if (permission == LocationPermission.denied) {
    //   permission = await Geolocator.requestPermission();
    //   if (permission == LocationPermission.denied) {
    //     return Future.error('Location permissions are denied');
    //   }
    // }
    // if (permission == LocationPermission.deniedForever) {
    //   return Future.error('Location permissions denied, we cannot request');
    // }
    // return await Geolocator.getCurrentPosition();
  }

  // void _liveLocation(){
  //   LocationSettings locationSettings = LocationSettings(
  //     accuracy: LocationAccuracy.high,
  //     distanceFilter: 100,
  //   )
  // }

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
            onMapCreated: (GoogleMapController controller) {
              // here save the value
              googleMapController = controller;
            },
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
                onPressed: () {
                  // navigating to product listing page

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductList(
                                descreption: widget.descreption,
                                district: widget.district,
                                img: widget.img,
                                lat: loclat,
                                lng: loclng,
                                name: widget.name,
                                price: widget.price,
                                province: widget.province,
                                title: widget.title,
                                village: widget.village,
                                weight: widget.weight,
                              )));
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
                    print(e);
                  }
                  setState(() {});

                  _getCurrentLocation().then((value) {
                    setState(() {
                      loclat = value.longitude;
                      loclng = value.longitude;
                    });
                  });
                },
              )
            ]),
          ),
          // Container(
          //   padding: const EdgeInsets.only(top: 150, right: 12),
          //   alignment: Alignment.topRight,
          //   child: Column(children: <Widget>[
          //     FloatingActionButton(
          //       backgroundColor: Colors.green,
          //       child: const Icon(
          //         Icons.add,
          //         size: 30,
          //       ),
          //       onPressed: () {
          //         print('pressed');
          //       },
          //     )
          //   ]),
          // ),
        ],
      ),
    );
  }
}
