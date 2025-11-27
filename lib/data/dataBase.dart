import 'package:hive/hive.dart';

class Tododatabase {
  List todoList = [];

  final _myBox = Hive.box('todoBox');

  void createInitialData() {
    todoList = [
      // [taskname, taskcompleted]
      ["Upload one YT video", false],
      ["COA Exam preparation", true],
    ];
  }

  void loadData() {
    todoList = _myBox.get("TODOLIST");
  }

  void updateDatabase() {
    _myBox.put("TODOLIST", todoList);
  }
}
