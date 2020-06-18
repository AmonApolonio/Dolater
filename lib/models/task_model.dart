/**
 * Created by Amon Apolonio
 * https://github.com/AmonApolonio
 */

enum TodoStatus { today, later }
enum TodoIsDone {notDone, Done}

class Todo {
  int id;
  int index;
  int status;
  int isDone;
  String title;


  Todo({this.id, this.title, this.index, this.status, this.isDone});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'index': index,
      'status': status,
      'isDone' : isDone,
    };
  }

  Map<String, dynamic> toMapAutoID() {
    return {
      'title': title,
      'index': index,
      'status': TodoStatus.later.index,
      'isDone' : TodoIsDone.notDone.index,
    };
  }
}