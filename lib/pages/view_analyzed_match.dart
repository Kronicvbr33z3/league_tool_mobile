import 'package:flutter/material.dart';
import 'package:leaguetool/services/analyze_match.dart';

import 'view_summoner.dart';

class ViewAnalyzedMatch extends StatelessWidget {
  static const routeName = '/view_analyzed_match';

  @override
  Widget build(BuildContext context) {
    final RouteArguments args = ModalRoute.of(context).settings.arguments;
    final int index = args.index;

    //Analyze The Match
    AnalyzeMatch analyzedMatch = AnalyzeMatch(args.data, index);

    Text getAward(AnalyzeMatch match) {
      return Text(match.awards[0].description);
    }

    return Scaffold(
      backgroundColor: Color.fromRGBO(28, 22, 46, 1),
      appBar: AppBar(
        title: Text(
          "Match Analysis",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0.0,
        backgroundColor: Color.fromRGBO(28, 22, 46, 1),
      ),
      body: getAward(analyzedMatch),
    );
  }
}
