import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_test/models/task.dart';
import 'package:provider_test/providers/todos_model.dart';

class TaskListItem extends StatelessWidget {
  final Task task;
  TaskListItem({@required this.task});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
          value: task.completed,
          onChanged: (checked) {
            Provider.of<TodosModel>(context,listen: false).toggleTodo(task);
          }),
      title: Text(task.name),
      trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            Provider.of<TodosModel>(context, listen:false).deleteTodo(task);
          }),
    );
  }
}
