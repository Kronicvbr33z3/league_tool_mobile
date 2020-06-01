import 'package:flutter/material.dart';
import 'package:leaguetool/pages/league_home_screen.dart';
import 'package:leaguetool/pages/tft_home_screen.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  NetworkImage getImage(index) {
    if (index == 0) {
      return NetworkImage(
          //Background Image
          'https://media.comicbook.com/2017/06/skt-2017-1004526.jpg');
    }
    return NetworkImage(
        //Background Image
        'https://images.contentstack.io/v3/assets/blt731acb42bb3d1659/bltfe81204b8ec63e0e/5e6184a918d3347ceffbbd6d/TFT.S3_GALAXIES.ARTICLE-2.jpg');
  }

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
          appBar: AppBar(
            leading: new Container(),
            title: Text((() {
              if (_currentIndex == 0) {
                return "League of Legends";
              }
              return "Teamfight Tactics";
            }()),
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            centerTitle: true,
            backgroundColor: Color.fromRGBO(28, 22, 46, 1),
            elevation: 0.0,
          ),
          body: Container(decoration: BoxDecoration(
              image: DecorationImage(
                  image: getImage(_currentIndex),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(.2), BlendMode.dstATop)
              )
          ), child: _children[_currentIndex]),
          bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.deepPurple,
              onTap: onTabTabbed,
              currentIndex: _currentIndex,
              backgroundColor: Color.fromRGBO(28, 22, 46, 1),
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
