import 'package:flutter/material.dart';
import 'package:gpsd_project/reusable_widgets/reusable_widgets.dart';
import 'package:gpsd_project/seller_screens/add_locationsc.dart';
import 'dart:core';
import 'dart:io' as io;
import 'package:file/file.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:gpsd_project/seller_screens/product_previewsc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class ProductList extends StatefulWidget {
  String? weight, price, province, district, descreption, title, name, village;
  List<XFile> img = [];
  final double lat;
  final double lng;
  ProductList({
    super.key,
    required this.lat,
    required this.lng,
    required this.weight,
    required this.price,
    required this.province,
    required this.district,
    required this.descreption,
    required this.title,
    required this.name,
    required this.village,
    required this.img,
  });

  @override
  State<ProductList> createState() => _ProductListState();
}

const List<String> _Provincelist = <String>[
  "Western Province",
  "Central Province",
  "Eastern Province",
  "North central Province",
  "North Province",
  "Northwest Province",
  "Sabaragamuwa Province",
  "South Province",
  "Uva Province"
];
List<String> _Districtlist = <String>[];
const List<String> _Districtlist1 = <String>[
  'Colombo District',
  'Gampaha District',
  'Kalutara District',
];
const List<String> _Districtlist2 = <String>[
  'Kandy District',
  'Matale District',
  'Nuwara Eliya',
];
const List<String> _Districtlist3 = <String>[
  'Batticaloa District',
  'Ampara District',
  'Trincomalee District',
];
const List<String> _Districtlist4 = <String>[
  'Anuradhapura District',
  'Polonnaruwa District',
];
const List<String> _Districtlist5 = <String>[
  'Jaffna District',
  'Kilinochchi District',
  'Mannar District',
  'Vavuniya District',
  'Mullaitivu District',
];
const List<String> _Districtlist6 = <String>[
  'Kurunegala District',
  'Puttalam District',
];
const List<String> _Districtlist7 = <String>[
  'Ratnapura District',
  'Kegalle District',
];
const List<String> _Districtlist8 = <String>[
  'Galle District',
  'Matara District',
  'Hambantota District',
];
const List<String> _Districtlist9 = <String>[
  'Badulla District',
  'Moneragala District',
];

class _ProductListState extends State<ProductList> {
  final TextEditingController _titleTextController = TextEditingController();
  final TextEditingController _weightTextController = TextEditingController();
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _villageController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _discriptionController = TextEditingController();
  late double loclat;
  late double loclng;

