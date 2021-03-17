import 'package:flutter/material.dart';
import 'package:flutter_sqlife_and_provider/Screens/SecondScreen.dart';
import 'package:flutter_sqlife_and_provider/Services/DatabaseHelper.dart';
import 'package:flutter_sqlife_and_provider/Services/Providers/Cities_Provider.dart';
import 'package:flutter_sqlife_and_provider/Services/Providers/Connectivity_Provider.dart';
import 'package:flutter_sqlife_and_provider/Services/Providers/Currencies_Provider.dart';
import 'package:provider/provider.dart';

import 'Screens/FirstScreen.dart';
import 'Screens/ThirdScreen.dart';
import 'Services/Providers/CounterProvider.dart';
import 'Services/Providers/NetworkStatusService.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<NetworkStatusCheck>(
          initialData: NetworkStatusCheck.NotConnected,
          create: (context) =>
          Connectivity_Provider().networkStatusController.stream,
        ),
        /*StreamProvider<NetworkStatus>(
          initialData: NetworkStatus.Offline,
          create: (context) =>
              NetworkStatusService().networkStatusController.stream,
        ),*/
        ChangeNotifierProvider<CounterProvider>(
          create: (context) => CounterProvider(),
        ),
        ChangeNotifierProvider<CitiesProvider>(
          create: (context) => CitiesProvider(),
        ),
        ChangeNotifierProvider<Currencies_Provider>(
          create: (context) => Currencies_Provider(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(),
        initialRoute: '/',
        routes: {
          '/FirstScreen': (context) => FirstScreen(),
          '/SecondScreen': (context) => SecondScreen(),
          '/ThirdScreen': (context) => ThirdScreen(),
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _provider = Provider.of<CounterProvider>(context, listen: false);
    // var _provider = Provider.of<CounterProvider>(context).getCounter;
    return Scaffold(
      appBar: AppBar(
        title: Text("Provider Example"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Consumer<CounterProvider>(
              builder: (context, consumervalue, child) => Text(
                '${consumervalue.getCounter}',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            Divider(
              height: 10,
            ),
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/FirstScreen");
                },
                child: Text("Move to City Page")),
            Divider(
              height: 10,
            ),
            TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, "/SecondScreen");
                },
                child: Text("Move to Currency Page")),
            TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, "/ThirdScreen");
                },
                child: Text("Move to Currency Page"))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _provider.setCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
