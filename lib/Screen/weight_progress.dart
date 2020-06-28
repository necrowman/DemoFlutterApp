import 'dart:math';

import 'package:flutter/material.dart';
import 'package:todo_tasks_necrowman/Models/weight_save.dart';
import 'package:todo_tasks_necrowman/Screen/main_drawer.dart';
import 'package:todo_tasks_necrowman/View/weight_list_item.dart';

class WeightProgress extends StatefulWidget {
  @override
  _WeightProgressState createState() => _WeightProgressState();
}

class _WeightProgressState extends State<WeightProgress> {
  final List<String> strings = <String>["Simple element"];
  List<WeightSave> weightSaves = [];
  int _selectedSegment = 0;

  void _changeSegment(int segment) {
    setState(() {
      _selectedSegment = segment;
    });
  }

  void _addWeightEntry() {
    setState(() {
      strings.add("New value");
      weightSaves.add(
        WeightSave(
          DateTime.now(),
          Random().nextInt(100).toDouble()
        )
      );
    });
  }

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
          child: Column(
            children: [
              Container(
                height: 105,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.green[200].withOpacity(0.75), Colors.blue[200].withOpacity(0.75)],
                    stops: [0.1, 0.9],
                  )
                ),
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: RaisedButton(
                        color: Colors.transparent,
                        onPressed: () {
                          _changeSegment(0);
                        },
                        child: Column(
                          children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 25),
                            child: Icon(
                              Icons.trending_up,
                              color: Colors.white.withOpacity((_selectedSegment == 0) ? 1 : 0.5),),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 25.0),
                            child: Text(
                              "STATISTIC", 
                              style: TextStyle(color: Colors.white.withOpacity((_selectedSegment == 0) ? 1 : 0.5),),),
                          ),
                          Positioned(
                            left: 0,
                            right: 0,
                            bottom: 0,
                            child: Container(
                              height: 5.0,
                              color: Colors.white.withOpacity((_selectedSegment == 0) ? 1 : 0.5),
                            )
                          )
                        ],),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: RaisedButton(
                        color: Colors.transparent,
                        onPressed: () {
                          _changeSegment(1);
                        },
                        child: Column(
                          children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 25),
                            child: Icon(
                              Icons.history,
                              color: Colors.white.withOpacity((_selectedSegment == 1) ? 1 : 0.5)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 25.0),
                            child: Text(
                              "HISTORY", 
                              style: TextStyle(color: Colors.white.withOpacity((_selectedSegment == 1) ? 1 : 0.5)),),
                          ),
                          Positioned(
                            left: 0,
                            right: 0,
                            bottom: 0,
                            child: Container(
                              height: 5.0,
                              color: Colors.white.withOpacity((_selectedSegment == 1) ? 1 : 0.5),
                            )
                          )
                        ],),
                      ),
                    )

                  ]
                ),
              ),
              ((_selectedSegment == 0) ?
              _buildStatistic() :
              Expanded(child: _buildHistoryList())),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _addWeightEntry();
        }),
    );
  }

  Center _buildStatistic() {
    return Center(
              child: Text("Statistic\nin progress..."),
            );
  }

  Widget _buildHistoryList() {
    return Center(
      child: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          
          if (index == 0) {
            return Container(height: 16,);
          } else if (index == strings.length) {
            return Container(height: 20,);
          } else {
            WeightSave weightSave = weightSaves[index - 1];
            double difference = ((index == 1) ? 
              0 : 
              weightSave.weight - weightSaves[index - 2].weight);
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.green[200].withOpacity(0.75), 
                        Colors.blue[200].withOpacity(0.75)],
                      stops: [0.2, 0.5],
                    )
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: WeightListItem(
                      weightSave: weightSave, 
                      weightDifference: difference,
                    )
                  ),
                )
              ),
            );
          }
        },
        separatorBuilder: (BuildContext context, int index) {
          if (index == 0 || index == weightSaves.length) {
            return Container();
          }
          return const Divider();
        },
        itemCount: weightSaves.length + 2,
        ),
    );
  }
}