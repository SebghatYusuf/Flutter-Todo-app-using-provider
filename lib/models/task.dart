import 'package:flutter/material.dart';

class Task {
  String name;
  bool completed;
  Task({@required this.name, this.completed = false});


  void toggleCompleted (){
    completed = !completed;
  }
}