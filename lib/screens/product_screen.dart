import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gpsd_project/buyer_screens/buyer_profile.dart';
import 'package:gpsd_project/screens/signin_screen.dart';
import 'package:gpsd_project/seller_screens/seller_profile.dart';
import 'package:gpsd_project/transporter_screens/transporter_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductScreen extends StatefulWidget {
  final String productid;
  const ProductScreen({super.key, required this.productid});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final TextEditingController _searchTextController = TextEditingController();
  late SharedPreferences sharedPreferences;

  @override
  Widget build(BuildContext context) {
    final queryPost = FirebaseFirestore.instance
        .collection('Product_Data')
        .where('id', isEqualTo: widget.productid)
        .withConverter<Product>(
            fromFirestore: (snapshot, _) => Product.fromJson(snapshot.data()!),
            toFirestore: (user, _) => user.toJson());

    // QuerySnapshot snap = await FirebaseFirestore.instance
    //           .collection("users")
    //           .where('username',
    //               isEqualTo: sharedPreferences.getString('username'))
    //           .get();

    var size = MediaQuery.of(context).size;

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
    );
  }
}

class Product {
  final String title;
  final String price;
  final String weight;
  final String id1;
  final String id;
  final String imgUrl1;

  Product({
    required this.title,
    required this.price,
    required this.weight,
    required this.id1,
    required this.id,
    required this.imgUrl1,
  });

  Product.fromJson(Map<String, Object?> json)
      : this(
          title: json['title']! as String,
          price: json['price']! as String,
          weight: json['weight']! as String,
          id1: json['id1']! as String,
          id: json['id']! as String,
          imgUrl1: json['imgUrl1']! as String,
        );
  Map<String, dynamic> toJson() => {
        'title': title,
        'price': price,
        'weight': weight,
        'id1': id1,
        'id': id,
        'imgUrl1': imgUrl1,
      };
}
