import 'package:flutter/material.dart';
import 'package:provider_test/models/task.dart';
import 'package:provider_test/utils/database_helper.dart';

class TodosModel extends ChangeNotifier {
  DatabaseHelper databaseHelper = DatabaseHelper();

  List<Task> _tasks = [];

  void setTasks(List<Task> taskList){
    _tasks = taskList;
    notifyListeners();
  }

  get allTasks => _tasks;
  get completedTasks => _tasks.where((todo) => todo.completed).toList();
  get incompleteTasks => _tasks.where((todo) => !todo.completed).toList();

  void addTask(Task task) async {
    await databaseHelper.insertTask(task);

    _tasks.add(task);
    notifyListeners();
  }
  
  void updateTask(Task task){
    final index = _tasks.indexOf(task);
    _tasks[index].toggleCompleted();
    print("task index is $index " );
    notifyListeners();
  }

  void toggleTodo(Task task) async {
    await databaseHelper.updateTask(task).then((_)=> updateTask(task));
    
  }

  void deleteTodo(Task task) async {
    await databaseHelper.deleteTask(task.id);
    _tasks.remove(task);
    notifyListeners();
  }
}
