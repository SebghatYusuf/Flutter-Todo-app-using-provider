import 'package:provider_test/models/task.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;

  String table = 'todo_table';
  String colId = 'id';
  String colName = 'name';
  String colComplete = 'completed';

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'todos.db';

    var myDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
    return myDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $table($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colName TEXT, '
        '$colComplete TEXT)');
  }

  Future<List<Map<String, dynamic>>> getTaskMapList() async {
    Database db = await this.database;
    var result = await db.query(table, orderBy: "$colId ASC");
    return result;
  }

  // Insert operation: Insert to database
  Future<int> insertTask(Task task) async {
    Database db = await this.database;
    var result = await db.insert(table, task.toMap());
    return result;
  }

  Future<int> updateTask(Task task) async {
    var db = await this.database;
    var result = await db
        .update(table, task.toMap(), where: '$colId = ?', whereArgs: [task.id]);
    return result;
  }

  Future<int> deleteTask(int id) async {
    var db = await this.database;
    int result = await db.delete(table, where: '$colId = ?', whereArgs: [id]);
    return result;
  }

  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $table');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<List<Task>> getTaskList() async {
    var taskMapList = await getTaskMapList();
    int count = await getCount();

    List<Task> taskList = List<Task>();
    // For loop to create a Task list from a Map List
    for (int i = 0; i < count; i++) {
      taskList.add(Task.fromMap(taskMapList[i]));
    }
    return taskList;
  }
}
