import 'dart:convert';

import 'package:ecommerce_app/getxfile.dart';
import 'package:ecommerce_app/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
      ),
      body: FutureBuilder(
        future: getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else {
            return ListView(
              children: [
                // Profile Picture
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage:
                        NetworkImage(snapshot.data!['userdata'][0]['image']),
                  ),
                ),

                // User Details
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text('Name'),
                  subtitle: Text(snapshot.data!['userdata'][0]['name']),
                ),

                ListTile(
                  leading: Icon(Icons.phone),
                  title: Text('Mobile Number'),
                  subtitle: Text("1234567890"),
                ),

                ListTile(
                  leading: Icon(Icons.email),
                  title: Text('Email'),
                  subtitle: Text(snapshot.data!['userdata'][0]['email']),
                ),

                // Other Profile Information
                ListTile(
                  leading: Icon(Icons.lock),
                  title: Text('Password'),
                  subtitle: Text(snapshot.data!['userdata'][0]['pass']),
                ),

                // Edit Profile Button
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      getXclass.sharedPref?.setBool("islogin", false);
                      getXclass.sharedPref?.setString("userid", "");
                      Get.offAll(login_page());
                    },
                    child: Text('Log Out'),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Future<Map> getUserData() async {
    var url = Uri.parse(
        "https://manthanonlineshopping.000webhostapp.com/get_user_email.php");
    var response = await http.post(url,
        body: {"user_id": getXclass.sharedPref!.getString("userid")});
    var userData = jsonDecode(response.body);
    return userData;
  }
}
