import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gpsd_project/screens/home_screen.dart';

import 'dart:async';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:project_gr8/screens/ProductData.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:uuid/uuid.dart';

class ProductPreview extends StatefulWidget {
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
  ProductPreview({
    Key? key,
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
  }) : super(key: key);

  @override
  State<ProductPreview> createState() => _ProductPreviewState();
}

class _ProductPreviewState extends State<ProductPreview> {
  var uuid = Uuid();
  int activeIndex = 0;
  FirebaseStorage storage = FirebaseStorage.instance;
  double progress = 0;
  CarouselController buttonCarouselController = CarouselController();
  late String id1;
  late String id2;
  late String id3;
  late String id4;
  late String id5;
  late String id6;
  late String id;
  late String seller_username;
  late String imgUrl1;
  late String imgUrl2;
  late String imgUrl3;
  late String imgUrl4;
  late String imgUrl5;
  final bool Sold = false;
  late SharedPreferences sharedPreferences;

  bool isUploaded = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final id1 = uuid.v1();
    final id2 = uuid.v1();
    final id3 = uuid.v1();
    final id4 = uuid.v1();
    final id5 = uuid.v1();
    final id6 = uuid.v1();
    final id = uuid.v1();

    SendData() async {
      sharedPreferences = await SharedPreferences.getInstance();
      seller_username = sharedPreferences.getString('username')!;

      ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
      try {
        int count = widget.img.length;
        print("ok");
        CollectionReference ProductData =
            FirebaseFirestore.instance.collection('Product_Data');

        if (count == 1) {
          await ProductData.add({
            'sellerusername': sharedPreferences.getString('username'),
            'weight': widget.weight,
            'price': widget.price,
            'province': widget.province,
            'district': widget.district,
            'description': widget.descreption,
            'title': widget.title,
            'productname': widget.name,
            'village': widget.village,
            'latitude': widget.lat,
            'longitude': widget.lat,
            'id1': id1,
            'imgUrl1': imgUrl1,
            'id': id,
            'numberof_img': 1,
            'sold': Sold,
          });
        } else if (count == 2) {
          await ProductData.add({
            'sellerusername': sharedPreferences.getString('username'),
            'weight': widget.weight,
            'price': widget.price,
            'province': widget.province,
            'district': widget.district,
            'description': widget.descreption,
            'title': widget.title,
            'productname': widget.name,
            'village': widget.village,
            'latitude': widget.lat,
            'longitude': widget.lat,
            'id1': id1,
            'id2': id2,
            'imgUrl1': imgUrl1,
            'imgUrl2': imgUrl2,
            'id': id,
            'numberof_img': 2,
            'sold': Sold,
          });
        } else if (count == 3) {
          await ProductData.add({
            'sellerusername': sharedPreferences.getString('username'),
            'weight': widget.weight,
            'price': widget.price,
            'province': widget.province,
            'district': widget.district,
            'description': widget.descreption,
            'title': widget.title,
            'productname': widget.name,
            'village': widget.village,
            'latitude': widget.lat,
            'longitude': widget.lat,
            'id1': id1,
            'id2': id2,
            'id3': id3,
            'imgUrl1': imgUrl1,
            'imgUrl2': imgUrl2,
            'imgUrl3': imgUrl3,
            'id': id,
            'numberof_img': 3,
            'sold': Sold,
          });
        } else if (count == 4) {
          await ProductData.add({
            'sellerusername': sharedPreferences.getString('username'),
            'weight': widget.weight,
            'price': widget.price,
            'province': widget.province,
            'district': widget.district,
            'description': widget.descreption,
            'title': widget.title,
            'productname': widget.name,
            'village': widget.village,
            'latitude': widget.lat,
            'longitude': widget.lat,
            'id1': id1,
            'id2': id2,
            'id3': id3,
            'id4': id4,
            'imgUrl1': imgUrl1,
            'imgUrl2': imgUrl2,
            'imgUrl3': imgUrl3,
            'imgUrl4': imgUrl4,
            'id': id,
            'numberof_img': 4,
            'sold': Sold,
          });
        } else if (count == 5) {
          await ProductData.add({
            'sellerusername': sharedPreferences.getString('username'),
            'weight': widget.weight,
            'price': widget.price,
            'province': widget.province,
            'district': widget.district,
            'description': widget.descreption,
            'title': widget.title,
            'productname': widget.name,
            'village': widget.village,
            'latitude': widget.lat,
            'longitude': widget.lat,
            'id1': id1,
            'id2': id2,
            'id3': id3,
            'id4': id4,
            'id5': id5,
            'imgUrl1': imgUrl1,
            'imgUrl2': imgUrl2,
            'imgUrl3': imgUrl3,
            'imgUrl4': imgUrl4,
            'imgUrl5': imgUrl5,
            'id': id,
            'numberof_img': 5,
            'sold': Sold,
          });
        } else {
          print('image id upload fail');
          await ProductData.add({
            'sellerusername': sharedPreferences.getString('username'),
            'weight': widget.weight,
            'price': widget.price,
            'province': widget.province,
            'district': widget.district,
            'description': widget.descreption,
            'title': widget.title,
            'productname': widget.name,
            'village': widget.village,
            'latitude': widget.lat,
            'longitude': widget.lat,
            'id': id,
            'sold': Sold,
          });
        }

        return 'success';
      } catch (e) {
        print("Send data error: " + e.toString());
        return 'Error adding product data';
      }
    }