  @override
  Widget build(BuildContext context) {
    try {
      _titleTextController.text = widget.title!;
      _weightTextController.text = widget.weight!;
      _productNameController.text = widget.name!;
      _villageController.text = widget.village!;
      _priceController.text = widget.price!;
      _discriptionController.text = widget.descreption!;
      images = widget.img;
    } catch (e) {
      print('Values are null');
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 141, 170, 137),
        //Color.fromARGB(255, 109, 141, 110),
        elevation: 10,
        title: const Text(
          "Create an Advertisment",
          style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontSize: 24,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const Align(
              alignment: Alignment.center,
            ),
            const SizedBox(
              height: 105,
            ),
            //Enter title text field
            formTextFieldString(
                "Enter a Title", Icons.title, _titleTextController),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "\nAdd at Least 1 Photo (Max 5)\n",
              style: TextStyle(fontWeight: FontWeight.bold),
            ), ///////////////////////////
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _getPhoto(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _getgrid(),
            ),
            //vegetable name text field
            formTextField("Name of the Vegetable", Icons.crisis_alert,
                _productNameController),
            const SizedBox(
              height: 20,
            ),
            //Weight text field
            formTextField(
                "Veight of the Harvest", Icons.scale, _weightTextController),
            const SizedBox(
              height: 20,
            ),
            //Price text field
            formTextField("Price", Icons.price_change, _priceController),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 40, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Select Your Province',
                    style: TextStyle(
                        color: Color.fromARGB(255, 138, 126, 112),
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _getProvince(),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 15, 40, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Select Your District',
                    style: TextStyle(
                        color: Color.fromARGB(255, 138, 126, 112),
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _getDistrict(),
            ),
            const SizedBox(
              height: 20,
            ),
            //Village text field
            formTextField(
                "Village Name", Icons.location_city, _villageController),
            const SizedBox(
              height: 20,
            ),
            //Discription text field
            formTextField(
                "Discription", Icons.text_fields, _discriptionController),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: 250,
              height: 50,
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(90)),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    loclat = widget.lat;
                    loclng = widget.lng;
                  });
                  print("lattitude is $loclat and lngti $loclng");

                  if (_titleTextController.text.isEmpty) {
                    showDialog(
                        context: context,
                        builder: (context) => const AlertDialog(
                              title: Text(
                                  "You you need to add title for your product "),
                            ));
                  } else if (_productNameController.text.isEmpty) {
                    showDialog(
                        context: context,
                        builder: (context) => const AlertDialog(
                              title: Text(
                                  "You you need to add product name for your product "),
                            ));
                  } else if (_weightTextController.text.isEmpty) {
                    showDialog(
                        context: context,
                        builder: (context) => const AlertDialog(
                              title: Text(
                                  "You you need to add weight of your product "),
                            ));
                  } else if (_priceController.text.isEmpty) {
                    showDialog(
                        context: context,
                        builder: (context) => const AlertDialog(
                              title: Text(
                                  "You you need to add price of your product "),
                            ));
                  } else if (_villageController.text.isEmpty) {
                    showDialog(
                        context: context,
                        builder: (context) => const AlertDialog(
                              title: Text(
                                  "You you need to add village for your product "),
                            ));
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SelectLocation(
                                  descreption: _discriptionController.text,
                                  district: districtType,
                                  img: images,
                                  lat: loclat,
                                  lng: loclng,
                                  name: _productNameController.text,
                                  price: _priceController.text,
                                  province: provinceType,
                                  title: _titleTextController.text,
                                  village: _villageController.text,
                                  weight: _weightTextController.text,
                                )));
                  }
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
                  "Select Location",
                  style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: 250,
              height: 50,
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(90)),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    loclat = widget.lat;
                    loclng = widget.lng;
                  });
                  print("lattitude is $loclat and lngti $loclng");

                  if (_titleTextController.text.isEmpty) {
                    showDialog(
                        context: context,
                        builder: (context) => const AlertDialog(
                              title:
                                  Text("Enter a title for your advertisement"),
                            ));
                  } else if (_productNameController.text.isEmpty) {
                    showDialog(
                        context: context,
                        builder: (context) => const AlertDialog(
                              title: Text(
                                  "Enter a product name for your advertisement"),
                            ));
                  } else if (_weightTextController.text.isEmpty) {
                    showDialog(
                        context: context,
                        builder: (context) => const AlertDialog(
                              title:
                                  Text("Enter a weight for your advertisement"),
                            ));
                  } else if (_priceController.text.isEmpty) {
                    showDialog(
                        context: context,
                        builder: (context) => const AlertDialog(
                              title:
                                  Text("Enter a price for your advertisement"),
                            ));
                  } else if (_villageController.text.isEmpty) {
                    showDialog(
                        context: context,
                        builder: (context) => const AlertDialog(
                              title: Text(
                                  "Enter a village for your advertisement"),
                            ));
                  } else if (images.isEmpty) {
                    showDialog(
                        context: context,
                        builder: (context) => const AlertDialog(
                              title: Text("Enter image for your advertisement"),
                            ));
                  } else if (loclat == 0 && loclng == 0) {
                    showDialog(
                        context: context,
                        builder: (context) => const AlertDialog(
                              title: Text("Select the product location"),
                            ));
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductPreview(
                                  descreption: _discriptionController.text,
                                  district: districtType,
                                  img: images,
                                  lat: loclat,
                                  lng: loclng,
                                  name: _productNameController.text,
                                  price: _priceController.text,
                                  province: provinceType,
                                  title: _titleTextController.text,
                                  village: _villageController.text,
                                  weight: _weightTextController.text,
                                )));
                  }
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
                  "Submit",
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

  Widget _getPhoto() {
    return RawMaterialButton(
      onPressed: () {
        _showModalBottomSheet(context);
      },
      elevation: 2.0,
      fillColor: Colors.white,
      padding: const EdgeInsets.all(40.0),
      shape: const CircleBorder(),
      child: const Icon(
        CupertinoIcons.camera,
        size: 20,
      ),
    );
  }

  Widget _getgrid() {
    validator:
    (des) {
      if (des == null || des.isEmpty) {
        return 'Please add Images about product';
      }
      return null;
    };
    return Container(
      height: 250,
      child: GridView.builder(
        itemCount: images.isEmpty ? 1 : images.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (context, index) => Container(
            decoration: BoxDecoration(
                border: Border.all(
              color: Colors.grey.withOpacity(0.3),
            )),
            child: images.isEmpty
                ? const Icon(
                    CupertinoIcons.camera,
                  )
                : Image.file(
                    io.File(images[index].path),
                    fit: BoxFit.cover,
                  )),
      ),
    );
  }

  String provinceType = _Provincelist.first;

  Widget _getProvince() {
    return Container(
      width: 350,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 185, 224, 186).withOpacity(0.3),
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          dropdownColor: const Color.fromARGB(255, 246, 248, 246),
          value: provinceType,
          iconSize: 36,
          icon: const Icon(
            Icons.arrow_drop_down,
            color: Colors.black,
          ),
          isExpanded: true,
          items: _Provincelist.map(buildMenuItem).toList(),
          onChanged: (value) => setState(() => provinceType = value!),
        ),
      ),
    );
  }

  late String districtType;
  Widget _getDistrict() {
    if (provinceType == "Western Province") {
      _Districtlist = _Districtlist1;
      districtType = _Districtlist.first;
    } else if (provinceType == "Central Province") {
      _Districtlist = _Districtlist2;
      districtType = _Districtlist.first;
    } else if (provinceType == "Eastern Province") {
      _Districtlist = _Districtlist3;
      districtType = _Districtlist.first;
    } else if (provinceType == "North central Province") {
      _Districtlist = _Districtlist4;
      districtType = _Districtlist.first;
    } else if (provinceType == "North Province") {
      _Districtlist = _Districtlist5;
      districtType = _Districtlist.first;
    } else if (provinceType == "Northwest Province") {
      _Districtlist = _Districtlist6;
      districtType = _Districtlist.first;
    } else if (provinceType == "Sabaragamuwa Province") {
      _Districtlist = _Districtlist7;
      districtType = _Districtlist.first;
    } else if (provinceType == "South Province") {
      _Districtlist = _Districtlist8;
      districtType = _Districtlist.first;
    } else {
      _Districtlist = _Districtlist9;
      districtType = _Districtlist.first;
    }

    return Container(
      width: 350,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 185, 224, 186).withOpacity(0.3),
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          dropdownColor: Color.fromARGB(255, 246, 248, 246),
          value: districtType,
          iconSize: 36,
          icon: const Icon(
            Icons.arrow_drop_down,
            color: Colors.black,
          ),
          isExpanded: true,
          items: _Districtlist.map(buildMenuItem).toList(),
          onChanged: (value) => setState(() => districtType = value!),
        ),
      ),
    );
  }

  io.File? singleImage;
  final singlePicker = ImagePicker();
  final multiPicker = ImagePicker();
  List<XFile> images = [];
  late String path;

  void _pickImage() async {
    // multi images
    try {
      final List<XFile>? selectedImages = await multiPicker.pickMultiImage();

      setState(() {
        try {
          if (selectedImages != null) {
            if (images.length == 5) {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: Text("You can add only 5 photos "),
                      ));
              return;
            }
            final io.File PickedFile = io.File(selectedImages[0].path);
            var count = 0;
            var i;

            if (selectedImages.length <= 5) {
              count = (5 - selectedImages.length);
              if (count < 0) {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: Text("You can add only 5 photos "),
                        ));
              } else {
                for (i = selectedImages.length - 1; i >= 0; i--) {
                  images.add(selectedImages[i]);
                }
              }
            } else {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: Text("You exceed the photo limit "),
                      ));
              return;
            }
          }
        } catch (e) {
          print("No Images Selected");
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text("You you need to add images of your product "),
                  ));
        }
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  void SaveImage(path) async {
    SharedPreferences Saveimage = await SharedPreferences.getInstance();
    Saveimage.setString("imagepath", path);
  }

  void _pickImageC() async {
    try {
      final XFile? PickedImage =
          await ImagePicker().pickImage(source: ImageSource.camera);

      Navigator.pop(context);

      setState(() {
        if (PickedImage != null) {
          if (images.length >= 5) {
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      title: Text("You can add only 5 photos "),
                    ));
            return;
          }
          final io.File PickedFile = io.File(PickedImage.path);
          images.add(PickedImage);
        } else {
          print("No Images Selected");
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text("You you need to add images of your product "),
                  ));
        }
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }
  //-----------------------------------------------------------------------------------------------------

  Future _showModalBottomSheet(context) async {
    //popup view
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) => CupertinoActionSheet(
              actions: [
                CupertinoActionSheetAction(
                    child: const Text("Pick Image from Camera",
                        style: TextStyle(
                            color: Color.fromARGB(179, 2, 0, 0),
                            fontWeight: FontWeight.bold)),
                    onPressed: () {
                      _pickImageC();
                    }),
                CupertinoActionSheetAction(
                    child: const Text("Pick Image from Gallery",
                        style: TextStyle(
                            color: Color.fromARGB(179, 0, 0, 0),
                            fontWeight: FontWeight.bold)),
                    onPressed: () {
                      _pickImage();
                    }),
                SizedBox(
                  height: 20,
                ),
              ],
            ));
  }
}

DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 1),
        child: Text(
          item,
          style: TextStyle(fontSize: 20, color: Colors.black.withOpacity(0.8)),
          textAlign: TextAlign.center,
        ),
      ),
    );
