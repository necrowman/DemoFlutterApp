import 'package:flutter/material.dart';
import 'package:todo_tasks_necrowman/Screen/main_drawer.dart';

class WeightProgress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Color> _colors = [Colors.blueGrey[100], Colors.blueAccent[100]];
    List<double> _stops = [0, 1];
    return Scaffold(
      appBar: AppBar(
        title: Text("Weight Progress")
      ),
      drawer: MainDrawer(),
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
              image: AssetImage("assets/images/floor_scales.jpg")
            )
          ),
          child: Center(
            child: Text("In progress..."),
          ),
        ),
      ),
    );
  }
}