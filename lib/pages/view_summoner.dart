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
      //print(data.matches.matches[index].participants.gameDuration / 60);
      if (data.matches.matches[index].win) {
        return Color.fromRGBO(65, 111, 201, 1);
      }
      else {
        return Color.fromRGBO(184, 88, 88, 1);
      }
    }
    CircleAvatar getChampionIcon(String championName) {
      String champ = championName.replaceAll(new RegExp(r"\s+\b|\b\s"), "");
      String path = 'http://ddragon.leagueoflegends.com/cdn/10.6.1/img/champion/$champ.png';
      return CircleAvatar(backgroundImage: NetworkImage(path),
        backgroundColor: Colors.transparent,);
    }
    String getKDA() {
      double kda;
      kda = (data.matches.matches[index].kills +
          data.matches.matches[index].assists) /
          (data.matches.matches[index].deaths);
      String skda = kda.toStringAsFixed(3);
      String n = ":1";
      var finalKDA = "$skda$n KDA";
      return finalKDA;
    }
    String getMinuteString(double decimalValue) {
      return '${(decimalValue * 60).toInt()}'.padLeft(2, '0');
    }

    String getHourString(int flooredValue) {
      return '${flooredValue % 60}'.padLeft(2, '0');
    }
    String getGameDuration() {
      double gameDuration = data.matches.matches[index].participants
          .gameDuration / 60;
      int flooredValue = gameDuration.floor();
      double decimalValue = gameDuration - flooredValue;
      String hourValue = getHourString(flooredValue);
      String minuteString = getMinuteString(decimalValue);

      return '$hourValue:$minuteString';
    }

    return Container(
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        color: getColor(index),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(5),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text((() {
            if (data.matches.matches[index].win) {
              return "Victory";
            }
            return "Defeat";
          }()), style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18)),
        ),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(width: 15,),
            Text(data.matches.matches[index].kills.toString(), style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 18),),
            Text('/', style: TextStyle(fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 18)),
            Text(data.matches.matches[index].deaths.toString(),
                style: TextStyle(fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 18)),
            Text('/', style: TextStyle(fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 18)),
            Text(data.matches.matches[index].assists.toString(),
                style: TextStyle(fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 18)),


          ],
        ),
        subtitle: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(width: 5,),
            Text(getKDA(), style: TextStyle(fontWeight: FontWeight.w600),),
            SizedBox(width: 80,),
            Spacer(flex: 1),
            Text(getGameDuration()),
          ],
        ),
        trailing: getChampionIcon(data.matches.matches[index].championName),
      ),
    );
  }

  Widget _buildRankInfo(Summoner data) {
    return Column(
      children: <Widget>[
        Text(data.rank.ranks[0].queueType,
            style: TextStyle(fontWeight: FontWeight.bold)),
        Text(data.rank.ranks[0].tier,
            style: TextStyle(fontWeight: FontWeight.bold)),
        Text(data.rank.ranks[0].rank,
            style: TextStyle(fontWeight: FontWeight.bold)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(data.rank.ranks[0].lp.toString() ?? "Not Found",
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text('LP', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        )

      ],
    );
  }
  Widget _buildRank(Summoner data) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              color: Color.fromRGBO(43, 38, 60, 1),),
            margin: EdgeInsets.fromLTRB(300, 0, 10, 0),
            child: _buildRankInfo(data),
          ),
        ),
      ],
    );
  }

  Widget _buildMatchHistory(Summoner data) {
    return ListView.builder(
        itemCount: 20,
        padding: const EdgeInsets.all(0),
        itemBuilder: (context, i) {
          return Padding(padding: EdgeInsets.fromLTRB(6, 0, 6, 8),
              child: _buildRow(data, i));
        });
  }

  @override
  Widget build(BuildContext context) {
    Summoner data = ModalRoute
        .of(context)
        .settings
        .arguments;
    if (data.accountId == null || data.summonerName == null ||
        data.matches == null || data.rank == null) {
      return Scaffold(
          appBar: AppBar(
            title: Text("Summoner Not Found"),
          ),
          body: Container(
            decoration: BoxDecoration(

            ),
          )
      );
    } else {
      // If Summoner Is Found And Everything Loaded Correctly
      return Scaffold(
        backgroundColor: Color.fromRGBO(28, 22, 46, 1),
        appBar: AppBar(
          title: Text(
              data.summonerName, style: TextStyle(fontWeight: FontWeight.bold)),
          elevation: 0.0,
          backgroundColor: Color.fromRGBO(28, 22, 46, 1),
        ),
        body: Column(
          children: <Widget>[
            Divider(color: Color.fromRGBO(43, 38, 60, 1), thickness: 2,),
            _buildRank(data),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: _buildMatchHistory(data),
              ),
            ),
            //Divider(color: Color.fromRGBO(43, 38, 60, 1), thickness: 2,),
          ],
        ),
      );
    }
  }
}

