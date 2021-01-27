import 'dart:io';

import 'package:flutter/material.dart';
import 'package:leaguetool/pages/home.dart';
import 'package:leaguetool/pages/loading.dart';
import 'package:leaguetool/pages/tier_list.dart';
import 'package:leaguetool/pages/view_analyzed_match.dart';
import 'package:leaguetool/pages/view_summoner.dart';
import 'package:leaguetool/pages/view_tft_summoner.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

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
        ViewAnalyzedMatch.routeName: (context) => ViewAnalyzedMatch(),
        '/tier_list': (context) => TierList(),
      },
    ));



