import 'dart:convert';
import 'package:http/http.dart';

final String apiKey = 'RGAPI-28342400-52d0-4af5-a168-aba1e7d51b8d';

class TFTSummoner {
  String tftName;
  String puuid;
  List<Match> matches;
  int profileIconId;
  int summonerLevel;

  TFTSummoner({this.tftName});

  Future<void> setupTFTSummoner() async {
    //Retrieve Summoner Information
    await setupSummoner();
    await setupMatchHistory();
  }

  Future<void> setupSummoner() async {
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
  }

  Future<void> setupMatchHistory() async {
    try {
      //Retrieve Match History
      matches = [];
      Response response = await get(
          'https://americas.api.riotgames.com/tft/match/v1/matches/by-puuid/$puuid/ids?count=20&api_key=$apiKey');
      var mhjson = jsonDecode(response.body);
      for (var i = 0; i < mhjson.length; i++) {
        var matchId = mhjson[i];
        Response response = await get(
            'https://americas.api.riotgames.com/tft/match/v1/matches/$matchId?api_key=$apiKey');
        var json = jsonDecode(response.body);
        matches.add(Match.fromJson(json));
      }
    } catch (e) {
      print("Unable to retrieve match history");
    }
  }
}

class Match {
  List<Participant> participants;

  Match.fromJson(Map<String, dynamic> json) {
    final _info = json['info'];
    participants = [];
    var _participants = _info['participants'];
    for (var i = 0; i < 8; i++) {
      Participant.fromJson(_participants[i]);
    }
  }
}

class Participant {
  String puuid;
  int placement;
  int level;
  List<Units> units;
  List<Traits> traits;

  Participant.fromJson(Map<String, dynamic> json) {
    this.puuid = json['puuid'];
    this.placement = json['placement'];
    this.level = json['level'];
    this.units = [];
    this.traits = [];
    var _units = json['units'];
    var _traits = json['traits'];
    for (var i = 0; i < _units.length; i++) {
      this.units.add(Units.fromJson(_units[i]));
    }
    for (var i = 0; i < _traits.length; i++) {
      this.traits.add(Traits.fromJson(_traits[i]));
    }
  }
}

class Units {
  // ignore: non_constant_identifier_names
  String name;
  int tier;
  List<int> items;
  int rarity;

  // ignore: non_constant_identifier_names
  String character_id;

  Units.fromJson(Map<String, dynamic> json) {
    this.items = [];
    this.name = json['name'];
    this.tier = json['tier'];
    this.rarity = json['rarity'];
    this.character_id = json['character_id'];
    var _items = json['items'];
    for (var i = 0; i < _items.length; i++) {
      this.items.add(_items[i]);
    }
  }
}

class Traits {
  // ignore: non_constant_identifier_names
  String name;

  // ignore: non_constant_identifier_names
  int num_units;

  // ignore: non_constant_identifier_names
  int tier_current;

  // ignore: non_constant_identifier_names
  int tier_total;
  int style;

  Traits.fromJson(Map<String, dynamic> json) {
    this.name = json['name'];
    this.num_units = json['num_units'];
    this.tier_current = json['tier_current'];
    this.tier_total = json['tier_current'];
    this.style = json['style'];
  }
}
