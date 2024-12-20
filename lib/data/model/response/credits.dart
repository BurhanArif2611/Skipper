import 'dart:ffi';

class CreditsMain {
  List<Credits> credits;
  int lastUpdated;

  CreditsMain({this.credits, this.lastUpdated});

  CreditsMain.fromJson(Map<String, dynamic> json) {
    if (json['credits'] != null) {
      credits = <Credits>[];
      json['credits'].forEach((v) {
        credits.add(new Credits.fromJson(v));
      });
    }
    lastUpdated = json['last_updated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.credits != null) {
      data['credits'] = this.credits.map((v) => v.toJson()).toList();
    }
    data['last_updated'] = this.lastUpdated;
    return data;
  }
}

class Credits {
  String playerKey;
  int intelligentRank;
  int value;
  double intelligentScore;
  double tournamentPoints;
  int lastUpdated;
  List<Performance> performance;

  Credits(
      {this.playerKey,
        this.intelligentRank,
        this.value,
        this.intelligentScore,
        this.tournamentPoints,
        this.lastUpdated,
        this.performance});

  Credits.fromJson(Map<String, dynamic> json) {
    playerKey = json['player_key'];
    intelligentRank = json['intelligent_rank'];
    value = json['value'];
    intelligentScore = json['intelligent_score'];
    tournamentPoints = json['tournament_points'] is Double? json['tournament_points']:json['tournament_points'].toDouble();
    lastUpdated = json['last_updated'];
    if (json['performance'] != null) {
      performance = <Performance>[];
      json['performance'].forEach((v) {
        performance.add(new Performance.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['player_key'] = this.playerKey;
    data['intelligent_rank'] = this.intelligentRank;
    data['value'] = this.value;
    data['intelligent_score'] = this.intelligentScore;
    data['tournament_points'] = this.tournamentPoints;
    data['last_updated'] = this.lastUpdated;
    if (this.performance != null) {
      data['performance'] = this.performance.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Performance {
  int matchRank;
  double points;
  String matchKey;
  String startDate;

  Performance({this.matchRank, this.points, this.matchKey, this.startDate});

  Performance.fromJson(Map<String, dynamic> json) {
    matchRank = json['match_rank'];
    points = json['points'];
    matchKey = json['match_key'];
    startDate = json['start_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['match_rank'] = this.matchRank;
    data['points'] = this.points;
    data['match_key'] = this.matchKey;
    data['start_date'] = this.startDate;
    return data;
  }
}
