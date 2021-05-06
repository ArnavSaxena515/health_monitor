import 'package:flutter/material.dart';
import 'package:health_monitor/screens/vitals_page.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData.dark().copyWith(
          primaryColor: Color(0xFF0A0E21),
          scaffoldBackgroundColor: Color(0xFF0A0E21),
        ),
        home: FutureBuilder(
          future: _fbApp,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print('ERROR ${snapshot.error.toString()}');
              return Text('Something went wrong');
            } else if (snapshot.hasData) {
              print(snapshot.data);
              print("success");
              return VitalsPage();
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        )
        // VitalsPage(),
        );
  }
}
