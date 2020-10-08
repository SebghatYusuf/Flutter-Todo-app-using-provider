import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper with ChangeNotifier {
  static final tableName = 'tasks_table';
  sql.Database db;

  DBHelper() {
    // this will run when provider is instantiate the first time
    print("DB HELPER intit");
    init();
  }

  void init() async {
    final dbPath = await sql.getDatabasesPath();
    db = await sql.openDatabase(
      path.join(dbPath, 'tasks.db'),
      onCreate: (db, version) {
        final stmt =
            """CREATE TABLE IF NOT EXISTS $tableName (id TEXT PRIMARY KEY, name TEXT, completed TEXT)
        """
                .trim()
                .replaceAll(RegExp(r'[\s]{2,}'), " ");
        return db.execute(stmt);
      },
      version: 1,
    );
    notifyListeners();
  }

  Future<void> insert(String table, Map<String, dynamic> data) async {
    await db.insert(table, data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> getData(String table) async {
    return await db.query(table);
  }
}
