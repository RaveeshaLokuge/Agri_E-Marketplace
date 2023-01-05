import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:gpsd_project/seller_screens/search_transporter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrdersScreen extends StatefulWidget {
  final String logedusername;
  const OrdersScreen({super.key, required this.logedusername});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  late SharedPreferences sharedPreferences;

  Query<Order> createQuery() {
    FirebaseStorage storage = FirebaseStorage.instance;
    final queryPost = FirebaseFirestore.instance
        .collection('Order_Details')
        .where('sellerusername', isEqualTo: widget.logedusername)
        .withConverter<Order>(
            fromFirestore: (snapshot, _) => Order.fromJson(snapshot.data()!),
            toFirestore: (user, _) => user.toJson());

    // .where('shipped', isEqualTo: false)

    return queryPost;
  }

  @override
  Widget build(BuildContext context) {
    late String text;
    late String text2;

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
              final order = snapshot.data();
              if (order.transporterselected == false) {
                text = 'select tarnsporter';
                text2 = 'select a tarnsporter to proceed';
                //select transporter
              } else {
                if (order.transporteraccepted == false) {
                  text = 'cancel request';
                  text2 = 'waiting for transporters confirmation';
                  //cancel request
                } else {
                  if (order.shipped == false) {
                    text = 'contact transporter';
                    text2 = 'transporter will come';
                    // contact transporter
                  }
                }
              }

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
                                order.title,
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.black54),
                                textScaleFactor: 1.2,
                              ),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.network(
                                      order.imgUrl1,
                                      height: 120,
                                      width: 150,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                      height: 120,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Rs. ${order.price}",
                                          textAlign: TextAlign.center,
                                          style:
                                              TextStyle(color: Colors.black54),
                                          textScaleFactor: 1.2,
                                        ),
                                        Text(
                                          "${order.weight} kg",
                                          textAlign: TextAlign.center,
                                          style:
                                              TextStyle(color: Colors.black54),
                                          textScaleFactor: 1.2,
                                        ),
                                      ],
                                    )
                                  ]),
                              Visibility(
                                maintainSize: true,
                                maintainAnimation: true,
                                maintainState: true,
                                visible: order.shipped,
                                child: Container(
                                  width: 250,
                                  height: 30,
                                  margin:
                                      const EdgeInsets.fromLTRB(0, 5, 0, 15),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(90)),
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      if (order.transporterselected == false) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SearchTransporter(
                                                      sellerlat:
                                                          order.sellerlat,
                                                      sellerlng:
                                                          order.sellerlng,
                                                    )));
                                        //select transporter
                                      } else {
                                        if (order.transporteraccepted ==
                                            false) {
                                          //cancel request
                                        } else {
                                          if (order.shipped == false) {
                                            // contact transporter
                                          }
                                        }
                                      }
                                    },
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
                                    child: Text(
                                      text,
                                      style: const TextStyle(
                                          color: Colors.black87,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                text2,
                                style:
                                    const TextStyle(color: Colors.orangeAccent),
                              )
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
  final bool transporterselected;
  final bool transporteraccepted;
  final bool shipped;
  final bool completed;
  final double sellerlat;
  final double sellerlng;

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
    required this.sellerlat,
    required this.sellerlng,
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
          sellerlat: json['sellerlat']! as double,
          sellerlng: json['sellerlng']! as double,
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
        'sellerlat': sellerlat,
        'sellerlng': sellerlng,
      };
}
