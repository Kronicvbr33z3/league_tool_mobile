import 'dart:convert';
import 'package:http/http.dart';
import 'package:json_annotation/json_annotation.dart';

final String apiKey = 'RGAPI-88da60fc-f70c-446c-9bde-9217be3db585';

class TFTSummoner {
  String tftName;
  String puuid;
  List<Matches> matches;
  int profileIconId;
  int summonerLevel;

  TFTSummoner({this.tftName});

  Future<void> setupTFTSummoner() async {
    //Retrieve Summoner Information
    try {
      Response response = await get(
          'https://na1.api.riotgames.com/tft/summoner/v1/summoners/by-name/$tftName?api_key=$apiKey');
      Map tftSummoner = jsonDecode(response.body);
      puuid = tftSummoner['puuid'];
      profileIconId = tftSummoner['profileIconId'];
      summonerLevel = tftSummoner['summonerLevel'];
    } catch (e) {
      print('Unable to find Summoner!');
    }
    await setupMatchHistory();
  }

  Future<void> setupMatchHistory() async {
    try {
      //Retrieve Match History
      Response response = await get(
          'https://americas.api.riotgames.com/tft/match/v1/matches/by-puuid/$puuid/ids?count=20&api_key=$apiKey');
      Map mhjson = jsonDecode(response.body);
      var list = mhjson as List;
      for (var i = 0; i > 20; i++) {
        matches.add(list[i]);
      }
    } catch (e) {
      print("Unable to retrieve match history");
    }
  }

  Future<void> getMatch(matchId) async {
    try {
      for (var i = 0; i < matches.length; i++) {
        //For Each Match in Match History List retrieve match info
      }
    } catch (e) {}
  }
}

class Matches {
  String matchId;

  Matches({this.matchId});
}

class Match {
  List<Participants> participants;

  Match.fromJson(Map<String, dynamic> json) {
    final _participants = json['participants'];
    for (var i = 0; i < 8; i++) {
      //this.participants.add(Participant.fromJson(_participants[i]));
    }
  }
}

class Participants {
  Participants({this.participant});

  List<Participant> participant;
}

class Participant {
  Participant(this.level, this.units, this.traits, this.puuid,
      {this.placement});

  final String puuid;
  final int placement;
  final int level;
  final List<Units> units;
  final List<Traits> traits;
}

class Units {
  // ignore: non_constant_identifier_names
  Units({
    this.name,
    this.tier,
    this.items,
    this.rarity,
    this.character_id,
  });

  final String name;
  final int tier;
  final List<int> items;
  final int rarity;

  // ignore: non_constant_identifier_names
  final String character_id;
}

class Traits {
  // ignore: non_constant_identifier_names
  Traits({
    this.name,
    this.num_units,
    this.tier_current,
    this.tier_total,
    this.style,
  });

  final String name;

  // ignore: non_constant_identifier_names
  final int num_units;

  // ignore: non_constant_identifier_names
  final int tier_current;

  // ignore: non_constant_identifier_names
  final int tier_total;
  final int style;
}
