import 'dart:convert';

import 'package:ecommerce_app/registerpage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'getxfile.dart';
import 'package:http/http.dart' as http;

import 'homepage.dart';

class login_page extends StatelessWidget {
  TextEditingController logemailController = TextEditingController();
  TextEditingController logpasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login Page')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(
              () => Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  controller: logemailController,
                  decoration: InputDecoration(
                      labelText: 'Email',
                      errorText: getXclass.isValidEmialinlogin.value
                          ? null
                          : "plese enter valid email"),
                ),
              ),
            ),
            Obx(
              () => Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  controller: logpasswordController,
                  decoration: InputDecoration(
                      labelText: 'Password',
                      errorText: getXclass.isValidPasswordinlogin.value
                          ? null
                          : "plese enter password"),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                  onPressed: () async {
                    getXclass.isValidEmialinlogin.value = logemailController
                            .text.isNotEmpty &&
                        getXclass.emailRegExp.hasMatch(logemailController.text);
                    getXclass.isValidPasswordinlogin.value =
                        logpasswordController.text.isNotEmpty;
                    if (getXclass.isValidEmialinlogin.value &&
                        getXclass.isValidPasswordinlogin.value) {
                      Map login = {
                        'email': logemailController.text,
                        'pass': logpasswordController.text,
                      };

                      var url = Uri.parse(
                          'https://manthanonlineshopping.000webhostapp.com/login.php');
                      var response = await http.post(url, body: login);
                      String logindata = response.body;
                      print("logindata=$logindata");
                      Map uservalue=jsonDecode(logindata);
                      // print("email=${uservalue["userdata"][0]["email"]} && pass=${uservalue["userdata"][0]["pass"]}");
                      if(uservalue["userdata"].isEmpty){
                        final snackBar = SnackBar(
                          content: const Text('data not found!'),
                          action: SnackBarAction(
                            label: 'Undo',
                            onPressed: () {
                              // Some code to undo the change.
                            },
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                      else{
                        if(uservalue["userdata"][0]["pass"]==logpasswordController.text){
                          getXclass.sharedPref?.setBool("islogin", true);
                          getXclass.sharedPref?.setString("userid",uservalue["userdata"][0]["id"] );
                          Get.offAll(homepage());
                        }else{
                          getXclass.isValidPasswordinlogin.value=false;
                        }
                      }

                    }
                  },
                  child: Text('LOGIN'),
                ),
              ),
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("DONT HAVE AN ACCOUNT?"),
                    TextButton(
                        onPressed: () {
                          getXclass.isValidEmialinlogin.value = true;
                          getXclass.isValidPasswordinlogin.value = true;
                          Get.off(RegisterPage());
                        },
                        child: Text("Register Now"))
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
