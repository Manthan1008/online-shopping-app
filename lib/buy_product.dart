import 'dart:convert';

import 'package:ecommerce_app/product_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'Models/product.dart';
import 'add_product_page.dart';

class buy_product extends StatelessWidget {
  buy_product({super.key});

  Future<Map> getdata() async {
    var url = Uri.parse(
        'https://manthanonlineshopping.000webhostapp.com/show_product.php');
    var response = await http.post(url);
    print("++++++++++++");
    var view_product = jsonDecode(response.body);
    // ProductData=jsonDecode(response.body);
    print("Show_product=$view_product");
    return view_product;
  }

  @override
  Widget build(BuildContext context) {
    // print('map=${view_product}');
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("PRODUCTS",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black)),
        actions: [
          GestureDetector(
            onTap: () {
              Get.to(add_product());
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                alignment: Alignment.center,
                color: Colors.black,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text('ADD PRODUCT', style: TextStyle(fontSize: 10,color: Colors.white)),
                ),
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getdata(),
              builder: (context, snapshot) {
                print('!!!!!!!!!!!!! ${snapshot.connectionState}');
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error'),
                  );
                } else {
                  return MasonryGridView.count(
                    crossAxisCount: 2,
                    itemCount: snapshot.data!['productdata'].length,
                    itemBuilder: (BuildContext context, int index) {
                      Map map = snapshot.data!['productdata'][index];
                      Product product = Product(
                          id: map['id'],
                          name: map['p_name'],
                          price: map['p_price'],
                          decription: map['p_des'],
                          image: map['p_image']);
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: GestureDetector(
                          onTap: () {
                            Get.to(product_details(
                                name: product.name,
                                price: product.price,
                                des: product.decription,
                                image: product.image));
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(product.image),
                              // Container(
                              //   height: 200,
                              //   decoration: BoxDecoration(
                              //       borderRadius: BorderRadius.circular(10),
                              //       border: Border.all(color: Colors.white),
                              //       image: DecorationImage(
                              //         image: NetworkImage(product.image),
                              //         // fit: BoxFit.fill,
                              //       )),
                              // ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(product.name,
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                              ),
                              Center(
                                child: Text("\u{20B9}${product.price}",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                  return GridView.builder(
                    itemCount: snapshot.data!['productdata'].length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: MediaQuery.of(context).size.width /
                          (MediaQuery.of(context).size.height / 1.40),
                    ),
                    itemBuilder: (context, index) {
                      Map map = snapshot.data!['productdata'][index];
                      Product product = Product(
                          id: map['id'],
                          name: map['p_name'],
                          price: map['p_price'],
                          decription: map['p_des'],
                          image: map['p_image']);
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: GestureDetector(
                          onTap: () {
                            Get.to(product_details(
                                name: product.name,
                                price: product.price,
                                des: product.decription,
                                image: product.image));
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 200,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.white),
                                    image: DecorationImage(
                                        image: NetworkImage(product.image),
                                        fit: BoxFit.fill)),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(product.name,
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                              ),
                              Center(
                                child: Text("\u{20B9}${product.price}",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                        ),
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
}
