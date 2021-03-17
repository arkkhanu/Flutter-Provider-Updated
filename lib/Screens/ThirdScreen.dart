import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sqlife_and_provider/Services/Providers/Connectivity_Provider.dart';
import 'package:provider/provider.dart';


class ThirdScreen extends StatelessWidget {
  // Connectivity_Provider _connectivity_provider;

  @override
  Widget build(BuildContext context) {
    NetworkStatusCheck prov = Provider.of<NetworkStatusCheck>(context,listen: false);
    print("c");
    return Scaffold(

      appBar: AppBar(title: Text("Connectivity Check"),),
      body: Column(
        children: [
          Container(child: Consumer<NetworkStatusCheck>(
            builder: (context, value, child) => Text("Data"+value.toString()),
          ),),
          ElevatedButton(onPressed: (){
            print("Check2:"+prov.toString());
          }, child: Text("Check Internet"))
        ],
      ),
    );
  }


}
