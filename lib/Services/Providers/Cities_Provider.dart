import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../Model/City.dart';
import '../DatabaseHelper.dart';

class CitiesProvider with ChangeNotifier {
  List<City> _listOfCities;

  List<City> get getListOfCities => _listOfCities;

  Future<List<City>> _getListFromDB() async {
    List<City> list = [];
    _listOfCities = [];
    list = await DatabaseHelper.getAllCities();
    list.isEmpty ? _listOfCities : _listOfCities.addAll(list);
    return _listOfCities;
  }

  List<City> getawaitListOfCities() {
    print("h1");
    return _listOfCities;
  }

  Future<void> setListOfCites() async {
    await _getListFromDB();
    print("Size :" + _listOfCities.length.toString());
    notifyListeners();
  }
}
