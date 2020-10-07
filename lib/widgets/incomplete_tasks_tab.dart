import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_test/providers/todos_model.dart';
import 'package:provider_test/widgets/task_list.dart';

class IncompleteTasksTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<TodosModel>(
        builder: (context, todos, child) {
          return TaskList(tasks: todos.incompleteTasks);
        },
      ),
    );
  }
}
