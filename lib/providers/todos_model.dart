import 'package:flutter/material.dart';
import 'package:provider_test/models/task.dart';

class TodosModel extends ChangeNotifier {
  final List<Task> _tasks = [];

  get allTasks => _tasks;
  get completedTasks => _tasks.where((todo) => todo.completed).toList();
  get incompleteTasks => _tasks.where((todo) => !todo.completed).toList();

  void addTask(Task task) {
    _tasks.insert(0, task);
    notifyListeners();
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
}
