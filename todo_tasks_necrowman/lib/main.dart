import 'package:flutter/material.dart';
import 'package:todo_tasks_necrowman/Screen/todo_list.dart';

void main() => runApp(TodoApp());

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List Checker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,//Accent[200],
      ),
      home: TodoList(),
    );
  }
}
