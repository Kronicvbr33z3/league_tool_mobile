import 'package:http/http.dart';
import 'dart:convert';

//Fuck MAPS holy shit, STATIC LIST OF CHAMPS WITH ID
Map champs = {
  'Qiyana': '246',
  'Wukong': '62',
  'Jax': '24',
  'Fiddlesticks': '9',
  'Yuumi': '350',
  'Shaco': '35',
  'Warwick': '19',
  'Xayah': '498',
  'Sylas': '517',
  'Nidalee': '76',
  'Zyra': '143',
  'Kled': '240',
  'Brand': '63',
  'Rammus': '33',
  'Illaoi': '420',
  'Corki': '42',
  'Braum': '201',
  'Sejuani': '113',
  'Tryndamere': '23',
  'Miss Fortune': '21',
  'Yorick': '83',
  'Xerath': '101',
  'Sivir': '15',
  'Riven': '92',
  'Orianna': '61',
  'Gangplank': '41',
  'Sett': '875',
  'Malphite': '54',
  'Poppy': '78',
  'Karthus': '30',
  'Jayce': '126',
  'Diana': '131',
  'Trundle': '48',
  'Graves': '104',
  'Zoe': '142',
  'Gnar': '150',
  'Lux': '99',
  'Shyvana': '102',
  'Renekton': '58',
  'Lissandra': '127',
  'Fiora': '114',
  'Jinx': '222',
  'Kalista': '429',
  'Fizz': '105',
  'Kassadin': '38',
  'Sona': '37',
  'Irelia': '39',
  'Viktor': '112',
  'Rakan': '497',
  'Kindred': '203',
  'Cassiopeia': '69',
  'Maokai': '57',
  'Ornn': '516',
  'Thresh': '412',
  'Kayle': '10',
  'Hecarim': '120',
  'Nunu': '20',
  'Khazix': '121',
  'Olaf': '2',
  'Ziggs': '115',
  'Syndra': '134',
  'Dr Mundo': '36',
  'Karma': '43',
  'Annie': '1',
  'Akali': '84',
  'Leona': '89',
  'Yasuo': '157',
  'Kennen': '85',
  'Rengar': '107',
  'Ryze': '13',
  'Shen': '98',
  'Zac': '154',
  'Pantheon': '80',
  'Neeko': '518',
  'Bard': '432',
  'Sion': '14',
  'Vayne': '67',
  'Nasus': '75',
  'Kayn': '141',
  'Twisted Fate': '4',
  'Chogath': '31',
  'Udyr': '77',
  'Lucian': '236',
  'Ivern': '427',
  'Volibear': '106',
  'Caitlyn': '51',
  'Darius': '122',
  'Nocturne': '56',
  'Zilean': '26',
  'Azir': '268',
  'Rumble': '68',
  'Morgana': '25',
  'Skarner': '72',
  'Teemo': '17',
  'Urgot': '6',
  'Amumu': '32',
  'Galio': '3',
  'Heimerdinger': '74',
  'Anivia': '34',
  'Ashe': '22',
  'Velkoz': '161',
  'Singed': '27',
  'Taliyah': '163',
  'Evelynn': '28',
  'Varus': '110',
  'Twitch': '29',
  'Garen': '86',
  'Blitzcrank': '53',
  'Master Yi': '11',
  'Pyke': '555',
  'Elise': '60',
  'Alistar': '12',
  'Katarina': '55',
  'Ekko': '245',
  'Mordekaiser': '82',
  'Lulu': '117',
  'Camille': '164',
  'Aatrox': '266',
  'Draven': '119',
  'Tahm Kench': '223',
  'Talon': '91',
  'Xin Zhao': '5',
  'Swain': '50',
  'Aurelion Sol': '136',
  'Lee Sin': '64',
  'Aphelios': '523',
  'Ahri': '103',
  'Malzahar': '90',
  'Kaisa': '145',
  'Tristana': '18',
  'RekSai': '421',
  'Vladimir': '8',
  'Jarvan IV': '59',
  'Nami': '267',
  'Jhin': '202',
  'Soraka': '16',
  'Veigar': '45',
  'Janna': '40',
  'Nautilus': '111',
  'Senna': '235',
  'Gragas': '79',
  'Zed': '238',
  'Vi': '254',
  'KogMaw': '96',
  'Taric': '44',
  'Quinn': '133',
  'Leblanc': '7',
  'Ezreal': '81'
};

final String apiKey = 'RGAPI-88da60fc-f70c-446c-9bde-9217be3db585';

class Summoner {
  String summonerName;
  String accountId = 'loading';
  MatchHistory matches;
  Rank rank;
  String summonerId = 'loading';
  Summoner({this.summonerName});

  Future<void> getAccountId() async {
    // make the request
    try {
      Response response = await get(
          'https://na1.api.riotgames.com/lol/summoner/v4/summoners/by-name/$summonerName?api_key=$apiKey');
      Map summoner = jsonDecode(response.body);

      accountId = summoner['accountId'];
      summonerId = summoner['id'];
      summonerName = summoner['name'];
    } catch (e) {
      print('Unable to Load Summoner');
      accountId = 'Unable to Find Summoner';
    }
  }

  Future<void> getRankedInfo() async {
    try {
      Response response = await get(
          'https://na1.api.riotgames.com/lol/league/v4/entries/by-summoner/$summonerId?api_key=$apiKey');
      rank = new Rank.fromJson(response.body);
    } catch (e) {
      print(e);
    }
  }

