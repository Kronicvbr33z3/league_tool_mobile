import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:leaguetool/services/tft_summoner.dart';

class ViewTFTSummoner extends StatefulWidget {
  static const routeName = '/view_tft_summoner';

  @override
  _ViewTFTSummonerState createState() => _ViewTFTSummonerState();
}
/*TODO Implement a FutureBuilder Widget, Refactor code as necessary.
  1. Shouldn't need line 18 anymore
  2. Implement Future Function that returns an instance of TFT summoner
  3. Make it Look Pretty

  --Should Fix the Lag when changing after you press search
  --Implement this for the league of legends side.

 */
class _ViewTFTSummonerState extends State<ViewTFTSummoner> {
  @override
  Widget build(BuildContext context) {
    TFTSummoner data = ModalRoute.of(context).settings.arguments;

    return Container();
  }
}
