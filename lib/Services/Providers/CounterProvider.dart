

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class CounterProvider with ChangeNotifier{

  int _counter =0;

  get getCounter => _counter;

  void setCounter(){
    _counter++;
    print("abc");
    notifyListeners();
  }

}