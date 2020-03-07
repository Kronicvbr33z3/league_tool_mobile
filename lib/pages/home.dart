import 'package:flutter/material.dart';
import 'package:leaguetool/services/summoner.dart';
import 'package:leaguetool/pages/view_summoner.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _controller;

  void initState() {
    super.initState();
    _controller = TextEditingController();
  }
  Future<void> setupSummoner(Summoner instance) async {
      await instance.retrieveMatchHistory();

  }
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
    onWillPop: () async => false,
    child: new Scaffold(
        backgroundColor: Colors.purple[900],
        appBar: AppBar(
          leading: new Container(),
          title: Text('Made by Luis :)'),
          centerTitle: true,
          backgroundColor: Colors.grey[900],
          elevation: 0.0,
        ),
        body:
        Center(
          child: TextField(
            controller: _controller,
            onSubmitted: (String value) async{
              Summoner instance = Summoner(summonerName: value);
              await setupSummoner(instance);
              Navigator.pushNamed(context, ViewSummoner.routeName, arguments: instance);
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Summoner Lookup',
            ),
          ),
        )
    )
    );
  }
}
