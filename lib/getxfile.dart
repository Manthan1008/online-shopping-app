import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class getXclass extends GetxController {
  RxBool connection = true.obs;
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

  @override
  void onInit() {
    super.onInit();
    checkConnectivity();
  }

  Future<void> checkConnectivity() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult != ConnectivityResult.mobile &&
        connectivityResult != ConnectivityResult.wifi) {
      connection.value = false;
      Get.defaultDialog(
        title: 'Lost Connection',
      );
    }
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result != ConnectivityResult.mobile &&
          result != ConnectivityResult.wifi) {
        connection.value = false;
        Get.defaultDialog(
          title: 'Lost Connection',
        );
      } else {
        connection.value = true;
      }
    });
  }
}
