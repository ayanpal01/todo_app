import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo/data/database.dart';
import 'package:todo/util/dialog_box.dart';
import 'package:todo/util/edit_dialog_box.dart';
import 'package:todo/util/todo_tile.dart';
import 'package:todo/util/app_drawer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Tododatabase db = Tododatabase();

  final _myBox = Hive.box('todoBox');
  String sortOrder = 'newest'; // 'newest', 'oldest', or 'all'

  @override
  void initState() {
    super.initState();
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
      db.updateDatabase();
    } else {
      db.loadData();
    }
    db.sortByDateDesc(); // Sort by newest first by default
  }

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.todoList[index][1] = !db.todoList[index][1];
    });
    db.updateDatabase();
  }

  final _controller = TextEditingController();

  void savenewTask() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        db.todoList.add([
          _controller.text,
          false,
          DateTime.now().toIso8601String(),
        ]);
        _controller.clear();
        Navigator.of(context).pop();
        if (sortOrder == 'newest') {
          db.sortByDateDesc();
        } else if (sortOrder == 'oldest') {
          db.sortByDateAsc();
        }
        db.updateDatabase();
      });
    }
  }

  void createnewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: savenewTask,
          onCancel: () {
            Navigator.of(context).pop();
            _controller.clear();
          },
        );
      },
    );
  }

  void editTask(int index) {
    _controller.text = db.todoList[index][0];
    showDialog(
      context: context,
      builder: (context) {
        return EditDialogBox(
          controller: _controller,
          onSave: () {
            if (_controller.text.isNotEmpty) {
              setState(() {
                db.todoList[index][0] = _controller.text;
                _controller.clear();
                Navigator.of(context).pop();
                db.updateDatabase();
              });
            }
          },
          onCancel: () {
            Navigator.of(context).pop();
            _controller.clear();
          },
        );
      },
    );
  }

  void deleteTTask(int index) {
    setState(() {
      db.todoList.removeAt(index);
      db.updateDatabase();
    });
  }

  void changeSortOrder(String order) {
    setState(() {
      sortOrder = order;
      if (order == 'newest') {
        db.sortByDateDesc();
      } else if (order == 'oldest') {
        db.sortByDateAsc();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      drawer: AppDrawer(
        db: db,
        sortOrder: sortOrder,
        onSortChanged: changeSortOrder,
        onClearCompleted: () {
          setState(() {
            db.todoList.removeWhere((task) => task[1] == true);
            db.updateDatabase();
          });
        },
        onClearAll: () {
          setState(() {
            db.todoList.clear();
            db.updateDatabase();
          });
        },
      ),
      appBar: AppBar(
        title: const Text(
          "TODO",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        backgroundColor: Colors.blue,
        elevation: 10,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                if (sortOrder == 'newest') {
                  db.sortByDateDesc();
                } else if (sortOrder == 'oldest') {
                  db.sortByDateAsc();
                }
              });
            },
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: db.todoList.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.task_alt, size: 100, color: Colors.blue[300]),
                  const SizedBox(height: 20),
                  Text(
                    'No tasks yet!',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Tap + to add a new task',
                    style: TextStyle(fontSize: 16, color: Colors.grey[500]),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: db.todoList.length,
              itemBuilder: (context, index) {
                return TodoTile(
                  taskname: db.todoList[index][0],
                  taskCompleted: db.todoList[index][1],
                  createdDate: db.todoList[index][2],
                  onChanged: (value) {
                    checkBoxChanged(value, index);
                  },
                  editTask: (context) => editTask(index),
                  deleteTask: (context) => deleteTTask(index),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          createnewTask();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
