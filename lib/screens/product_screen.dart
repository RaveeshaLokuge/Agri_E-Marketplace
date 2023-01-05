import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gpsd_project/buyer_screens/buyer_profile.dart';
import 'package:gpsd_project/screens/add_location_buy.dart';
import 'package:gpsd_project/screens/signin_screen.dart';
import 'package:gpsd_project/seller_screens/seller_profile.dart';
import 'package:gpsd_project/transporter_screens/transporter_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductScreen extends StatefulWidget {
  final String productid;
  const ProductScreen({super.key, required this.productid});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final TextEditingController _searchTextController = TextEditingController();
  late SharedPreferences sharedPreferences;
  int activeIndex = 0;
  late String productdocid;
  List<NetworkImage> images = [];
  CarouselController buttonCarouselController = CarouselController();

  Future<Product?> readProduct() async {
    sharedPreferences = await SharedPreferences.getInstance();
    QuerySnapshot snap = await FirebaseFirestore.instance
        .collection("Product_Data")
        .where('id', isEqualTo: widget.productid)
        .get();
    productdocid = snap.docs[0].id;
    print(snap.docs[0].id);

    final docProduct = FirebaseFirestore.instance
        .collection('Product_Data')
        .doc(snap.docs[0].id);
    final snapshot = await docProduct.get();

    if (snapshot.exists) {
      return Product.fromJson(snapshot.data()!);
    }
  }

  Widget buildProduct(Product product, Size size) => SingleChildScrollView(
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
                          itemCount: product.numberof_img as int,
                          itemBuilder: (context, index, realIndex) {
                            if (product.numberof_img == 1) {
                              images.add(NetworkImage(product.imgUrl1));
                            } else if (product.numberof_img == 2) {
                              images.add(NetworkImage(product.imgUrl1));
                              images.add(NetworkImage(product.imgUrl2!));
                            } else if (product.numberof_img == 3) {
                              images.add(NetworkImage(product.imgUrl1));
                              images.add(NetworkImage(product.imgUrl2!));
                              images.add(NetworkImage(product.imgUrl3!));
                            } else if (product.numberof_img == 4) {
                              images.add(NetworkImage(product.imgUrl1));
                              images.add(NetworkImage(product.imgUrl2!));
                              images.add(NetworkImage(product.imgUrl3!));
                              images.add(NetworkImage(product.imgUrl4!));
                            } else if (product.numberof_img == 5) {
                              images.add(NetworkImage(product.imgUrl1));
                              images.add(NetworkImage(product.imgUrl2!));
                              images.add(NetworkImage(product.imgUrl3!));
                              images.add(NetworkImage(product.imgUrl4!));
                              images.add(NetworkImage(product.imgUrl5!));
                            } else {
                              print('error number of images');
                            }
                            return Container(
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 215, 230, 213),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(23),
                                ),
                              ),
                              height: 250,
                              child: Image(
                                image: images[index],
                                // Image.file(
                                //   File(
                                //     widget.img[index].path,
                                //   ),
                                fit: BoxFit.cover,
                              ),
                            );
                          },
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        AnimatedSmoothIndicator(
                          activeIndex: activeIndex,
                          count: product.numberof_img as int,
                          effect: JumpingDotEffect(
                            dotWidth: 10,
                            dotHeight: 10,
                            dotColor: Colors.cyan.shade900,
                            activeDotColor: Colors.red,
                          ),
                        ),
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
                        ' ${product.title}',
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
                              '${product.weight}kg', /////////////////////////////////////////////////////////////////
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
                              'Rs. ${product.price}', /////////////////////////////////////////////////////////////////
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
                          text: product
                              .province, /////////////////////////////////////////////////////////////////
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
                          text: product
                              .district, /////////////////////////////////////////////////////////////////
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
                          text: product
                              .village, /////////////////////////////////////////////////////////////////
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
                          text: product
                              .description, /////////////////////////////////////////////////////////////////
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SelectLocationBuying(
                                        district: product.district,
                                        productdocid: productdocid,
                                        id1: product.id1,
                                        imgUrl1: product.imgUrl1,
                                        price: product.price,
                                        productname: product.productname,
                                        province: product.province,
                                        sellerusername: product.sellerusername,
                                        title: product.title,
                                        village: product.village,
                                        weight: product.weight,
                                        sellerlat: product.latitude,
                                        sellerlng: product.longitude,
                                        productid: product.id,
                                      )));
                        },
                        child: Shimmer.fromColors(
                          baseColor: Colors.indigo.shade900,
                          highlightColor: Colors.blueGrey.shade600,
                          child: Text(
                            "Select location".toUpperCase(),
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
      );

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // final queryPost = FirebaseFirestore.instance
    //     .collection('Product_Data')
    //     .where('id', isEqualTo: widget.productid)
    //     .withConverter<Product>(
    //         fromFirestore: (snapshot, _) => Product.fromJson(snapshot.data()!),
    //         toFirestore: (user, _) => user.toJson());

    // QuerySnapshot snap = await FirebaseFirestore.instance
    //           .collection("users")
    //           .where('username',
    //               isEqualTo: sharedPreferences.getString('username'))

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 140, 181, 135),
        elevation: 0,
        leading: IconButton(
          onPressed: () async {
            sharedPreferences = await SharedPreferences.getInstance();

            if (sharedPreferences.getString('username') != null) {
              QuerySnapshot snap = await FirebaseFirestore.instance
                  .collection("users")
                  .where('username',
                      isEqualTo: sharedPreferences.getString('username'))
                  .get();

              if (snap.docs[0]['type'] == 'B') {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const BuyerProfile()));
              } else if (snap.docs[0]['type'] == 'S') {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SellerProfile()));
              } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const TransporterProfile()));
              }
            } else {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Loginpage()));
            }
          },
          icon: Icon(Icons.person),
          color: Color.fromARGB(255, 255, 254, 254),
          iconSize: 30,
        ),
        actions: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            width: 345.0,
            child: TextField(
              textAlign: TextAlign.start,
              controller: _searchTextController,
              enableSuggestions: false,
              autocorrect: false,
              cursorColor: Colors.black45,
              style: TextStyle(color: Colors.black.withOpacity(0.9)),
              decoration: InputDecoration(
                suffixIcon: GestureDetector(
                  onTap: () {},
                  child: const Icon(
                    Icons.search_rounded,
                  ),
                ),
                labelText: "Search",
                labelStyle: TextStyle(color: Colors.black.withOpacity(0.6)),
                filled: true,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                fillColor:
                    const Color.fromARGB(255, 255, 255, 255).withOpacity(0.6),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide:
                      const BorderSide(width: 0, style: BorderStyle.none),
                ),
              ),
              keyboardType: true
                  ? TextInputType.visiblePassword
                  : TextInputType.emailAddress,
              obscureText: false,
            ),
          ),
        ],
      ),
      body: FutureBuilder<Product?>(
        future: readProduct(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final product = snapshot.data;
            return buildProduct(product!, size);
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

class Product {
  final String title;
  final String productname;
  final String weight;
  final String price;
  final String province;
  final String district;
  final String village;
  final String description;
  final double latitude;
  final double longitude;
  final int numberof_img;
  final bool Sold;
  final String sellerusername;
  final String id1;
  final String id;
  final String imgUrl1;
  final String? imgUrl2;
  final String? imgUrl3;
  final String? imgUrl4;
  final String? imgUrl5;

  Product({
    required this.title,
    required this.productname,
    required this.weight,
    required this.price,
    required this.province,
    required this.district,
    required this.village,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.numberof_img,
    required this.Sold,
    required this.sellerusername,
    required this.id1,
    required this.id,
    required this.imgUrl1,
    required this.imgUrl2,
    required this.imgUrl3,
    required this.imgUrl4,
    required this.imgUrl5,
  });

  Product.fromJson(Map<String, Object?> json)
      : this(
          title: json['title']! as String,
          productname: json['productname']! as String,
          weight: json['weight']! as String,
          price: json['price']! as String,
          province: json['province']! as String,
          district: json['district']! as String,
          village: json['village']! as String,
          description: json['description']! as String,
          latitude: json['latitude']! as double,
          longitude: json['longitude']! as double,
          numberof_img: json['numberof_img']! as int,
          Sold: json['sold']! as bool,
          sellerusername: json['sellerusername']! as String,
          id1: json['id1']! as String,
          id: json['id']! as String,
          imgUrl1: json['imgUrl1']! as String,
          imgUrl2: json['imgUrl2'] as String?,
          imgUrl3: json['imgUrl3'] as String?,
          imgUrl4: json['imgUrl4'] as String?,
          imgUrl5: json['imgUrl5'] as String?,
        );
  Map<String, dynamic> toJson() => {
        'title': title,
        'productname': productname,
        'weight': weight,
        'price': price,
        'province': province,
        'district': district,
        'village': village,
        'description': description,
        'latitude': latitude,
        'longitude': longitude,
        'numberof_img': numberof_img,
        'Sold': Sold,
        'sellerusername': sellerusername,
        'id1': id1,
        'id': id,
        'imgUrl1': imgUrl1,
        'imgUrl2': imgUrl2,
        'imgUrl3': imgUrl3,
        'imgUrl4': imgUrl4,
        'imgUrl5': imgUrl5,
      };
}
