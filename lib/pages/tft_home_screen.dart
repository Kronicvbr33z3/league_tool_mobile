import 'package:flutter/material.dart';
import 'package:leaguetool/pages/view_tft_summoner.dart';
import 'package:leaguetool/services/tft_summoner.dart';

class TFTHomeScreen extends StatefulWidget {
  @override
  _TFTHomeScreenState createState() => _TFTHomeScreenState();
}

class _TFTHomeScreenState extends State<TFTHomeScreen> {
  TextEditingController _controller;

  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  Future<void> setupSummoner(TFTSummoner instance) async {
    await instance.setupTFTSummoner();
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
              TFTSummoner instance = TFTSummoner(tftName: value);
              await setupSummoner(instance);
              Navigator.pushNamed(context, ViewTFTSummoner.routeName,
                  arguments: instance);
            }
          },
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
              hintStyle: TextStyle(color: Colors.grey),
              hintText: 'TFT Lookup',
              labelText: 'TFT Lookup',
              fillColor: Color.fromRGBO(28, 22, 46, 1)),
        ),
      ),
    );
  }
}
