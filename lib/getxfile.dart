
import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

class getXclass extends GetxController {
  static RxBool isValidUsername = true.obs;

  static RxBool isValidEmial = true.obs;

  static RxBool isValidPassword = true.obs;

  static RxBool isValidRePassword = true.obs;

  static RxBool isValidDOB = true.obs;

  static RxBool isValidEmialinlogin = true.obs;
  static RxBool isValidPasswordinlogin = true.obs;
  static SharedPreferences? sharedPref;


  static RegExp emailRegExp = RegExp(
      '^[a-zA-Z0-9.!#\$%&\'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*\$');

  static void getprefrance() async {
    sharedPref = await SharedPreferences.getInstance();
  }


}

