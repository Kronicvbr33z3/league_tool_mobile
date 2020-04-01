import 'package:flutter/material.dart';
import 'package:leaguetool/services/summoner.dart';
import 'package:leaguetool/pages/view_summoner.dart';

class LeagueHomeScreen extends StatefulWidget {
  @override
  _LeagueHomeScreenState createState() => _LeagueHomeScreenState();
}

class _LeagueHomeScreenState extends State<LeagueHomeScreen> {
  TextEditingController _controller;

  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  Future<void> setupSummoner(Summoner instance) async {
    await instance.setupSummoner();
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextField(
        controller: _controller,
        onSubmitted: (String value) async {
          Summoner instance = Summoner(summonerName: value);
          await setupSummoner(instance);
          Navigator.pushNamed(context, ViewSummoner.routeName,
              arguments: instance);
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Summoner Lookup',
        ),
      ),
    );
    ;
  }
}
