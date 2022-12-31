import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BuyerOrdersScreen extends StatefulWidget {
  final String logedusername;
  const BuyerOrdersScreen({super.key, required this.logedusername});

  @override
  State<BuyerOrdersScreen> createState() => _BuyerOrdersScreenState();
}

class _BuyerOrdersScreenState extends State<BuyerOrdersScreen> {
  late SharedPreferences sharedPreferences;

  Query<Order> createQuery() {
    FirebaseStorage storage = FirebaseStorage.instance;
    final queryPost = FirebaseFirestore.instance
        .collection('Order_Details')
        .where('buyerid', isEqualTo: widget.logedusername)
        .withConverter<Order>(
            fromFirestore: (snapshot, _) => Order.fromJson(snapshot.data()!),
            toFirestore: (user, _) => user.toJson());

    return queryPost;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 141, 170, 137),
          //Color.fromARGB(255, 109, 141, 110),
          elevation: 10,
          title: const Text(
            "Orders",
            style: TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
                fontSize: 24,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: FirestoreListView<Order>(
            query: createQuery(),
            shrinkWrap: true,
            primary: false,
            itemBuilder: (context, snapshot) {
              final product = snapshot.data();

              return Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Column(
                  children: [
                    Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Container(
                          width: 350,
                          height: 250,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 3,
                                  blurRadius: 10,
                                  offset: const Offset(0, 3),
                                )
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            child: Column(children: [
                              Text(
                                product.title,
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.black54),
                                textScaleFactor: 1.2,
                              ),
                              Row(children: [
                                Image.network(
                                  product.imgUrl1,
                                  height: 120,
                                  width: 150,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      product.price,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.black54),
                                      textScaleFactor: 1.2,
                                    ),
                                    Text(
                                      product.weight,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.black54),
                                      textScaleFactor: 1.2,
                                    ),
                                  ],
                                )
                              ]),
                              Container(
                                width: 150,
                                height: 30,
                                margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(90)),
                                child: ElevatedButton(
                                  onPressed: () async {},
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.resolveWith(
                                            (states) {
                                      if (states
                                          .contains(MaterialState.pressed)) {
                                        return const Color.fromARGB(
                                            66, 59, 83, 21);
                                      }
                                      return const Color.fromARGB(
                                          255, 156, 150, 121);
                                    }),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                    ),
                                  ),
                                  child: const Text(
                                    'Orders',
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                ),
                              ),
                              Container(
                                width: 150,
                                height: 30,
                                margin: const EdgeInsets.fromLTRB(10, 5, 0, 5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(90)),
                                child: ElevatedButton(
                                  onPressed: () async {},
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.resolveWith(
                                            (states) {
                                      if (states
                                          .contains(MaterialState.pressed)) {
                                        return Color.fromARGB(66, 59, 83, 21);
                                      }
                                      return Color.fromARGB(255, 156, 150, 121);
                                    }),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                    ),
                                  ),
                                  child: const Text(
                                    'Orders',
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                ),
                              ),
                            ]),
                          ),
                        ))
                  ],
                ),
              );
            }));
  }
}

class Order {
  final String title;
  final String price;
  final String weight;
  final String id1;
  final String id;
  final String imgUrl1;
  bool transporterselected;
  bool transporteraccepted;
  bool shipped;
  bool completed;

  Order({
    required this.title,
    required this.price,
    required this.weight,
    required this.id1,
    required this.id,
    required this.imgUrl1,
    required this.transporterselected,
    required this.transporteraccepted,
    required this.shipped,
    required this.completed,
  });

  Order.fromJson(Map<String, Object?> json)
      : this(
          title: json['title']! as String,
          price: json['price']! as String,
          weight: json['weight']! as String,
          id1: json['id1']! as String,
          id: json['id']! as String,
          imgUrl1: json['imgUrl1']! as String,
          transporterselected: json['transporterselected']! as bool,
          transporteraccepted: json['transporteraccepted']! as bool,
          shipped: json['shipped']! as bool,
          completed: json['completed']! as bool,
        );
  Map<String, dynamic> toJson() => {
        'title': title,
        'price': price,
        'weight': weight,
        'id1': id1,
        'id': id,
        'imgUrl1': imgUrl1,
        'transporterselected': transporterselected,
        'transporteraccepted': transporteraccepted,
        'shipped': shipped,
        'completed': completed,
      };
}
