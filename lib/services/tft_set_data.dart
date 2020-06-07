import 'dart:async' show Future;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

Future<String> loadChampion() async {
  return await rootBundle.loadString('assets/tft/champions.json');
}

Future<String> loadItems() async {
  return await rootBundle.loadString('assets/tft/items.json');
}

Future<String> loadTraits() async {
  return await rootBundle.loadString('assets/tft/traits.json');
}

class ChampionData {
  List<Champion> champions = [];
  List<Item> items = [];
  List<Trait> traits = [];
  Map<String, Champion> data = {};

  ChampionData() {
    init();
  }

  void init() async {
    var jsonString = await loadChampion();
    var json = jsonDecode(jsonString);
    for (var i = 0; i < json.length; i++) {
      champions.add(Champion.fromJson(json[i]));
    }
    var itemJsonString = await loadItems();
    var itemJson = jsonDecode(itemJsonString);
    for (var i = 0; i < itemJson.length; i++) {
      items.add(Item.fromJson(itemJson[i]));
    }
    var traitJsonString = await loadTraits();
    var traitJson = jsonDecode(traitJsonString);
    for (var i = 0; i < traitJson.length; i++) {
      traits.add(Trait.fromJson(traitJson[i]));
    }
    for (var i = 0; i < champions.length; i++) {
      data['${champions[i].championId}'] = champions[i];
    }
  }

  Widget getChampProfile(String champId, [int item1, int item2, int item3]) {
    AssetImage getChampImage(String champId) {
      String name = data['$champId']
          .name
          .toLowerCase()
          .replaceAll(RegExp(' +'), '')
          .replaceAll('\'', '');
      return AssetImage('assets/tft/champions/$name.png');
    }

    AssetImage getItem(int id) {
      String strId;
      if (id < 10) {
        strId = id.toString().padLeft(2, '0');
      } else {
        strId = id.toString();
      }
      return AssetImage('assets/tft/items/$strId.png');
    }

    Row getItems(item1, item2, item3) {
      if (item1 != null && item2 != null && item3 != null) {
        return Row(
          children: <Widget>[
            Image(
              image: getItem(item1),
              width: 15,
              height: 15,
            ),
            Image(
              image: getItem(item2),
              width: 15,
              height: 15,
            ),
            Image(
              image: getItem(item3),
              width: 15,
              height: 15,
            ),
          ],
        );
      } else if (item1 != null && item2 != null) {
        return Row(
          children: <Widget>[
            Image(
              image: getItem(item1),
              width: 15,
              height: 15,
            ),
            Image(
              image: getItem(item2),
              width: 15,
              height: 15,
            ),
          ],
        );
      } else if (item1 != null) {
        return Row(
          children: <Widget>[
            Image(
              image: getItem(item1),
              width: 15,
              height: 15,
            ),
          ],
        );
      }
      return Row(
        children: <Widget>[Container()],
      );
    }

    Color getBorderColor(champId) {
      int cost = data['$champId'].cost;
      switch (cost) {
        case 1:
          return Colors.grey;
        case 2:
          return Colors.green;
        case 3:
          return Colors.blue;
        case 4:
          return Colors.purple;
        case 5:
          return Colors.yellowAccent;
        default:
          return Colors.black;
      }
    }

    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: getBorderColor(champId), width: 2),
          ),
          child: Image(
            image: getChampImage(champId),
            width: 30,
            height: 30,
          ),
        ),
        getItems(item1, item2, item3)
      ],
    );
  }
}

class Item {
  int id;
  String name;

  Item.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.name = json['name'];
  }
}

class Trait {
  String key;
  String name;
  String description;
  String type;

  Trait.fromJson(Map<String, dynamic> json) {
    this.key = json['key'];
    this.name = json['name'];
    this.description = json['description'];
    this.type = json['type'];
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
