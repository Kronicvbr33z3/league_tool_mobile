import 'package:leaguetool/services/summoner.dart';

class AnalyzeMatch {
  double kronicGameScore;
  List<Award> awards;

  AnalyzeMatch(Summoner player, int index) {
    kronicGameScore = calculateKronicGameScore(player, index);
    awards = getAwards(player, index);
  }
}

double calculateKronicGameScore(Summoner player, int index) {
  return 0;
}

List<Award> getAwards(Summoner player, int index) {
  MVP mvp = MVP();
  List<Award> listOFAwards = [mvp];
  List<Award> earnedAwards = [];
  for (Award award in listOFAwards) {
    if (award.canHave(player, index)) {
      earnedAwards.add(award);
    }
  }
  return earnedAwards;
}

class Award {
  bool canHave(Summoner player, int index) {}
  String description;
}

class MVP extends Award {
  @override
  bool canHave(Summoner player, int index) {
    return true;
  }

  String description = "Most Valuable Player";
}
