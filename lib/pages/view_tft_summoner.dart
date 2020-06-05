import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:leaguetool/services/tft_set_data.dart';
import 'package:leaguetool/services/tft_summoner.dart';

class ViewTFTSummoner extends StatefulWidget {
  static const routeName = '/view_tft_summoner';

  @override
  _ViewTFTSummonerState createState() => _ViewTFTSummonerState();
}
/*TODO Implement a FutureBuilder Widget, Refactor code as necessary.
  Make it Look Pretty
 */
class _ViewTFTSummonerState extends State<ViewTFTSummoner> {
  void initState() {
    ChampionData.init();
    super.initState();
  }

  Future<TFTSummoner> getSummoner(String value) async {
    TFTSummoner instance = TFTSummoner(tftName: value);
    await instance.setupTFTSummoner();
    if (instance.puuid == null || instance.matches.length == 0) {
      throw StateError('Error');
    }
    return instance;
  }

  Widget _buildRow(TFTSummoner data, int index) {
    return Container(
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        color: Colors.deepPurple,
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(5),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "#${data.player[index].placement}",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18),
          ),
        ),
      ),
    );
  }

  Widget _buildRank(TFTSummoner data) {
    return Container();
  }

  Widget _buildMatchHistory(TFTSummoner data) {
    return ListView.builder(
        itemCount: 20,
        padding: const EdgeInsets.all(0),
        itemBuilder: (context, i) {
          return Padding(
              padding: EdgeInsets.fromLTRB(6, 0, 6, 8),
              child: _buildRow(data, i));
        });
  }

  Widget errorPage() {
    return Scaffold(
        backgroundColor: Color.fromRGBO(28, 22, 46, 1),
        appBar: AppBar(
          title: Text("Summoner Not Found!"),
        ),
        body: Container(
          decoration: BoxDecoration(),
        ));
  }

  Widget tftPage(TFTSummoner data) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(28, 22, 46, 1),
      appBar: AppBar(
        title:
            Text(data.tftName, style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0.0,
        backgroundColor: Color.fromRGBO(28, 22, 46, 1),
      ),
      body: Column(
        children: <Widget>[
          Divider(
            color: Color.fromRGBO(43, 38, 60, 1),
            thickness: 2,
          ),
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

  @override
  Widget build(BuildContext context) {
    String data = ModalRoute.of(context).settings.arguments;
    return FutureBuilder(
        future: getSummoner(data),
        builder: (BuildContext context, AsyncSnapshot<TFTSummoner> snapshot) {
          if (snapshot.hasData) {
            return tftPage(snapshot.data);
          } else if (snapshot.hasError) {
            return errorPage();
          } else {
            return Scaffold(
                backgroundColor: Color.fromRGBO(28, 22, 46, 1),
                appBar: AppBar(
                  title: Text("Loading!"),
                ),
                body: Center(
                  child: SizedBox(
                    child: CircularProgressIndicator(
                      strokeWidth: 5,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                    width: 60,
                    height: 60,
                  ),
                ));
          }
        });
  }
}
