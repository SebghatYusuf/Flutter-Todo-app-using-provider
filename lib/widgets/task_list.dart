import 'package:flutter/material.dart';
import 'package:provider_test/models/task.dart';
import 'package:provider_test/widgets/task_list_item.dart';

class TaskList extends StatelessWidget {
  final List<Task> tasks;
  TaskList({this.tasks});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: getChildrenTasks(),
    );
  }

  List<Widget> getChildrenTasks() {
    return tasks.map((todo) => TaskListItem(task: todo)).toList();
  }
}
