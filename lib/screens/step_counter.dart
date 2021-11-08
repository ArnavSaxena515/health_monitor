import 'package:flutter/material.dart';
import 'dart:async';

import 'package:pedometer/pedometer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

String formatDate(DateTime d) {
  return d.toString().substring(0, 19);
}

class StepsCounter extends StatefulWidget {
  @override
  _StepsCounterState createState() => _StepsCounterState();
}

class _StepsCounterState extends State<StepsCounter> {
  Stream<StepCount> _stepCountStream;
  Stream<PedestrianStatus> _pedestrianStatusStream;
  String _status = '?', _squats = '?';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  void onStepCount(StepCount event) {
    print(event);
    setState(() {
      _squats = event.steps.toString();
    });
  }

  void onPedestrianStatusError(error) {
    print('onPedestrianStatusError: $error');
    setState(() {
      _status = 'Pedestrian Status not available';
    });
    print(_status);
  }

  void onStepCountError(error) {
    print('onStepCountError: $error');
    setState(() {
      _squats = 'Step Count not available';
    });
  }

  void initPlatformState() {
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream.listen(onPedestrianStatusChanged).onError(onPedestrianStatusError);

    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);

    if (!mounted) return;
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    print(event);
    setState(() {
      _status = event.status;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Squats Done:',
            style: TextStyle(fontSize: 30),
          ),
          Text(
            _squats,
            style: TextStyle(fontSize: 60),
          ),
          Divider(
            height: 100,
            thickness: 0,
            color: Colors.white,
          ),

          //
        ],
      ),
    );
  }
}
