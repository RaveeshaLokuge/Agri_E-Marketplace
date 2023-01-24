import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:gpsd_project/transporter_screens/navigation_screen.dart';

class TransporterRequests extends StatefulWidget {
  final String logedusername;
  const TransporterRequests({super.key, required this.logedusername});

  @override
  State<TransporterRequests> createState() => _TransporterRequestsState();
}

class _TransporterRequestsState extends State<TransporterRequests> {
  bool isLoading = false;
  bool isAccepted = false;

  Query<Order> transporterOrderQuery() {
    FirebaseStorage storage = FirebaseStorage.instance;
    final queryPost = FirebaseFirestore.instance
        .collection('Order_Details')
        .where('transportername', isEqualTo: widget.logedusername)
        .withConverter<Order>(
            fromFirestore: (snapshot, _) => Order.fromJson(snapshot.data()!),
            toFirestore: (user, _) => user.toJson());

    // .where('shipped', isEqualTo: false)
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
          query: transporterOrderQuery(),
          shrinkWrap: true,
          primary: false,
          itemBuilder: (context, snapshot) {
            late String buttontext;
            final order = snapshot.data();
            if (order.transporteraccepted == false) {
              buttontext = 'Accept';
              //accepting the order
            } else {
              if (order.shipped == false) {
                buttontext = 'Mark as picked up';
                //navigating to seller
              } else {
                buttontext = 'Mark as completed';
                //navigate to buyer

              }
            }

            return Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Column(children: [
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Text(
                                  //   "Rs. ${order.price}",
                                  //   textAlign: TextAlign.center,
                                  //   style:
                                  //       TextStyle(color: Colors.black54),
                                  //   textScaleFactor: 1.2,
                                  // ),
                                  Text(
                                    "${order.weight} kg",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.black54),
                                    textScaleFactor: 1.2,
                                  ),
                                ],
                              )
                            ],
                          ),
                          Visibility(
                            maintainSize: true,
                            maintainAnimation: true,
                            maintainState: true,
                            visible: !order.completed,
                            child: Container(
                              width: 250,
                              height: 30,
                              margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(90)),
                              child: ElevatedButton(
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
                                child: Text(buttontext),
                                onPressed: () async {
                                  final docOrder = FirebaseFirestore.instance
                                      .collection('Order_Details')
                                      .doc(order.id);
                                  if (order.transporteraccepted == false) {
                                    docOrder.update({
                                      'transporteraccepted': true,
                                    });
                                    setState(() {});
                                    //accepting the order
                                  } else {
                                    if (order.shipped == false) {
                                      docOrder.update({
                                        'shipped': true,
                                      });
                                      setState(() {});
                                      //navigating to seller
                                    } else {
                                      if (order.shipped == false) {
                                        docOrder.update({
                                          'completed': true,
                                        });
                                        setState(() {});
                                        //navigate to buyer
                                      }
                                    }
                                  }
                                  //             QuerySnapshot snap = await FirebaseFirestore.instance
                                  // .collection("users")
                                  // .where('username',
                                  //     isEqualTo: widget.logedusername)
                                  // .get();
                                  // if (order.transporteraccepted) {
                                  //   Navigator.of(context).pushReplacement(
                                  //     MaterialPageRoute(
                                  //         builder: (context) =>
                                  //             NavigationScreen(order.sellerlat,
                                  //                 order.sellerlng)),
                                  //   );
                                  // } else {
                                  //   final docOrder = FirebaseFirestore.instance
                                  //       .collection('Order_Details')
                                  //       .doc(order.id);

                                  //   docOrder.update({
                                  //     'transporteraccepted': true,
                                  //   });
                                  //   setState(() {});
                                  // }
                                },
                              ),
                            ),
                          ),

                          // second button//////////
                          Visibility(
                            maintainSize: true,
                            maintainAnimation: true,
                            maintainState: true,
                            visible: !order.completed,
                            child: Container(
                              width: 250,
                              height: 30,
                              margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(90)),
                              child: ElevatedButton(
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
                                child: order.transporteraccepted
                                    ? Text('Get Directions')
                                    : Text('Cancel'),
                                onPressed: () async {
                                  if (order.transporteraccepted == false) {
                                    final docTransporter = FirebaseFirestore
                                        .instance
                                        .collection('users')
                                        .doc(order.transporterid);

                                    docTransporter.update({
                                      'available': true,
                                    });

                                    final docOrder = FirebaseFirestore.instance
                                        .collection('Order_Details')
                                        .doc(order.id);

                                    docOrder.update({
                                      'transporterselected': false,
                                      'transportername': '',
                                      'transporterid': '',
                                      'transporterusername': '',
                                    });
                                    setState(() {});
                                    //canceling the order
                                  } else {
                                    if (order.shipped == false) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  NavigationScreen(
                                                      order.sellerlat,
                                                      order.sellerlng)));
                                      //navigating to seller
                                    } else {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  NavigationScreen(
                                                      order.buyerlat,
                                                      order.buyerlng)));
                                      //navigate to buyer
                                    }
                                  }

                                  // //             QuerySnapshot snap = await FirebaseFirestore.instance
                                  // // .collection("users")
                                  // // .where('username',
                                  // //     isEqualTo: widget.logedusername)
                                  // // .get();
                                  // if (order.transporteraccepted) {
                                  //   Navigator.of(context).pushReplacement(
                                  //     MaterialPageRoute(
                                  //         builder: (context) => NavigationScreen(
                                  //             order.sellerlat, order.sellerlng)),
                                  //   );
                                  // } else {
                                  //   final docOrder = FirebaseFirestore.instance
                                  //       .collection('Order_Details')
                                  //       .doc(order.id);

                                  //   docOrder.update({
                                  //     'transporteraccepted': true,
                                  //   });
                                  //   setState(() {});
                                  // }
                                },
                              ),
                            ),
                          ),
                        ]),
                      ),
                    ),
                  ),
                ]));
          }),
    );
  }

  // Widget buildButton() => ElevatedButton(
  //       style: ButtonStyle(
  //         backgroundColor: MaterialStateProperty.resolveWith((states) {
  //           if (states.contains(MaterialState.pressed)) {
  //             return Color.fromARGB(66, 59, 83, 21);
  //           }
  //           return Color.fromARGB(255, 156, 150, 121);
  //         }),
  //         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
  //           RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
  //         ),
  //       ),
  //       child: isLoading
  //           ? CircularProgressIndicator(
  //               color: Colors.white,
  //             )
  //           : Text('Accept'),
  //       onPressed: () async {
  //         if (isLoading) return;
  //         setState(
  //           () => isLoading = true,
  //         );
  //         await Future.delayed(Duration(seconds: 2));
  //         setState(
  //           () => isAccepted = true,
  //         );
  //       },
  //     );

  // Widget buildAcceptedButton() => ElevatedButton(
  //       style: ButtonStyle(
  //         backgroundColor: MaterialStateProperty.resolveWith((states) {
  //           if (states.contains(MaterialState.pressed)) {
  //             return Color.fromARGB(66, 59, 83, 21);
  //           }
  //           return Color.fromARGB(255, 156, 150, 121);
  //         }),
  //         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
  //           RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
  //         ),
  //       ),
  //       child: const Text('Get Directions'),
  //       onPressed: () {
  //         Navigator.of(context).pushReplacement(
  //                 MaterialPageRoute(
  //                   builder: (context) => NavigationScreen(, lng)
  //                 ),
  //               );
  //       },
  //     );
}

