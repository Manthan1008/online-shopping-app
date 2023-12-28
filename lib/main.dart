import 'package:ecommerce_app/check_connect.dart';
import 'package:ecommerce_app/check_login.dart';
import 'package:ecommerce_app/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Myproviderr.dart';


void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: checklogin(),
  ));
}


