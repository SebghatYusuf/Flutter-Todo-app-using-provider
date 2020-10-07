import 'package:flutter/material.dart';
import 'package:provider_test/models/task.dart';
import 'package:provider_test/providers/database_helper.dart';

class TodosModel extends ChangeNotifier {
  final DBHelper dbHelper;

  List<Task> _tasks = [];
  final tableName = 'tasks_table';

  TodosModel(this._tasks, {this.dbHelper}) {
    if (dbHelper != null) {
      fetchAndSetData();
    }
  }

  List<Task> get tasks => [..._tasks];

  get allTasks => _tasks;
  get completedTasks => _tasks.where((todo) => todo.completed).toList();
  get incompleteTasks => _tasks.where((todo) => !todo.completed).toList();

  void addTask(Task task) {
    if (dbHelper.db != null) {
      _tasks.add(task);
    }
    notifyListeners();
    dbHelper.insert(tableName, task.toMap());
  }

  void toggleTodo(Task task) {
    final index = _tasks.indexOf(task);
    _tasks[index].toggleCompleted();
    notifyListeners();
  }

  void deleteTodo(Task task) {
    _tasks.remove(task);
    notifyListeners();
  }

  void fetchAndSetData() async {
    if (dbHelper.db != null) {
      final dataList = await dbHelper.getData(tableName);
      _tasks = dataList
          .map((item) => Task(name: item['name'], completed: item['completed']))
          .toList();
    }
  }
}
