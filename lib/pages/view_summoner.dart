import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:leaguetool/services/summoner.dart';

class ViewSummoner extends StatefulWidget {
  static const routeName = '/view_summoner';

  @override
  _ViewSummonerState createState() => _ViewSummonerState();
}

//TODO DISPLAY RANK
class _ViewSummonerState extends State<ViewSummoner> {
  Widget _buildRow(Summoner data, int index) {
    Color getColor(int index) {
      if (data.matches.matches[index].win) {
        return Colors.blue[400];
      }
      else {
        return Colors.red[400];
      }
    }
    CircleAvatar getChampionIcon(String championName) {
      String champ = championName.replaceAll(new RegExp(r"\s+\b|\b\s"), "");
      String path = 'http://ddragon.leagueoflegends.com/cdn/10.6.1/img/champion/$champ.png';
      return CircleAvatar(backgroundImage: NetworkImage(path),
        backgroundColor: Colors.transparent,);
    }
    return Container(
      color: getColor(index),
      child: ListTile(

        leading: Text((() {
          if (data.matches.matches[index].win) {
            return "Victory";
          }
          return "Defeat";
        }()), style: TextStyle(fontWeight: FontWeight.bold)),
        title: Row(

          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(data.matches.matches[index].kills.toString()),
            Text('/'),
            Text(data.matches.matches[index].deaths.toString()),
            Text('/'),
            Text(data.matches.matches[index].assists.toString()),
          ],
        ),
        trailing: getChampionIcon(data.matches.matches[index].championName),
      ),
    );
  }

  Widget _buildRank(Summoner data) {
    return Container();
  }

  Widget _buildMatchHistory(Summoner data) {
    return ListView.builder(
        itemCount: 20,
        padding: const EdgeInsets.all(0),
        itemBuilder: (context, i) {
          return Padding(padding: EdgeInsets.all(8), child: _buildRow(data, i));
        });
  }

  @override
  Widget build(BuildContext context) {
    Summoner data = ModalRoute.of(context).settings.arguments;
    print(data.summonerId);
    if (data.accountId == null || data.summonerName == null) {
      data.accountId = "Summoner Not Found!";
      data.summonerName = "Summoner Not Found!";
    }
    return Scaffold(
      backgroundColor: Colors.deepPurple[700],
      appBar: AppBar(
        title: Text(data.summonerName),
        elevation: 0.0,
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(250, 20, 0, 0),
            child: Column(
              children: <Widget>[
                Text(data.rank.ranks[0].tier,
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text(data.rank.ranks[0].rank,
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(data.rank.ranks[0].lp.toString(),
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('LP', style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                )

              ],
            ),
          ),

          Expanded(
            child:Padding(
              padding: EdgeInsets.fromLTRB(0, 170, 0, 0),
              child: _buildMatchHistory(data),
            ) ,
          )
        ],
      ),
    );
  }
}
