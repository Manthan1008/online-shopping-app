import 'dart:convert';
import 'package:ecommerce_app/getxfile.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class add_cart extends StatefulWidget {
  add_cart({super.key});

  @override
  State<add_cart> createState() => _add_cartState();
}

class _add_cartState extends State<add_cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("MY CART",
            style: TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.bold)),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: cartgetdata(),
              builder: (context, snapshot) {
                // print('!!!!!!!!!!!!! ${snapshot.connectionState}');
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error'),
                  );
                } else {
                  final cartdata = snapshot.data!['cartdata'];
                  print('!!!!!!!!!!!!! ${cartdata}');
                  return ListView.builder(
                    itemCount: cartdata.length,
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Slidable(
                              key: const ValueKey(0),
                              startActionPane: ActionPane(
                                motion: ScrollMotion(),
                                dismissible: DismissiblePane(onDismissed: () {
                                  setState(() {
                                    delete_cart_data(cartId: cartdata[index]["id"]);
                                  });
                                }),
                                children: [
                                  SlidableAction(
                                    onPressed: (context) {

                                        setState(() {
                                          delete_cart_data(cartId: cartdata[index]["id"]);
                                        });

                                    },
                                    backgroundColor: Color(0xFFFE4A49),
                                    foregroundColor: Colors.white,
                                    icon: Icons.delete,
                                    label: 'Delete',
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 150,
                                  decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: Colors.black)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 30),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          // crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text(cartdata[index]["p_name"],
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 30)),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                                "\u{20B9}${cartdata[index]["p_price"]}",
                                                style: TextStyle(fontSize: 15)),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: 150,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    cartdata[index]["p_image"]),
                                                fit: BoxFit.cover)),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }

  Future<Map> cartgetdata() async {
    var url = Uri.parse(
        'https://manthanonlineshopping.000webhostapp.com/cart_data.php');
    var response = await http.post(url,
        body: {'user_id': getXclass.sharedPref?.getString('userid')});
    var view_Cartdata = jsonDecode(response.body);
    return view_Cartdata;
  }

  Future<void> delete_cart_data({required String cartId}) async {
    var url = Uri.parse(
        'https://manthanonlineshopping.000webhostapp.com/delete_cart_data.php');
    var response = await http.post(url,
        body: {'cart_id': cartId});

  }
}
