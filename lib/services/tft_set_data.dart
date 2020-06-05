import 'dart:async' show Future;
import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

Future<String> loadChampion() async {
  return await rootBundle.loadString('assets/tft/champions.json');
}

void parseJson() async {
  var jsonString = await loadChampion();
  var json = jsonDecode(jsonString);
  for (var i = 0; i < json.length; i++) {
    ChampionData.champions.add(Champion.fromJson(json[i]));
  }
}

class ChampionData {
  static List<Champion> champions = [];

  static void init() {
    parseJson();
  }
}

class Champion {
  String name;
  String championId;
  int cost;
  List<String> traits;

  Champion.fromJson(Map<String, dynamic> json) {
    this.traits = [];
    this.name = json['name'];
    this.championId = json['championId'];
    this.cost = json['cost'];
    var _traits = json['traits'];
    for (var i = 0; i < _traits.length; i++) {
      this.traits.add(_traits[i]);
    }
  }
}