  Future<void> setupSummoner() async {
    await getAccountId();
    await getRankedInfo();
    try {
      Response response = await get(
          'https://na1.api.riotgames.com/lol/match/v4/matchlists/by-account/$accountId?endIndex=20&api_key=$apiKey');
      matches = new MatchHistory.fromJson(response.body);
      for (var i = 0; i < (20); i++) {
        await matches.matches[i].getGameInfo(accountId);
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}

class Matches {
  String lane;
  int gameId;
  int champion;
  int queue;
  Participants participants;
  ParticipantIds ids;

  //GameInfo Specific to Summoner Translated
  String championName;
  bool win;
  int kills;
  int deaths;
  int assists;


  Matches.fromJson(Map<String, dynamic> jsonMap) {
    this.lane = jsonMap['lane'];
    this.gameId = jsonMap['gameId'];
    this.champion = jsonMap['champion'];
    this.queue = jsonMap['queue'];
  }
  Future<void> getGameInfo(String accId) async {
    //This line of codeWOOOOOOOOOOOOOOOOOOOOOOOOOOO
    championName = (champs.keys.firstWhere((k) => champs[k] == '$champion',
        orElse: () => null)).toString();
    Response response = await get(
        'https://na1.api.riotgames.com/lol/match/v4/matches/$gameId?api_key=$apiKey');
    //Participants
    participants = Participants.fromJson(response.body);
    GetPlayerMatchInfo(participants, accId);
  }

  GetPlayerMatchInfo(Participants participants, String accId) {
    for (var i = 0; i < (10); i++) {
      //If someone in the match has the same account ID
      if (participants.ids[i].player.accountId == accId) {
        win = participants.participants[i].stats.win;
        kills = participants.participants[i].stats.kills;
        deaths = participants.participants[i].stats.deaths;
        assists = participants.participants[i].stats.assists;

      }
    }
  }
}

class MatchHistory {
  List<Matches> matches;

  MatchHistory.fromJson(String jsonStr) {
    final _map = jsonDecode(jsonStr);
    this.matches = [];
    final _matchesList = _map['matches'];

    for (var i = 0; i < (20); i++) {
      this.matches.add(new Matches.fromJson(_matchesList[i]));
    }
  }
}

class Player {
  String accountId;
  int profileIcon;

  Player.fromJson(Map<String, dynamic> jsonMap) {
    this.accountId = jsonMap['accountId'];
    this.profileIcon = jsonMap['profileIcon'];
  }
}

class ParticipantIds {
  Player player;
  int participantId;

  ParticipantIds.fromJson(Map<String, dynamic> jsonMap) {
    this.player = Player.fromJson(jsonMap['player']);
    this.participantId = jsonMap['participantId'];
  }
}

//Add Anything From Participant:Stats here
class Stats {
  bool win;
  int item0;
  int item1;
  int item2;
  int item3;
  int item4;
  int item5;
  int item6;
  int kills;
  int deaths;
  int assists;


  Stats.fromJson(Map<String, dynamic> jsonMap) {
    this.win = jsonMap['win'];
    this.item0 = jsonMap['item0'];
    this.item1 = jsonMap['item1'];
    this.item2 = jsonMap['item2'];
    this.item3 = jsonMap['item3'];
    this.item4 = jsonMap['item4'];
    this.item5 = jsonMap['item5'];
    this.item6 = jsonMap['item6'];
    this.kills = jsonMap['kills'];
    this.deaths = jsonMap['deaths'];
    this.assists = jsonMap['assists'];

  }
}

//Participant
class Participant {
  Stats stats;
  int participantId;
  int teamId;
  int championId;
  int spell1ID;
  int spell2Id;

  Participant.fromJson(Map<String, dynamic> jsonMap) {
    this.participantId = jsonMap['participantId'];
    this.stats = Stats.fromJson(jsonMap['stats']);
  }
}

//Match
class Participants {
  List<Participant> participants;
  List<ParticipantIds> ids;
  int gameDuration;
  Participants.fromJson(String jsonStr) {
    final _map = jsonDecode(jsonStr);
    this.participants = [];
    this.gameDuration = _map['gameDuration'];
    this.ids = [];
    final _participantsList = _map['participants'];
    final _idList = _map['participantIdentities'];
    for (var i = 0; i < (10); i++) {
      this.participants.add(Participant.fromJson(_participantsList[i]));
      this.ids.add(ParticipantIds.fromJson(_idList[i]));
    }
  }
}

// INFO FROM RANKS (ADD ANYTHING FOR RANKS HERE)
class Ranks {
  String queueType;
  int wins;
  String rank;
  String tier;
  int lp;

  Ranks.fromJson(Map<String, dynamic> jsonMap){
    this.queueType = jsonMap['queueType'];
    this.wins = jsonMap['wins'];
    this.rank = jsonMap['rank'];
    this.tier = jsonMap['tier'];
    this.lp = jsonMap['leaguePoints'];
  }


}

//TOP LEVEL RANK
class Rank {
  List<Ranks> ranks;
  Rank.fromJson(String jsonStr) {
    final _map = jsonDecode(jsonStr);


    //Takes length of list to create ranks
    var list = _map as List;
    ranks = list.map((i) => Ranks.fromJson(i)).toList();
  }
}
