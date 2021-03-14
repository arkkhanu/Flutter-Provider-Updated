import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sqlife_and_provider/Model/City.dart';
import 'package:flutter_sqlife_and_provider/Services/DatabaseHelper.dart';
import 'package:flutter_sqlife_and_provider/Services/Providers/Cities_Provider.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import '../Services/DatabaseHelper.dart';


class FirstScreen extends StatelessWidget {
  String _cityName;

  GlobalKey<FormFieldState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    // context.read<CitiesProvider>().setListOfCites();
    Provider.of<CitiesProvider>(context,listen: false).setListOfCites();
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("First Screen"),
      ),
      body: Padding(
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
                _cityName = val.trim();
              },
              validator: (val) {
                return val.isEmpty ? "Can't be empty" : null;
              },
              onSaved: (val) {
                _cityName = val.trim();
              },
            ),
            Divider(
              thickness: 0,
              height: 20,
              color: Colors.transparent,
            ),
            ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    await DatabaseHelper.insertCities(
                            City.constructor("id", _cityName))
                        .whenComplete(() {
                      Provider.of<CitiesProvider>(context,listen: false).setListOfCites();
                          Toast.show(
                            "Data inserted into Database", context,
                            duration: Toast.LENGTH_SHORT,
                            gravity: Toast.BOTTOM);})
                        .catchError((onError) {
                      Toast.show("Error" + onError.toString(), context,
                          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
                    });
                  }
                },
                child: Text("Insert")),
            ElevatedButton(
                onPressed: () async {
                  await DatabaseHelper.deleteAllCities().whenComplete(() {
                    Provider.of<CitiesProvider>(context,listen: false).setListOfCites();
                      Toast.show("Deleted All", context,
                          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);});
                },
                child: Text("Delete All")),
            /*FutureBuilder(
              future: Provider.of<CitiesProvider>(context).getawaitListOfCitiesz,
              builder: (context,AsyncSnapshot<List<City>> snapshot) {
                if(snapshot.hasData){
                  return Text("data is"+snapshot.data.toString());
                }
                else{
                  return CircularProgressIndicator();
                }
              },
            )*/
            Consumer<CitiesProvider>(
              child: Text("helo"),
              builder: (context, value, child) {
                print("value :"+value.getListOfCities.length.toString());
                return Text(
                    "WAiting:"+value.getListOfCities.length.toString());
              },
            ),
            Consumer<CitiesProvider>(
              builder: (context, value, child) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: value.getListOfCities.length ,
                  itemBuilder:(context, index) => Text("CityName :"+value.getListOfCities[index].cityName));
              },
            )
          ],
        ),
      ),
    ));
  }
}
