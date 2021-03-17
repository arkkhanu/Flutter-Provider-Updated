


import 'dart:io';

class ConnectionCheck{
  static Future<bool> isConnectedOrNot() async{
    bool isConnected=false;
    try{
      final result = await InternetAddress.lookup("google.com").timeout(Duration(seconds: 5),onTimeout: () => null,);
      if(result != null){
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          isConnected = true;
        }
      }

    } on SocketException catch (_){
      isConnected = false;
    }
    return isConnected;
  }
}