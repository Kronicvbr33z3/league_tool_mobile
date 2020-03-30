import 'package:flutter/material.dart';
import 'package:leaguetool/pages/home.dart';
import 'package:leaguetool/pages/loading.dart';
import 'package:leaguetool/pages/tier_list.dart';
import 'package:leaguetool/pages/view_summoner.dart';

void main() => runApp(MaterialApp(
  theme: ThemeData(fontFamily: 'Gotu'),
  initialRoute: '/home',
  routes: {
    '/': (context) => Loading(),
    '/home': (context) => Home(),
    ViewSummoner.routeName: (context) => ViewSummoner(),
    '/tier_list': (context) => TierList(),
  },
));



