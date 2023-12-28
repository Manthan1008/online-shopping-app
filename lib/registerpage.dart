import 'dart:convert';
import 'dart:io';
import 'package:ecommerce_app/homepage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'getxfile.dart';
import 'login_page.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key}) : super(key: key);

  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerConFirmPassword =
      TextEditingController();

  RxString imagePath = ''.obs;
  String image = '';
  String imagename = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          children: [
            const SizedBox(height: 100),
            Text(
              "Register",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 10),
            Text(
              "Create your account",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 50),
            Obx(
              () => Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  image: imagePath.value.isEmpty
                      ? DecorationImage(
                          image:
                              AssetImage('images/phone-contacts-icon-25.jpg'),
                          fit: BoxFit.cover)
                      : DecorationImage(
                          image: FileImage(File('${imagePath.value}')),
                          fit: BoxFit.cover),
                  shape: BoxShape.circle,
                  color: Colors.white, // Background color
                  border: Border.all(color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () async {
                final ImagePicker picker = ImagePicker();
                final XFile? image =
                    await picker.pickImage(source: ImageSource.gallery);

                imagePath.value = image!.path;
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_a_photo, color: Colors.black),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "ADD PROFILE IMAGE",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black),
                  )
                ],
              ),
            ),

            // Username
            const SizedBox(height: 35),
            Obx(
              () => TextFormField(
                controller: _controllerUsername,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  errorText: getXclass.isValidUsername.value
                      ? null
                      : "please enter user name",
                  labelText: "Username",
                  prefixIcon: const Icon(Icons.person_outline),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),

            // Email
            const SizedBox(height: 10),
            Obx(
              () => TextFormField(
                controller: _controllerEmail,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  errorText:
                      getXclass.isValidEmial.value ? null : "Enter valid email",
                  labelText: "Email",
                  prefixIcon: const Icon(Icons.email_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),

            // Password
            const SizedBox(height: 10),
            Obx(
              () => TextFormField(
                controller: _controllerPassword,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  errorText: getXclass.isValidPassword.value
                      ? null
                      : "Please enter the password",
                  labelText: "Password",
                  prefixIcon: const Icon(Icons.password_outlined),
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.visibility_outlined),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),

            // Confirm Password
            const SizedBox(height: 10),
            Obx(
              () => TextFormField(
                controller: _controllerConFirmPassword,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  labelText: "Confirm Password",
                  errorText: getXclass.isValidRePassword.value
                      ? null
                      : "Password doesn't match",
                  prefixIcon: const Icon(Icons.password_outlined),
                  suffixIcon: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.visibility_outlined)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50),
            Container(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                  onPressed: () async {
                    getXclass.isValidUsername.value =
                        _controllerUsername.text.isNotEmpty;
                    getXclass.isValidEmial.value = _controllerEmail
                            .text.isNotEmpty &&
                        getXclass.emailRegExp.hasMatch(_controllerEmail.text);
                    getXclass.isValidPassword.value =
                        _controllerPassword.text.isNotEmpty &&
                            _controllerConFirmPassword.text ==
                                _controllerPassword.text;
                    getXclass.isValidRePassword.value =
                        _controllerPassword.text.isNotEmpty &&
                            _controllerConFirmPassword.text ==
                                _controllerPassword.text;

                    if (getXclass.isValidUsername.value &&
                        getXclass.isValidEmial.value &&
                        getXclass.isValidPassword.value &&
                        getXclass.isValidRePassword.value) {
                      if (imagePath.value.isNotEmpty) {
                        image = base64Encode((await File(imagePath.value)
                            .readAsBytes()) as List<int>);
                        imagename = "img${DateTime.now().second}";
                      }

                      Map body = {
                        'name': _controllerUsername.text,
                        'email': _controllerEmail.text,
                        'pass': _controllerPassword.text,
                        'image': image,
                        'imagename': imagename
                      };
                      var url = Uri.parse(
                          'https://manthanonlineshopping.000webhostapp.com/register.php');
                      var response = await http.post(url, body: body);
                      print('z : ${response.body}');
                      getXclass.sharedPref!.setBool("islogin", true);

                      Get.offAll(login_page());
                    }
                  },
                  child: Text('REGISTER'),
                ),
              ),
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account?"),
                    TextButton(
                      onPressed: () {
                        getXclass.isValidUsername.value = true;
                        getXclass.isValidEmial.value = true;
                        getXclass.isValidPassword.value = true;
                        getXclass.isValidRePassword.value = true;
                        getXclass.isValidDOB.value = true;
                        Get.off(login_page());
                      },
                      child: const Text("Login"),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
