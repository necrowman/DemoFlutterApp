import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_tasks_necrowman/Utils/database_helper.dart';
import 'package:todo_tasks_necrowman/Models/todo.dart';

class TodoDetail extends StatefulWidget {
  final String appBarTitle;
  final Todo todo;

  TodoDetail(this.todo, this.appBarTitle);

  @override
  _TodoDetailState createState() =>
      _TodoDetailState(this.todo, this.appBarTitle);
}

class _TodoDetailState extends State<TodoDetail> {
  DatabaseHelper helper = DatabaseHelper();

  String appBarTitle;
  Todo todo;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  _TodoDetailState(this.todo, this.appBarTitle);

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.headline6;
    titleController.text = todo.title;
    descriptionController.text = todo.description;

    return WillPopScope(
      onWillPop: () {
        moveToLastScreen();
        return;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(appBarTitle),
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                moveToLastScreen();
              }),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 16, left: 8, right: 8),
          child: ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 4, bottom: 4),
                child: TextField(
                  controller: titleController,
                  style: textStyle,
                  onChanged: (value) {
                    updateTitle();
                  },
                  decoration: InputDecoration(
                    labelText: 'Todo title',
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8, bottom: 8),
                child: TextField(
                  controller: descriptionController,
                  style: textStyle,
                  onChanged: (value) {
                    updateDescription();
                  },
                  decoration: InputDecoration(
                    labelText: 'Todo description',
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8, bottom: 8),
                child: Row(children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: Text(
                        'Save',
                        textScaleFactor: 1.5,
                      ),
                      onPressed: () {
                        setState(() {
                          _save();
                        });
                      },
                    ),
                  ),
                  Container(width: 8),
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: Text(
                        'Delete',
                        textScaleFactor: 1.5,
                      ),
                      onPressed: () {
                        setState(() {
                          _delete();
                        });
                      },
                    ),
                  )
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  // Update the title of todo object
  void updateTitle() {
    todo.title = titleController.text;
  }

  // Update the description of todo object
  void updateDescription() {
    todo.description = descriptionController.text;
  }

  // Save data to database
  void _save() async {
    print('Save started');
    moveToLastScreen();
    todo.date = DateFormat.yMMMd().format(DateTime.now());
    print('Date updated');
    print(todo.id);
    print(todo.title);
    print(todo.date);
    print(todo.description);
    print((todo.id != null));
    print((todo.id == null));
    int result;
    if (todo.id != null) {
      // update
      print('update');
      result = await helper.updateTodo(todo);
      
    } else {
      // insert
      print('insert');
      result = await helper.insertTodo(todo);
    }

    print(result);
    // check result
    if (result != 0) {
      // Success case
      print('Success case');
      _showAlertDialog('Status', 'Todo Saved Successfully');
    } else {
      // Failure case
      print('Failure case');
      _showAlertDialog('Status', 'Problem Saving Todo.\nTry again.');
    }
  }

  void _delete() async {
    moveToLastScreen();
    if (todo.id == null) {
      _showAlertDialog('Status', 'No Todo was deleted');
      return;
    }

    int result = await helper.deleteTodo(todo.id);
    if (result != 0) {
      _showAlertDialog('Status', 'Todo Deleted Successfully');
    } else {
      _showAlertDialog('Status', 'Error Occured while Deleting Todo');
    }
  }

  void _showAlertDialog(String title, String message) {
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(
      context: context,
      builder: (_) => alert,
    );
  }
}
