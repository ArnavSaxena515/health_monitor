import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_monitor/screens/input_page.dart';
import 'package:health_monitor/screens/step_counter.dart';
import 'package:health_monitor/screens/vitals_page.dart';
import '../constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentTab = 0;
  final _screens = [VitalsPage(), StepsCounter(), InputPage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Health Monitor"),
      ),
      body: _screens[currentTab],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentTab,
        items: [
          BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.home), label: 'Vitals', backgroundColor: kActiveCardColour),
          BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.shoePrints), label: 'Pedometer', backgroundColor: kActiveCardColour),
          BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.weight), label: 'BMI', backgroundColor: kActiveCardColour)
        ],
        onTap: (index) {
          setState(() {
            currentTab = index;
          });
        },
      ),
    );
  }
}
