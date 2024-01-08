import 'dart:convert';

import 'package:ecommerce_app/add_cart.dart';
import 'package:ecommerce_app/getxfile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:razorpay_flutter/razorpay_flutter.dart';

class product_details extends StatelessWidget {
  product_details({
    super.key,
    required this.name,
    required this.price,
    required this.des,
    required this.image,
    this.isfromcart=false
  });


  String name;
  String price;
  String des;
  String image;
  RxBool isloading = false.obs;
  bool isfromcart = false;
  late Razorpay _razorpay;

  @override
  Widget build(BuildContext context) {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    String? uid = getXclass.sharedPref?.getString('userid') ?? "";
    // int uid1=int.parse(uid);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  height: 400,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(image), fit: BoxFit.fill)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(name,
                        softWrap: true,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        )),
                    Container(
                      width: 100,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.black)),
                      child: Text("\u{20B9}${price}",
                          softWrap: true,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          )),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(des,
                      softWrap: true,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      )),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(onTap: () async {
                    var email= await user_email();
                    var options = {
                      'key': 'rzp_test_RcZ7TeeWBQssME',
                      'amount': int.parse(price)*100,
                      'name': name,
                      'description': des,
                      'prefill': {
                        'contact': '8888888888',
                        'email': email
                      }
                    };
                    _razorpay.open(options);
                  },
                    child: Expanded(
                      child: Container(
                        height: 50,
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.black),
                          shape: BoxShape.rectangle,
                          gradient: const LinearGradient(
                              colors: [Colors.red, Colors.blue],
                              stops: [0.0, 1.0],
                              tileMode: TileMode.clamp),
                        ),
                        alignment: Alignment.center,
                        child: Text("BUY NOW",
                            style: TextStyle(fontSize: 20, color: Colors.black)),
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  isfromcart==false?GestureDetector(
                    onTap: () async {
                      print(uid);
                      // print("===$uid1");
                      Map map = {
                        "p_name": name,
                        "p_des": des,
                        "p_price": price,
                        "user_id": uid,
                        "p_image": image,
                        "p_quantity": '1'
                      };
                      isloading.value = true;
                      var url = Uri.parse(
                          'https://manthanonlineshopping.000webhostapp.com/add_to_cart.php');
                      var response = await http.post(url, body: map);
                      print('!!!!!!!!!!!! : ${response.body}');
                      isloading.value = false;

                      Get.to(add_cart());
                    },
                    child: Obx(
                            () => Expanded(
                              child: Container(
                                height: 50,
                                width: 150,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(color: Colors.black),
                                  shape: BoxShape.rectangle,
                                  gradient: const LinearGradient(
                                      colors: [
                                        Color(0xff2d388a),
                                        Color(0xff00aeef)
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      stops: [0.0, 1.0],
                                      tileMode: TileMode.clamp),
                                ),
                                alignment: Alignment.center,
                                child: isloading.value
                                    ? CircularProgressIndicator()
                                    : Text("ADD TO CART",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.black)),
                              ),
                            ),
                          ),
                  ):Container(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
  }

  Future<String> user_email() async {
    var url = Uri.parse(
        'https://manthanonlineshopping.000webhostapp.com/get_user_email.php');
    var response = await http.post(url,
        body: {'user_id': getXclass.sharedPref?.getString('userid')});
    var view_Cartdata = jsonDecode(response.body);
    return view_Cartdata["userdata"][0]["email"];
  }
}


