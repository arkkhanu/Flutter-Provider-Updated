import 'package:flutter/cupertino.dart';
import 'package:flutter_sqlife_and_provider/Model/Currency.dart';
import 'package:flutter_sqlife_and_provider/Services/DatabaseHelper.dart';

class Currencies_Provider with ChangeNotifier {
  String defaultValue = "Select";
  String _selectValue;
  List<Currency> _currencyList;
 String get selectValue => _selectValue ;


 void setSelectValue(String val){
   _selectValue = val;
   print("set selection :");
   notifyListeners();
 }

  List<Currency> get getListOfCurrencies => _currencyList;

  Future<int> insertCurrency(Currency currency) async {
    List<Currency> list = [];
    int isInserted = await DatabaseHelper.insertCurrency(currency);
    list = await getAllCurrenciesFromDB();
    print("insertCurrency");
    if (list != null) {
      notifyListeners();
      return isInserted;
    } else {
      _currencyList = [];
      _currencyList.add(Currency.constructor("id", defaultValue));
      notifyListeners();
      return isInserted;
    }
  }

  Future<List<Currency>> getAllCurrenciesFromDB() async {
    List<Currency> list = [];
    _currencyList = [];
    _currencyList.add(Currency.constructor("id", defaultValue));
    list = await DatabaseHelper.getAllCurrencies();
    list.isEmpty ? _currencyList : _currencyList.addAll(list);
    print("getAll");
    notifyListeners();
    return _currencyList;
  }

  deleteAllCurrenciesFromDB() async{
     await DatabaseHelper.deleteAllCurrencies();
     _currencyList = [];
     _currencyList.add(Currency.constructor("id", defaultValue));
     print("delete");
     notifyListeners();
  }

}
