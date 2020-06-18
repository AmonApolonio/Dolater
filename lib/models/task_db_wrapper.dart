/**
 * Created by Amon Apolonio
 * https://github.com/AmonApolonio
 */

import 'task_model.dart';
import 'task_db.dart';

class DBWrapper {
  static final DBWrapper sharedInstance = DBWrapper._();

  DBWrapper._();

  Future<List<Todo>> getTodays() async {
    List list = await DB.sharedInstance.retrieveTodos();
    return list;
  }

  Future<List<Todo>> getLaters() async {
    List list = await DB.sharedInstance.retrieveTodos(status: TodoStatus.later);
    return list;
  }

  void addTodo(Todo todo) async {
    await DB.sharedInstance.createTodo(todo);
  }

  void markTodayAsLater(Todo todo) async {
    todo.status = TodoStatus.later.index;
    await DB.sharedInstance.updateTodo(todo);
  }

  void markLaterAsToday(Todo todo) async {
    todo.status = TodoStatus.today.index;
    await DB.sharedInstance.updateTodo(todo);
  }
  
  void markAsDone(Todo todo) async{
    todo.isDone = TodoIsDone.Done.index;
    await DB.sharedInstance.updateTodo(todo);
  }

  void markAsNotDone(Todo todo) async{
    todo.isDone = TodoIsDone.notDone.index;
    await DB.sharedInstance.updateTodo(todo);
  }

  void deleteTodo(Todo todo) async {
    await DB.sharedInstance.deleteTodo(todo);
  }

  void deleteAllDones() async {
    await DB.sharedInstance.deleteAllDones();
  }

  void uptadeIndex(Todo todo) async {
    await DB.sharedInstance.updateTodo(todo);
  }

}
