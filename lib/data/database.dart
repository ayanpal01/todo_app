import 'package:hive/hive.dart';

class Tododatabase {
  List todoList = [];

  final _myBox = Hive.box('todoBox');

  void createInitialData() {
    todoList = [
      // [taskname, taskcompleted, createdDate]
      ["Upload one YT video", false, DateTime.now().toIso8601String()],
      ["COA Exam preparation", true, DateTime.now().toIso8601String()],
    ];
  }

  void loadData() {
    List loadedData = _myBox.get("TODOLIST");
    // Migrate old data format to new format with creation date
    todoList = loadedData.map((task) {
      if (task.length == 2) {
        // Old format: [taskname, completed]
        return [task[0], task[1], DateTime.now().toIso8601String()];
      } else {
        // New format: [taskname, completed, createdDate]
        return task;
      }
    }).toList();
    // Save migrated data
    updateDatabase();
  }

  void updateDatabase() {
    _myBox.put("TODOLIST", todoList);
  }

  // Sort todos by creation date (newest first)
  void sortByDateDesc() {
    todoList.sort((a, b) {
      DateTime dateA = DateTime.parse(a[2]);
      DateTime dateB = DateTime.parse(b[2]);
      return dateB.compareTo(dateA);
    });
  }

  // Sort todos by creation date (oldest first)
  void sortByDateAsc() {
    todoList.sort((a, b) {
      DateTime dateA = DateTime.parse(a[2]);
      DateTime dateB = DateTime.parse(b[2]);
      return dateA.compareTo(dateB);
    });
  }

  // Get statistics
  int getTotalTasks() => todoList.length;

  int getCompletedTasks() => todoList.where((task) => task[1] == true).length;

  int getPendingTasks() => todoList.where((task) => task[1] == false).length;
}
