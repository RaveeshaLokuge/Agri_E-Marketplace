import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:gpsd_project/buyer_screens/buyer_profile.dart';
import 'package:gpsd_project/screens/product_screen.dart';
import 'package:gpsd_project/screens/signin_screen.dart';
import 'package:gpsd_project/seller_screens/seller_profile.dart';
import 'package:gpsd_project/transporter_screens/transporter_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchResults extends StatefulWidget {
  final String searchtext;
  const SearchResults({super.key, required this.searchtext});

  @override
  State<SearchResults> createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  final TextEditingController _searchTextController = TextEditingController();
  // bool userAvailable = false;
  late SharedPreferences sharedPreferences;

  Query<Product> CreateQuery() {
    FirebaseStorage storage = FirebaseStorage.instance;
    final queryPost = FirebaseFirestore.instance
        .collection('Product_Data')
        .where('sold', isEqualTo: false)
        .where('splittitle', arrayContains: widget.searchtext)
        .withConverter<Product>(
            fromFirestore: (snapshot, _) => Product.fromJson(snapshot.data()!),
            toFirestore: (user, _) => user.toJson());

    return queryPost;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    // String urlImage = '';
    // Future<String> getImage(String imgName) async {
    //   try {
    //     print(imgName);
    //     FirebaseStorage storage = FirebaseStorage.instance;

    //     var urlRef = await storage
    //         .ref()
    //         .child('Productdata/$imgName')
    //         .getDownloadURL()
    //         .onError((error, stackTrace) =>
    //             'https://cdn.britannica.com/17196817-050-6A15DAC3/vegetables.jpg');
    //     return urlRef;
    //   } catch (error) {
    //     print('image cannot find');
    //     return ('https://cdn.britannica.com/17196817-050-6A15DAC3/vegetables.jpg');
    //   }
    // }

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
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SearchResults(
                                  searchtext: _searchTextController.text,
                                )));
                  },
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
      body: FirestoreListView<Product>(
          query: CreateQuery(),
          shrinkWrap: true,
          primary: false,
          itemBuilder: (context, snapshot) {
            final product = snapshot.data();

            return Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductScreen(
                                productid: product.id,
                              )));
                },
                child: Container(
                  width: 250,
                  padding: const EdgeInsets.all(2.0),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(23)),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(5, 5),
                        blurRadius: 17,
                        spreadRadius: -15,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 215, 230, 213),
                            borderRadius: BorderRadius.all(
                              Radius.circular(23),
                            ),
                          ),
                          height: 250,
                          child: Image(
                            image: NetworkImage(product.imgUrl1),
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        product.title,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black54),
                        textScaleFactor: 1.2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'Rs. ${product.price}',
                            textAlign: TextAlign.right,
                            style: TextStyle(color: Colors.black),
                            textScaleFactor: 1.15,
                          ),
                          Text(
                            '${product.weight} kg',
                            textAlign: TextAlign.right,
                            style: TextStyle(color: Colors.black),
                            textScaleFactor: 1.15,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
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
