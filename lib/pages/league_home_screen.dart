import 'package:flutter/material.dart';
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
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(30),
        child: TextField(
          controller: _controller,
          onSubmitted: (String value) async {
            if (value == '') {
              //Field is Empty Don't Submit
            } else {
              //Initialize Summoner with value from text controller
              Navigator.pushNamed(context, ViewSummoner.routeName,
                  arguments: value);
            }
          },
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(50)),),
              hintStyle: TextStyle(color: Colors.grey),
              hintText: 'Summoner Lookup',
              labelText: 'Summoner Lookup',
              fillColor: Color.fromRGBO(28, 22, 46, 1)
          ),
        ),
      ),
    );
  }
}
