import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_monitor/constants.dart';

class AddRemarks extends StatelessWidget {
  AddRemarks(this.addTaskCallback);
  final Function addTaskCallback;
  @override
  Widget build(BuildContext context) {
    String addTask;
    return Container(
      color: kInactiveCardColour,
      child: Container(
        decoration: BoxDecoration(
          color: kActiveCardColour,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(
                  top: 20,
                ),
                child: Text(
                  'Add Remark',
                  style: TextStyle(fontSize: 30, color: Colors.lightBlueAccent, fontWeight: FontWeight.w400),
                ),
              ),
              TextField(
                onSubmitted: (newTask) {
                  addTask = newTask;
                  Navigator.pop(context);
                  return addTaskCallback(addTask);
                },
                onChanged: (newTask) {
                  addTask = newTask;
                },
                textAlign: TextAlign.center,
                autofocus: true,
                enableSuggestions: true,
                autocorrect: true,
                cursorColor: Colors.lightBlueAccent,
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.lightBlueAccent, width: 4),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                  width: double.infinity,
                  color: Colors.lightBlueAccent,
                  child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        return addTaskCallback(addTask);
                      },
                      child: Text(
                        'Add',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )))
            ],
          ),
        ),
      ),
    );
  }
}
