import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class CheckConnection extends StatelessWidget {
  CheckConnection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: StreamBuilder(
        stream: InternetConnection().connectivityResult,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            InternetConnection().checkconnction();
          } else if (snapshot.hasError) {
            return const Text('error');
          } else {
            InternetConnection().connect(connectivityResult: snapshot.data);
          }
          return InternetConnection.isconnect
              ? Text("connected!!")
              : Text('not connected!!');
        },
      )),
    );
  }
}

class InternetConnection {
  static bool isconnect = false;

  final _connectivity = Connectivity();

  Stream<ConnectivityResult> get connectivityResult =>
      _connectivity.onConnectivityChanged;

  Future<void> checkconnction() async {
    ConnectivityResult connectivityResult =
        await _connectivity.checkConnectivity();
    isconnect = connectivityResult != ConnectivityResult.none;
  }

  void connect({ConnectivityResult? connectivityResult}) {
    isconnect = connectivityResult != ConnectivityResult.none;
  }
}
