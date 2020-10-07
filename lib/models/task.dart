import 'package:flutter/material.dart';

class Task {
  int _id;
  String name;
  bool completed;
  Task({@required this.name, this.completed = false});
  Task.withId(this._id, this.name, [this.completed]);

  void toggleCompleted() {
    completed = !completed;
  }

  int get id => _id;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['name'] = name;
    map['completed'] = completed;
    return map;
  }
  Task.fromMapObject(Map<String, dynamic> map){
    this._id = map['id'];
    this.name = map['name'];
    this.completed = map['completed'];
  }
}
