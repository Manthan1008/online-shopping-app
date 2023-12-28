import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import 'buy_product.dart';


class add_product extends StatelessWidget {
  add_product({super.key});

  final TextEditingController addproductname = TextEditingController();
  final TextEditingController productprice = TextEditingController();
  final TextEditingController productdescription = TextEditingController();
  RxString addimage = ''.obs;
  String _image = '';
  String _imagename = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Text("ADD PRODUCTS",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black)),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: addproductname,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    labelText: "NAME",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                Divider(),
                TextFormField(
                  controller: productdescription,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    labelText: "DESCRIPTION",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                Divider(),
                TextFormField(
                  controller: productprice,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    labelText: "PRICE",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                Divider(),
                GestureDetector(
                  onTap: () async {
                    final ImagePicker picker = ImagePicker();
                    final XFile? image =
                        await picker.pickImage(source: ImageSource.gallery);

                    addimage.value = image!.path;
                    CroppedFile? croppedFile = await ImageCropper().cropImage(
                      sourcePath: addimage.value,
                      aspectRatioPresets: [
                        CropAspectRatioPreset.square,
                        CropAspectRatioPreset.ratio3x2,
                        CropAspectRatioPreset.original,
                        CropAspectRatioPreset.ratio4x3,
                        CropAspectRatioPreset.ratio16x9
                      ],
                      uiSettings: [
                        AndroidUiSettings(
                            toolbarTitle: 'Cropper',
                            toolbarColor: Colors.deepOrange,
                            toolbarWidgetColor: Colors.white,
                            initAspectRatio: CropAspectRatioPreset.original,
                            lockAspectRatio: false),
                        IOSUiSettings(
                          title: 'Cropper',
                        ),
                        WebUiSettings(
                          context: context,
                        ),
                      ],
                    ).then((value) async {
                      if (value != null) {
                        addimage.value = value.path;
                      }
                      return null;
                    });
                  },
                  child: Obx(
                    () => Container(
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                          ),
                        ),
                        child: addimage.value.isEmpty
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [Icon(Icons.add_a_photo)],
                              )
                            : Image(
                                image: FileImage(File(addimage.value)),
                                fit: BoxFit.fill,
                              )),
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (addimage.value.isNotEmpty) {
                          _image = base64Encode((await File(addimage.value)
                              .readAsBytes()) as List<int>);
                          _imagename = "img${DateTime.now().second}";
                        }

                        Map body = {
                          'p_name': addproductname.text.trim(),
                          'p_des': productdescription.text.trim(),
                          'p_price': productprice.text.trim(),
                          'p_image': _image,
                          'imagename': _imagename
                        };
                        var url = Uri.parse(
                            'https://manthanonlineshopping.000webhostapp.com/add_product.php');
                        var response = await http.post(url, body: body);
                        // print('xyzzzzzzz: ${response.body}');

                        Get.offAll(buy_product());
                      },
                      child: Text('ADD'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
