import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Color> _colors = [Colors.blueGrey[100], Colors.blueAccent[100]];
    List<double> _stops = [0.1, 0.9];
    return Drawer(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: _colors,
                stops: _stops,
              )
          ),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              _mainDrawerHeader(),
              _createDrawerItem(
                icon: Icons.done_outline, 
                text: "ToDo list",
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/todo_list');
                }
              ),
              _createDrawerItem(
                icon: Icons.network_check, 
                text: "Weigt progress",
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/weight_progress');
                }
              ),
              Divider(),
              ListTile(
                title: Text("Version 0.0.1"),
                onTap: () {

                },
              )
            ],
          ),
        ),
      );
  }

  DrawerHeader _mainDrawerHeader() {
    return DrawerHeader(
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/images/drawer_header.png"),
              )
            ),
            child: Stack(
              children: [
                Positioned(
                  bottom: 12.0,
                  left: 20.0,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      gradient: LinearGradient(
                        colors: [Colors.green.withOpacity(0.7), Colors.blue.withOpacity(0.7)],
                        stops: [0.0, 1.0],
                      ),  
                    ),
                    padding: EdgeInsets.all(10.0),
                    child: Text("HealthyMind Co.",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
  }

  Widget _createDrawerItem({IconData icon, String text, GestureTapCallback onTap}) {
    return ListTile(
      title: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(icon),
              Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(text),
              ),
            ],
          ),
        ),
      ),
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: onTap,
    );
  }
}