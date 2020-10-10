import 'package:flutter/material.dart';
import 'package:provider_test/models/task.dart';
import 'package:provider_test/utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class TodosModel extends ChangeNotifier {
  DatabaseHelper databaseHelper = DatabaseHelper();

  List<Task> _tasks = [];

  List<Task> _getTaskListFromDb() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Task>> taskListFuture = databaseHelper.getTaskList();
      taskListFuture.then((taskList) {
        return taskList;
      });
    });
  }

  TodosModel() {
   _tasks =  _getTaskListFromDb();
  }

  get allTasks => _tasks;
  get completedTasks => _tasks.where((todo) => todo.completed).toList();
  get incompleteTasks => _tasks.where((todo) => !todo.completed).toList();

  void addTask(Task task) async {
    int result = await databaseHelper.insertTask(task);

    _tasks.add(task);
    notifyListeners();
  }

  void toggleTodo(Task task) async {
    int result = await databaseHelper.updateTask(task);
    final index = _tasks.indexOf(task);
    _tasks[index].toggleCompleted();
    notifyListeners();
  }

  void deleteTodo(Task task) async {
    int result = await databaseHelper.deleteTask(task.id);
    _tasks.remove(task);
    notifyListeners();
  }
}
