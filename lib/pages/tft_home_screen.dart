import 'package:flutter/material.dart';

class TFTHomeScreen extends StatefulWidget {
  @override
  _TFTHomeScreenState createState() => _TFTHomeScreenState();
}

class _TFTHomeScreenState extends State<TFTHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.deepPurple[700],
        child: Column(
          children: <Widget>[
            Center(
                child: Text(
              "TFT Page Placeholder",
              style: TextStyle(fontWeight: FontWeight.bold),
            ))
          ],
        ));
  }
}
