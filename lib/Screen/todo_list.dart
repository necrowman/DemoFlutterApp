import 'dart:async';
import 'package:flutter/material.dart';
import 'package:todo_tasks_necrowman/Models/todo.dart';
import 'package:todo_tasks_necrowman/Screen/main_drawer.dart';
import 'package:todo_tasks_necrowman/Utils/database_helper.dart';
import 'package:todo_tasks_necrowman/Screen/todo_detail.dart';
import 'package:sqflite/sqflite.dart';

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}


class _TodoListState extends State<TodoList> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Todo> todoList;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (todoList == null) {
      todoList = List<Todo>();
      updateListView();
    }
    List<Color> _colors = [Colors.blueGrey[100], Colors.blueAccent[100]];
    List<double> _stops = [0, 1];
    return  Scaffold(
      appBar: AppBar(
        title: Text('Todos'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: _colors,
            stops: _stops,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.1), 
              BlendMode.dstATop),
              fit: BoxFit.cover,
              image: AssetImage("assets/images/diary.jpg")
            )
          ),
          child: getTodoListView()
        )
      ),
      drawer: MainDrawer(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            navigateToDetail(Todo('', '', ''), 'Add todo');
          },
          tooltip: 'Add todo',
          child: Icon(Icons.add),
        ),
      );
  }

  ListView getTodoListView() {
    List<Color> _colors = [Colors.yellow[100], Colors.cyanAccent[200]];
    List<double> _stops = [0.1, 0.9];
    return ListView.builder(
        itemCount: count,
        itemBuilder: (BuildContext context, int position) {
          return Card(
            elevation: 5,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: _colors,
                  stops: _stops,
                ),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.green[400],
                  child: Text(
                    getFirstLetter(this.todoList[position].title),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                title: Text(this.todoList[position].title,
                    style: TextStyle(fontWeight: FontWeight.w400)),
                subtitle: Text(this.todoList[position].description),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    GestureDetector(
                      child: Icon(Icons.delete, color: Colors.red),
                      onTap: () {
                        _delete(context, todoList[position]);
                      },
                    )
                  ],
                ),
                onTap: () {
                  debugPrint("ListTile tapped");
                  navigateToDetail(this.todoList[position], 'Edit Todo');
                },
              ),
            ),
          );
        });
  }

  getFirstLetter(String title) {
    
    return title.substring(0, 2).toUpperCase();
  }

  void _delete(BuildContext context, Todo todo) async {
    int result = await databaseHelper.deleteTodo(todo.id);
    if (result != 0) {
      _showSnackBar(context, 'Todo Deleted Successfully');
      updateListView();
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void navigateToDetail(Todo todo, String title) async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return TodoDetail(todo, title);
    }));
    if (result == true) {
      updateListView();
    }
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Todo>> todoListFuture = databaseHelper.getTodoList();
      todoListFuture.then((todoList) {
        setState(() {
          this.todoList = todoList;
          this.count = todoList.length;
        });
      });
    });
  }
}