class Order {
  final String title;
  final String weight;
  final String id1;
  final String id;
  final String transporterid;
  final String imgUrl1;
  final double sellerlat;
  final double sellerlng;
  final double buyerlat;
  final double buyerlng;
  final bool transporteraccepted;
  final bool shipped;
  final bool completed;

  Order({
    required this.title,
    required this.weight,
    required this.id1,
    required this.id,
    required this.transporterid,
    required this.imgUrl1,
    required this.sellerlat,
    required this.sellerlng,
    required this.buyerlat,
    required this.buyerlng,
    required this.transporteraccepted,
    required this.completed,
    required this.shipped,
  });

  Order.fromJson(Map<String, Object?> json)
      : this(
          title: json['title']! as String,
          weight: json['weight']! as String,
          id1: json['id1']! as String,
          id: json['id']! as String,
          transporterid: json['transporterid']! as String,
          imgUrl1: json['imgUrl1']! as String,
          sellerlat: json['sellerlat']! as double,
          sellerlng: json['sellerlng']! as double,
          buyerlat: json['buyerlat']! as double,
          buyerlng: json['buyerlng']! as double,
          transporteraccepted: json['transporteraccepted']! as bool,
          shipped: json['shipped']! as bool,
          completed: json['completed']! as bool,
        );
  Map<String, dynamic> toJson() => {
        'title': title,
        'weight': weight,
        'id1': id1,
        'id': id,
        'transporterid': transporterid,
        'imgUrl1': imgUrl1,
        'sellerlat': sellerlat,
        'sellerlng': sellerlng,
        'buyerlat': sellerlat,
        'buyerlng': buyerlng,
        'transporteraccepted': transporteraccepted,
        'shipped': shipped,
        'completed': completed,
      };
}
