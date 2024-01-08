import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'getxfile.dart';
import 'homepage.dart';
import 'login_page.dart';
import 'lost_connection_dialog.dart';

class checklogin extends StatelessWidget {
  checklogin({super.key});

  @override
  Widget build(BuildContext context) {
    getXclass.getprefrance();
    var ctrl = Get.put(getXclass());
    // if(!ctrl.connection.value){
    //   showDialog(context: context, builder: (context) {
    //     return LostConnectionDialog();
    //   },);
    // }
    Future.delayed(Duration(seconds: 3)).then((value) {
      bool val=getXclass.sharedPref!.getBool("islogin")??false;
      if(val){
        Get.offAll(homepage());
      }
      else{
        Get.offAll(login_page());
      }
    },);
    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }

}

