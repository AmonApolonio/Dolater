/**
 * Created by Amon Apolonio
 * https://github.com/AmonApolonio
 */

import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'task_model.dart';


const kTodosStatusToday = 0;
const kTodosStatusLater = 1;

const kTodosNotDone = 0;
const kTodosDone = 1;

var kDatabaseName = "";
const kDatabaseVersion = 1;
const kSQLCreateStatement = '''
CREATE TABLE "todos" (
	 "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	 "title" TEXT NOT NULL,
	 "index" INTERGER NOT NULL,
	 "isDone" INTERGER DEFAULT $kTodosNotDone,
	 "status" integer DEFAULT $kTodosStatusLater
);
''';

const kTableTodos = 'todos';

class DB {
  DB._();
  static final DB sharedInstance = DB._();

  Database _database;
  Future<Database> get database async {
    return _database ?? await initDB();
  }

//function to initiate the database
  Future<Database> initDB() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    kDatabaseName = prefs.getString('userKey');

    Directory docsDirectory = await getApplicationDocumentsDirectory();
    String path = join(docsDirectory.path, kDatabaseName);

    return await openDatabase(path, version: kDatabaseVersion,
        onCreate: (Database db, int version) async {
          await db.execute(kSQLCreateStatement);
        });
  }

//function to create a task on the database 
  void createTodo(Todo todo) async {
    final db = await database;
    await db.insert(kTableTodos, todo.toMapAutoID());
  }

//function to uptade a task on the database 
  void updateTodo(Todo todo) async {
    final db = await database;
    await db
        .update(kTableTodos, todo.toMap(), where: 'id=?', whereArgs: [todo.id]);
  }

//function to delete a task on the database
  void deleteTodo(Todo todo) async {
    final db = await database;
    await db.delete(kTableTodos, where: 'id=?', whereArgs: [todo.id]);
  }

//function to delete all tasks marked as "done" on the database
  void deleteAllDones({int isDone = kTodosDone}) async {
    final db = await database;
    await db.delete(kTableTodos, where: 'isDone=?', whereArgs: [isDone]);
  }

//function to get as tasks on the database
  Future<List<Todo>> retrieveTodos({TodoStatus status = TodoStatus.today}) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(kTableTodos,
        where: 'status=?', whereArgs: [status.index], orderBy: 'id');

    //Code to convert List<Map<String, dynamic>> to List<Todo_object>
    return List.generate(maps.length, (i) {
      return Todo(
        id: maps[i]['id'],
        title: maps[i]['title'],
        index: maps[i]['index'],
        isDone: maps[i]['isDone'],
        status: maps[i]['status'],
      );
    });
  }
}