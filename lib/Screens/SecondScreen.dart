import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sqlife_and_provider/Model/Currency.dart';
import 'package:flutter_sqlife_and_provider/Services/DatabaseHelper.dart';
import 'package:flutter_sqlife_and_provider/Services/Providers/Currencies_Provider.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  GlobalKey<FormFieldState> _formKey = GlobalKey();
  Currencies_Provider innerProvider;
  String _currencyName;

  @override
  void initState() {
    super.initState();
    innerProvider = Provider.of<Currencies_Provider>(context, listen: false);
    innerProvider.getAllCurrenciesFromDB();
  }

  @override
  Widget build(BuildContext context) {
    // Provider.of<Currencies_Provider>(context,listen: false).getAllCurrenciesFromDB();

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
            ModalRoute.of(context).settings?.name?.substring(1) ?? "Second"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Center(
                  child: Text(
                "Insert into Database",
                style: Theme.of(context).textTheme.headline5,
              )),
              TextFormField(
                key: _formKey,
                onChanged: (val) {
                  _currencyName = val.trim();
                },
                validator: (val) {
                  return val.isEmpty ? "Can't be empty" : null;
                },
                onSaved: (val) {
                  _currencyName = val.trim();
                },
              ),
              Divider(
                thickness: 0,
                height: 20,
                color: Colors.transparent,
              ),
              ElevatedButton(
                  onPressed: () async {
                    String _message;
                    if (_formKey.currentState.validate()) {
                      bool ispresent = innerProvider.getListOfCurrencies
                          .where((element) =>
                              element.currencyName.toLowerCase() == _currencyName.toLowerCase())
                          .isEmpty;
                      if (ispresent) {
                        int inserted = await innerProvider.insertCurrency(
                            Currency.constructor("id", _currencyName));
                        inserted > 0
                            ? _message = "Inserted Successfully"
                            : _message = "Sorry, Failed to Insert";
                      } else {
                        _message = "Already present, try different value.";
                      }
                      Toast.show(_message, context,
                          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
                    }
                  },
                  child: Text("Insert")),
              ElevatedButton(
                  onPressed: () async {
                    innerProvider.deleteAllCurrenciesFromDB();
                    innerProvider.setSelectValue(innerProvider.defaultValue);
                    Toast.show("Deleted All", context,
                        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
                  },
                  child: Text("Delete All")),
              Consumer<Currencies_Provider>(
                child: Text("helo"),
                builder: (context, value, child) {
                  print(
                      "value1 :" + value.getListOfCurrencies.length.toString());
                  return Text(
                      "WAiting:" + value.getListOfCurrencies.length.toString());
                },
              ),
              Consumer<Currencies_Provider>(
                builder: (context, value, child) {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: value.getListOfCurrencies.length,
                      itemBuilder: (context, index) => Text("CityName :" +
                          value.getListOfCurrencies[index].currencyName));
                },
              ),
              Consumer<Currencies_Provider>(
                builder: (context, value, child) => DropdownButton(
                  value: value.selectValue,
                  onChanged: (val) {
                    value.setSelectValue(val);
                    print("selectedValue is :" + val.toString());
                  },
                  items: value.getListOfCurrencies
                      .map((e) => DropdownMenuItem(
                            child: Text(e.currencyName),
                            value: e.currencyName,
                          ))
                      .toList(),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
