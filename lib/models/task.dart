import 'dart:convert';

import 'package:flutter/material.dart';

class Task {
  int id;
  String name;
  bool completed;
  Task({@required this.name, this.completed = false});
  Task._withId(this.id, this.name, this.completed);

  void toggleCompleted() {
    completed = !completed;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['name'] = name;
    map['completed'] = completed;
    return map;
  }

  Task.fromMap(Map<String, dynamic> map){
    this.id = map['id'];
    this.name = map['name'];
    this.completed = getBool(map);
  }

  bool getBool(map){
    if (json.decode(map['completed']) == 1){
      return true;
    }
    return false;
  }
}
