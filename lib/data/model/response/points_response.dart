import 'dart:ffi';

class PointsMain {
  List<Points> points;

  PointsMain({this.points});

  PointsMain.fromJson(Map<String, dynamic> json) {
    if (json['points'] != null) {
      points = <Points>[];
      json['points'].forEach((v) {
        points.add(new Points.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.points != null) {
      data['points'] = this.points.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Points {
  String playerKey;
  int rank;
  double points;
  // Null pointsStr;
  List<Null> pointsBreakup;
  double tournamentPoints;
  // Null lastUpdated;

  Points(
      {this.playerKey,
        this.rank,
        this.points,
        // this.pointsStr,
        this.pointsBreakup,
        this.tournamentPoints,
        // this.lastUpdated
  });

  Points.fromJson(Map<String, dynamic> json) {
    playerKey = json['player_key'];
    rank = json['rank'];
    points = json['points'] is Double?json['points']:json['points'].toDouble();
    // pointsStr = json['points_str'];
    // if (json['points_breakup'] != null) {
    //   pointsBreakup = <Null>[];
    //   json['points_breakup'].forEach((v) {
    //     pointsBreakup.add(new Null.fromJson(v));
    //   });
    // }
    tournamentPoints = json['tournament_points'] is Double?json['tournament_points'] :json['tournament_points'].toDouble();
    // lastUpdated = json['lastUpdated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['player_key'] = this.playerKey;
    data['rank'] = this.rank;
    data['points'] = this.points;
    // data['points_str'] = this.pointsStr;
    // if (this.pointsBreakup != null) {
    //   data['points_breakup'] =
    //       this.pointsBreakup.map((v) => v.toJson()).toList();
    // }
    data['tournament_points'] = this.tournamentPoints;
    // data['lastUpdated'] = this.lastUpdated;
    return data;
  }
}
