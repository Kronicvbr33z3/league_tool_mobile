import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:leaguetool/services/tft_summoner.dart';

class ViewTFTSummoner extends StatefulWidget {
  static const routeName = '/view_tft_summoner';

  @override
  _ViewTFTSummonerState createState() => _ViewTFTSummonerState();
}

class _ViewTFTSummonerState extends State<ViewTFTSummoner> {
  @override
  Widget build(BuildContext context) {
    TFTSummoner data = ModalRoute.of(context).settings.arguments;

    print(data.puuid);

    return Container();
  }
}
