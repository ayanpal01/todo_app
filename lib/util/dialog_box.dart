import 'package:flutter/material.dart';
import 'package:todo/util/button.dart';

class DialogBox extends StatelessWidget {
  final controller;
  DialogBox({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.blue,
      content: Container(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Add a new task",
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MyButton(text: "Cancel", onPressed: () {}),
                SizedBox(width: 10),
                MyButton(text: "Save", onPressed: () {}),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