    Future sendImg() async {
      var count = widget.img.length;
      isUploaded = true;

      try {
        FirebaseStorage storage = FirebaseStorage.instance;
        if (count == 0) {
          print('no images to upload');
          // try {
          //   var file;
          //   file = File(widget.img[0].path);
          //   await storage.ref().child('Productdata/$id1').putFile(file);
          //   imgUrl1 =
          //       await storage.ref().child('Productdata/$id1').getDownloadURL();
          //   print("upload image");
          //   print("number of image 1");
          //   SendData();
          // } catch (e) {
          //   print('error');
          // }
        } else if (count == 1) {
          try {
            var file;
            file = File(widget.img[0].path);
            await storage.ref().child('Productdata/$id1').putFile(file);
            imgUrl1 =
                await storage.ref().child('Productdata/$id1').getDownloadURL();
            print("number of image 1");
            SendData();
          } catch (e) {
            print('error');
          }

          // var file2;
          // file2 = File(widget.img[1].path);
          // storage.ref().child('Productdata/$id2').putFile(file2);
          // print("upload image");
          // print("number of image 2");
        } else if (count == 2) {
          try {
            var file;
            file = File(widget.img[0].path);
            await storage.ref().child('Productdata/$id1').putFile(file);
            imgUrl1 =
                await storage.ref().child('Productdata/$id1').getDownloadURL();
          } catch (e) {
            print('error');
          }

          try {
            var file2;
            file2 = File(widget.img[1].path);
            await storage.ref().child('Productdata/$id2').putFile(file2);
            imgUrl2 =
                await storage.ref().child('Productdata/$id2').getDownloadURL();
            print("number of image 2");
            SendData();
          } catch (e) {
            print('error');
          }

          // var file2;
          // file2 = File(widget.img[1].path);
          // storage.ref().child('Productdata/$id2').putFile(file2);
          // print("upload image");
          // print("number of image 2");

          // var file3;
          // file3 = File(widget.img[2].path);
          // storage.ref().child('Productdata/$id3').putFile(file3);
          // print("upload image");
          // print("number of image 3");
        } else if (count == 3) {
          try {
            var file;
            file = File(widget.img[0].path);
            await storage.ref().child('Productdata/$id1').putFile(file);
            imgUrl1 =
                await storage.ref().child('Productdata/$id1').getDownloadURL();
          } catch (e) {
            print('error');
          }

          try {
            var file2;
            file2 = File(widget.img[1].path);
            await storage.ref().child('Productdata/$id2').putFile(file2);
            imgUrl2 =
                await storage.ref().child('Productdata/$id2').getDownloadURL();
          } catch (e) {
            print('error');
          }

          try {
            var file3;
            file3 = File(widget.img[2].path);
            await storage.ref().child('Productdata/$id3').putFile(file3);
            imgUrl3 =
                await storage.ref().child('Productdata/$id3').getDownloadURL();
            print("number of image 3");
            SendData();
          } catch (e) {
            print('error');
          }

          // var file;
          // file = File(widget.img[0].path);
          // storage.ref().child('Productdata/$id1').putFile(file);
          // print("upload image");
          // print("number of image 1");

          // var file2;
          // file2 = File(widget.img[1].path);
          // storage.ref().child('Productdata/$id2').putFile(file2);
          // print("upload image");
          // print("number of image 2");

          // var file3;
          // file3 = File(widget.img[2].path);
          // storage.ref().child('Productdata/$id3').putFile(file3);
          // print("upload image");
          // print("number of image 3");

          // var file4;
          // file4 = File(widget.img[3].path);
          // storage.ref().child('Productdata/$id4').putFile(file4);
          // print("upload image");
          // print("number of image 4");
        } else if (count == 4) {
          try {
            var file;
            file = File(widget.img[0].path);
            await storage.ref().child('Productdata/$id1').putFile(file);
            imgUrl1 =
                await storage.ref().child('Productdata/$id1').getDownloadURL();
          } catch (e) {
            print('error');
          }

          try {
            var file2;
            file2 = File(widget.img[1].path);
            await storage.ref().child('Productdata/$id2').putFile(file2);
            imgUrl2 =
                await storage.ref().child('Productdata/$id2').getDownloadURL();
          } catch (e) {
            print('error');
          }

          try {
            var file3;
            file3 = File(widget.img[2].path);
            await storage.ref().child('Productdata/$id3').putFile(file3);
            imgUrl3 =
                await storage.ref().child('Productdata/$id3').getDownloadURL();
          } catch (e) {
            print('error');
          }

          try {
            var file4;
            file4 = File(widget.img[3].path);
            await storage.ref().child('Productdata/$id4').putFile(file4);
            imgUrl4 =
                await storage.ref().child('Productdata/$id4').getDownloadURL();
            print("number of image 4");
            SendData();
          } catch (e) {
            print('error');
          }
          // var file;
          // file = File(widget.img[0].path);
          // storage.ref().child('Productdata/$id1').putFile(file);
          // print("upload image");
          // print("number of image 1");

          // var file2;
          // file2 = File(widget.img[1].path);
          // storage.ref().child('Productdata/$id2').putFile(file2);
          // print("upload image");
          // print("number of image 2");

          // var file3;
          // file3 = File(widget.img[2].path);
          // storage.ref().child('Productdata/$id3').putFile(file3);
          // print("upload image");
          // print("number of image 3");

          // var file4;
          // file4 = File(widget.img[3].path);
          // storage.ref().child('Productdata/$id4').putFile(file4);
          // print("upload image");
          // print("number of image 4");

          // var file5;
          // file5 = File(widget.img[4].path);
          // storage.ref().child('Productdata/$id5').putFile(file5);
          // print("upload image");
          // print("number of image 5");
        } else if (count == 5) {
          try {
            var file;
            file = File(widget.img[0].path);
            await storage.ref().child('Productdata/$id1').putFile(file);
            imgUrl1 =
                await storage.ref().child('Productdata/$id1').getDownloadURL();
          } catch (e) {
            print('error');
          }

          try {
            var file2;
            file2 = File(widget.img[1].path);
            await storage.ref().child('Productdata/$id2').putFile(file2);
            imgUrl2 =
                await storage.ref().child('Productdata/$id2').getDownloadURL();
          } catch (e) {
            print('error');
          }

          try {
            var file3;
            file3 = File(widget.img[2].path);
            await storage.ref().child('Productdata/$id3').putFile(file3);
            imgUrl3 =
                await storage.ref().child('Productdata/$id3').getDownloadURL();
          } catch (e) {
            print('error');
          }

          try {
            var file4;
            file4 = File(widget.img[3].path);
            await storage.ref().child('Productdata/$id4').putFile(file4);
            imgUrl4 =
                await storage.ref().child('Productdata/$id4').getDownloadURL();
          } catch (e) {
            print('error');
          }

          try {
            var file5;
            file5 = File(widget.img[4].path);
            await storage.ref().child('Productdata/$id5').putFile(file5);
            imgUrl5 =
                await storage.ref().child('Productdata/$id5').getDownloadURL();
            print("number of image 5");
            SendData();
          } catch (e) {
            print('error');
          }

          // var file;
          // file = File(widget.img[0].path);
          // storage.ref().child('Productdata/$id1').putFile(file);
          // print("upload image");
          // print("number of image 1");

          // var file2;
          // file2 = File(widget.img[1].path);
          // storage.ref().child('Productdata/$id2').putFile(file2);
          // print("upload image");
          // print("number of image 2");

          // var file3;
          // file3 = File(widget.img[2].path);
          // storage.ref().child('Productdata/$id3').putFile(file3);
          // print("upload image");
          // print("number of image 3");

          // var file4;
          // file4 = File(widget.img[3].path);
          // storage.ref().child('Productdata/$id4').putFile(file4);
          // print("upload image");
          // print("number of image 4");

          // var file5;
          // file5 = File(widget.img[4].path);
          // storage.ref().child('Productdata/$id5').putFile(file5);
          // print("upload image");
          // print("number of image 5");

          // var file6;
          // file6 = File(widget.img[5].path);
          // storage.ref().child('Productdata/$id6').putFile(file6);
          // print("upload image");
          // print("number of image 6");
        }
      } catch (e) {
        print("Send photo error: " + e.toString());
        // return 'Error adding images';
      }
    }

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 120, 255, 154),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 140, 181, 135),
        title: const Text("Preview"),
      ),
      body: SingleChildScrollView(
        //my add
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: [
                Container(
                    height: size.height * .35,
                    width: size.height * 1,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 120, 255, 154),
                    ),

                    //image display
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        CarouselSlider.builder(
                          carouselController: buttonCarouselController,
                          options: CarouselOptions(
                            //aspectRatio: 16 / 9,
                            enableInfiniteScroll: false,
                            viewportFraction: 0.9,
                            autoPlay: true,
                            autoPlayInterval: Duration(seconds: 3),
                            autoPlayAnimationDuration:
                                Duration(milliseconds: 800),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            // height: 400,
                            onPageChanged: (index, reason) =>
                                setState(() => activeIndex = index),

                            ////////////////////////////////////////////////////////////////////////////////////////////////////////////
                          ),
                          itemCount: widget.img.length,
                          itemBuilder: (context, index, realIndex) {
                            return buildImage(index);
                          },
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        buildIndicator(),
                      ],
                    )),
              ],
            ),
            Container(
              height: 500,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // title
                  Padding(
                    padding: EdgeInsets.only(top: 20.0, bottom: 0.5),
                    child: Container(
                      width: 350,
                      alignment: Alignment.center,
                      child: Text(
                        ' ${widget.title}',
                        style: Theme.of(context)
                            .textTheme
                            .headline4!
                            .copyWith(color: Color.fromARGB(255, 114, 94, 94)),
                      ),
                    ),
                  ),

                  Container(
                    width: 330,
                    child: RichText(
                      text: TextSpan(children: [
                        const TextSpan(
                            text: "Weight: ",
                            style: TextStyle(
                                fontSize: 20,
                                color: Color.fromARGB(255, 54, 75, 50),
                                fontWeight: FontWeight.bold)),
                        TextSpan(
                          text:
                              '${widget.weight}kg', /////////////////////////////////////////////////////////////////
                          style: TextStyle(color: Colors.black, fontSize: 17),
                        ),
                      ]),
                    ),
                  ),
                  const SizedBox(
                    width: double.infinity,
                    height: 10,
                  ),

                  Container(
                    width: 330,
                    child: RichText(
                      text: TextSpan(children: [
                        const TextSpan(
                            text: "Price: ",
                            style: TextStyle(
                                fontSize: 20,
                                color: Color.fromARGB(255, 54, 75, 50),
                                fontWeight: FontWeight.bold)),
                        TextSpan(
                          text:
                              'Rs. ${widget.price}', /////////////////////////////////////////////////////////////////
                          style: TextStyle(color: Colors.black, fontSize: 17),
                        ),
                      ]),
                    ),
                  ),
                  const SizedBox(
                    width: double.infinity,
                    height: 10,
                  ),

                  Container(
                    width: 330,
                    child: RichText(
                      text: TextSpan(children: [
                        const TextSpan(
                            text: "Province: ",
                            style: TextStyle(
                                fontSize: 20,
                                color: Color.fromARGB(255, 54, 75, 50),
                                fontWeight: FontWeight.bold)),
                        TextSpan(
                          text:
                              '${widget.province}', /////////////////////////////////////////////////////////////////
                          style: TextStyle(color: Colors.black, fontSize: 17),
                        ),
                      ]),
                    ),
                  ),
                  const SizedBox(
                    width: double.infinity,
                    height: 10,
                  ),
                  Container(
                    width: 330,
                    child: RichText(
                      text: TextSpan(children: [
                        const TextSpan(
                            text: "District: ",
                            style: TextStyle(
                                fontSize: 20,
                                color: Color.fromARGB(255, 54, 75, 50),
                                fontWeight: FontWeight.bold)),
                        TextSpan(
                          text:
                              '${widget.district}', /////////////////////////////////////////////////////////////////
                          style: TextStyle(color: Colors.black, fontSize: 17),
                        ),
                      ]),
                    ),
                  ),
                  const SizedBox(
                    width: double.infinity,
                    height: 10,
                  ),
                  Container(
                    width: 330,
                    child: RichText(
                      text: TextSpan(children: [
                        const TextSpan(
                            text: "Village: ",
                            style: TextStyle(
                                fontSize: 20,
                                color: Color.fromARGB(255, 54, 75, 50),
                                fontWeight: FontWeight.bold)),
                        TextSpan(
                          text:
                              '${widget.village}', /////////////////////////////////////////////////////////////////
                          style: TextStyle(color: Colors.black, fontSize: 17),
                        ),
                      ]),
                    ),
                  ),

                  SizedBox(
                    width: double.infinity,
                    height: 10,
                  ),
                  Container(
                    width: 330,
                    child: RichText(
                      text: TextSpan(children: [
                        const TextSpan(
                            text: "Discription: ",
                            style: TextStyle(
                                fontSize: 20,
                                color: Color.fromARGB(255, 54, 75, 50),
                                fontWeight: FontWeight.bold)),
                        TextSpan(
                          text:
                              '${widget.descreption}', /////////////////////////////////////////////////////////////////
                          style: TextStyle(color: Colors.black, fontSize: 17),
                        ),
                      ]),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 40,
                  ),

                  SizedBox(
                    height: 52,
                    width: 300,
                    child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.resolveWith((states) {
                            if (states.contains(MaterialState.pressed)) {
                              return const Color.fromARGB(66, 59, 83, 21);
                            }
                            return const Color.fromARGB(255, 156, 150, 121);
                          }),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                          ),
                        ),
                        onPressed: () async {
                          // SendDataToDatabase(kgs:widget.kgs);
                          sendImg();

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomeScreen()));
                        },
                        child: Shimmer.fromColors(
                          baseColor: Colors.indigo.shade900,
                          highlightColor: Colors.blueGrey.shade600,
                          child: Text(
                            "Upload".toUpperCase(),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17),
                          ),
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      /////////
      //
    );

    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  }

  Widget buildImage(int index) => Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 215, 230, 213),
          borderRadius: BorderRadius.all(
            Radius.circular(23),
          ),
        ),
        height: 250,
        child: Image.file(
          File(
            widget.img[index].path,
          ),
          fit: BoxFit.cover,
        ),
      );

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: widget.img.length,
        effect: JumpingDotEffect(
          dotWidth: 10,
          dotHeight: 10,
          dotColor: Colors.cyan.shade900,
          activeDotColor: Colors.red,
        ),
      );

  void showSnackBarText(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text)),
    );
  }
}
