import 'package:flutter/material.dart';
import 'package:leaguetool/pages/home.dart';
import 'package:leaguetool/pages/loading.dart';
import 'package:leaguetool/pages/tier_list.dart';
import 'package:leaguetool/pages/view_summoner.dart';
import 'package:leaguetool/pages/view_tft_summoner.dart';

void main() => runApp(MaterialApp(
  theme: ThemeData(
    fontFamily: 'Montserrat',
    brightness: Brightness.dark,
    primaryColor: Color.fromRGBO(28, 22, 46, 1),
    accentColor: Color.fromRGBO(40, 34, 57, 1),
  ),
  initialRoute: '/home',
  routes: {
        '/': (context) => Loading(),
        '/home': (context) => Home(),
        ViewSummoner.routeName: (context) => ViewSummoner(),
        ViewTFTSummoner.routeName: (context) => ViewTFTSummoner(),
        '/tier_list': (context) => TierList(),
      },
));



