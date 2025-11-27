import 'package:flutter/material.dart';

class Todo extends StatefulWidget {
  const Todo({super.key});

  @override
  State<Todo> createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  TextEditingController myController = TextEditingController();

  String greetingmessage = "";
  void greetUser() {
    setState(() {
      greetingmessage = "Hello ${myController.text}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                greetingmessage,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: myController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Enter Your TAsk",
                  hintText: "Eg. Do work",
                ),
              ),
              ElevatedButton(onPressed: greetUser, child: Text("Tap Me")),
            ],
          ),
        ),
      ),
    );
    ;
  }
}
