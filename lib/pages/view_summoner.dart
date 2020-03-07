import 'package:flutter/material.dart';
import 'package:leaguetool/services/summoner.dart';

class ViewSummoner extends StatefulWidget {
  static const routeName = '/view_summoner';
  @override
  _ViewSummonerState createState() => _ViewSummonerState();
}

//TODO MAKE EVERYHTING PRETTY
class _ViewSummonerState extends State<ViewSummoner> {
  Widget _buildRow(Summoner data, int index) {
    return ListTile(
      leading: Icon(Icons.face),
      title: Text(data.matches.matches[index].championName),
    );
  }

  Widget _buildMatchHistory(Summoner data) {
    return ListView.builder(
        itemCount: 20,
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          return _buildRow(data, i);

          return Container();
        });
  }

  @override
  Widget build(BuildContext context) {
    Summoner data = ModalRoute.of(context).settings.arguments;
    print(data.accountId);
    if (data.accountId == null || data.summonerName == null) {
      data.accountId = "Summoner Not Found!";
      data.summonerName = "Summoner Not Found!";
    }
    return Scaffold(
      backgroundColor: Colors.purple[900],
      appBar: AppBar(
        title: Text(data.summonerName),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(0, 200, 0, 0),
        child: _buildMatchHistory(data),
      ),
    );
  }
}
