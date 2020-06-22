import 'package:flutter/material.dart';
import 'package:todo_tasks_necrowman/Screen/todo_list.dart';
import 'package:todo_tasks_necrowman/Screen/weight_progress.dart';

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
      initialRoute: '/todo_list',
      routes: {
        '/todo_list': (BuildContext context) => TodoList(),
        '/weight_progress': (BuildContext context) => WeightProgress()
      },
    );
  }
}
