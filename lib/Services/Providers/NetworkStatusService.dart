





import 'dart:async';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

enum NetworkStatus {
  Online,
  Offline
}

class NetworkStatusService {

  StreamController<NetworkStatus> networkStatusController = StreamController<NetworkStatus>();

  NetworkStatusService(){
    print("as");

    Connectivity().onConnectivityChanged.listen((event) {
      print("b");
      networkStatusController.add(_getNetworkStatus(event));
    });
  }

  NetworkStatus _getNetworkStatus(ConnectivityResult status) {
    return status == ConnectivityResult.mobile || status == ConnectivityResult.wifi ? NetworkStatus.Online : NetworkStatus.Offline;
  }

}

