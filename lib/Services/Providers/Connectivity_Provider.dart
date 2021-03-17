import 'dart:async';
import 'dart:io';

import 'package:connectivity/connectivity.dart';

enum NetworkStatusCheck { Connected, NotConnected }

class Connectivity_Provider {

  StreamController<NetworkStatusCheck> networkStatusController =
      StreamController<NetworkStatusCheck>();

  Connectivity_Provider() {
    print("as");
    // NetworkStatusCheck status =   _checkerORNot(event);
    // networkStatusController.add(status);

    Connectivity().onConnectivityChanged.listen((event) async {
      print("b");
      NetworkStatusCheck status = await  _getNetworkStatus(event);
      networkStatusController.add(status);
    });
  }

  Future<NetworkStatusCheck> _getNetworkStatus(
      ConnectivityResult status) async {
    bool isConnected = false;
    if (status == ConnectivityResult.mobile ||
        status == ConnectivityResult.wifi) {
      try {
        final result = await InternetAddress.lookup('example.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          isConnected = true;
        }
      } on SocketException catch (_) {
        print("catch" + _.message.toString());
        isConnected = false;
      }
    }
    return isConnected
        ? NetworkStatusCheck.Connected
        : NetworkStatusCheck.NotConnected;
  }
}
