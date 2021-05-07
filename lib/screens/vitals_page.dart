import 'dart:math';

import 'package:flutter/material.dart';
import 'package:health_monitor/components/bottom_button.dart';
import 'package:health_monitor/components/icon_content.dart';
import 'package:health_monitor/components/main_menu.dart';
import 'package:health_monitor/components/reusable_card.dart';
import 'package:health_monitor/functionality/data.dart';
import 'package:health_monitor/functionality/sensor_data.dart';
import 'package:health_monitor/screens/step_counter.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'dart:convert';
import '../constants.dart';
import 'add_remark.dart';
import 'package:firebase_database/firebase_database.dart';

class VitalsPage extends StatefulWidget {
  const VitalsPage({Key key}) : super(key: key);

  @override
  _VitalsPageState createState() => _VitalsPageState();
}

class _VitalsPageState extends State<VitalsPage> with TickerProviderStateMixin {
  Animation _heartAnimation;
  Animation _lungAnimation;
  AnimationController _heartAnimationController;
  AnimationController _lungAnimationController;
  SensorsData sensors = SensorsData();
  int pulse = 0;
  int spo2 = 0;
  String remark;
  int _currentNavigationIndex = 0;
  int currentPage;

  @override
  void initState() {
    _heartAnimationController = AnimationController(vsync: this, duration: Duration(milliseconds: 1200));
    _lungAnimationController = AnimationController(vsync: this, duration: Duration(milliseconds: 8000));

    _heartAnimation = Tween(begin: 1.0, end: 0.5).animate(CurvedAnimation(parent: _heartAnimationController, curve: Curves.bounceOut));
    _lungAnimation = Tween(begin: 1.0, end: 0.5).animate(CurvedAnimation(parent: _heartAnimationController, curve: Curves.linear));

    _heartAnimationController.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        _heartAnimationController.mirror();
      }
    });

    _lungAnimationController.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        _lungAnimationController.mirror();
      }
    });
    _heartAnimationController.forward();
    _lungAnimationController.forward();
    super.initState();
  }

  Future<void> _sendData([String remark]) async {
    print("Send data called");
    Map<String, dynamic> data = {'Time:': DateTime.now().toString(), 'Pulse': pulse, 'SpO2': spo2, 'Remark': remark};
    FirebaseFirestore.instance.collection("DATA").add(data).catchError((e) {
      print(e);
    });
    // print(_databaseRef.path);
    // print(_databaseRef.key);
    // _databaseRef.set("Hello word ${Random().nextInt(100)}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vitals"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ReusableCard(
                    colour: kActiveCardColour,
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconContent(
                          animation: _heartAnimation,
                          animationController: _heartAnimationController,
                          icon: FontAwesomeIcons.heartbeat,
                          label: 'Heart Rate',
                        ),
                        Text(
                          pulse.toString(),
                          style: kNumberTextStyle,
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    colour: kActiveCardColour,
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconContent(
                          animation: _lungAnimation,
                          animationController: _lungAnimationController,
                          icon: FontAwesomeIcons.lungs,
                          label: 'O2 Saturation',
                        ),
                        Text(
                          spo2.toString(),
                          style: kNumberTextStyle,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            //flex: 1,
            child: Row(
              children: [
                Expanded(
                  child: BottomButton(
                    alignment: Alignment.centerRight,
                    buttonTitle: 'Measure',
                    onLongPress: () {
                      Future.delayed(Duration(seconds: 1), () {
                        setState(() {
                          pulse = pulse - 1;
                        });
                      });
                    },
                    onTap: () {
                      setState(() {
                        pulse = sensors.rateL();
                        spo2 = sensors.spo2();
                      });
                    },
                  ),
                ),
                Expanded(
                  child: BottomButton(
                    alignment: Alignment.centerLeft,
                    buttonTitle: ' Vitals',
                    onLongPress: () {
                      Future.delayed(Duration(seconds: 1), () {
                        setState(() {
                          pulse = pulse + 1;
                        });
                      });
                    },
                    onTap: () {
                      setState(() {
                        pulse = sensors.rateH();
                        spo2 = sensors.spo2();
                      });
                    },
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: BottomButton(
              alignment: Alignment.center,
              buttonTitle: 'Upload Data',
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      child: AddRemarks((value) async {
                        print(value);
                        String data;
                        DateTime now = DateTime.now();
                        remark = value.toString();
                        // print(now);
                        data = '{"Time": $now, "Pulse": $pulse, "SPO2": $spo2, "Remarks": $remark}';
                        _sendData(remark);
                      }),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
