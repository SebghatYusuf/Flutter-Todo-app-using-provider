import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_test/models/task.dart';
import 'package:provider_test/providers/todos_model.dart';

class AddTaskScreen extends StatefulWidget {
  static const routeName = '/add';
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final taskTitleController = TextEditingController();
  bool completedStatus = false;

  @override
  void dispose() {
    taskTitleController.dispose();
    super.dispose();
  }

  void onAdd() {
    final String textVal = taskTitleController.text;
    final bool completed = completedStatus;
    print(textVal);
    if (textVal.isNotEmpty) {
      final Task todo = Task(name: textVal, completed: completed);
      Provider.of<TodosModel>(context, listen: false).addTask(todo);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Task"),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: taskTitleController,
                  ),
                  CheckboxListTile(
                    value: completedStatus,
                    onChanged: (checked) {
                      completedStatus = checked;
                    },
                    title: Text("Complete?"),
                  ),
                  RaisedButton(
                    onPressed: onAdd,
                    child: Text("Add"),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
