import 'package:flutter/material.dart';
import 'package:leaguetool/pages/league_home_screen.dart';
import 'package:leaguetool/pages/tft_home_screen.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    LeagueHomeScreen(),
    TFTHomeScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
    onWillPop: () async => false,
    child: new Scaffold(
      backgroundColor: Colors.deepPurple[700],
      appBar: AppBar(
        leading: new Container(),
        title: Text('Made by Luis :)'),
        centerTitle: true,
        backgroundColor: Colors.grey[900],
        elevation: 0.0,
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          onTap: onTabTabbed,
          currentIndex: _currentIndex,
          backgroundColor: Colors.grey[900],
          elevation: 0,
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.home),
              title: new Text('League'),
          ),
            BottomNavigationBarItem(
                icon: new Icon(Icons.offline_bolt),
                title: new Text('TFT')
            )
          ]
      ),
    )
    );
  }

  void onTabTabbed(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
