class MyContestList {
  Metadata metadata;
  List<Data> data;

  MyContestList({this.metadata, this.data});

  MyContestList.fromJson(Map<String, dynamic> json) {
    metadata = json['metadata'] != null
        ? new Metadata.fromJson(json['metadata'])
        : null;
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.metadata != null) {
      data['metadata'] = this.metadata.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Metadata {
  int code;
  String message;
  String timestamp;
  String version;

  Metadata({this.code, this.message, this.timestamp, this.version});

  Metadata.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    timestamp = json['timestamp'];
    version = json['version'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    data['timestamp'] = this.timestamp;
    data['version'] = this.version;
    return data;
  }
}

class Data {
  String leaguejoinid;
  String createamid;
 /* TeamSquard teamSquard;*/
  List<String> teamList;
  String userId;
  String createdAt;
  String leagueid;
  String tournamentId;
  String venueId;
  String matchid;
  String updatedAt;
  String status;
  String teamname;
  String position;
  String leagueJoinAmount;
  Null leagueWinAmount;
  String joininngStatus;
  Null leagueCreatedAt;
  Null resultAt;

  Data(
      {this.leaguejoinid,
        this.createamid,
       /* this.teamSquard,*/
        this.teamList,
        this.userId,
        this.createdAt,
        this.leagueid,
        this.tournamentId,
        this.venueId,
        this.matchid,
        this.updatedAt,
        this.status,
        this.teamname,
        this.position,
        this.leagueJoinAmount,
        this.leagueWinAmount,
        this.joininngStatus,
        this.leagueCreatedAt,
        this.resultAt});

  Data.fromJson(Map<String, dynamic> json) {
    leaguejoinid = json['leaguejoinid'];
    createamid = json['createamid'];
   /* teamSquard = json['teamSquard'] != null
        ? new TeamSquard.fromJson(json['teamSquard'])
        : null;*/
    teamList = json['teamList'].cast<String>();
    userId = json['user_id'];
    createdAt = json['createdAt'];
    leagueid = json['leagueid'];
    tournamentId = json['tournamentId'];
    venueId = json['venueId'];
    matchid = json['matchid'];
    updatedAt = json['updatedAt'];
    status = json['status'];
    teamname = json['teamname'];
    position = json['position'];
    leagueJoinAmount = json['league_Join_Amount'];
    leagueWinAmount = json['league_Win_Amount'];
    joininngStatus = json['joininngStatus'];
    leagueCreatedAt = json['leagueCreatedAt'];
    resultAt = json['resultAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['leaguejoinid'] = this.leaguejoinid;
    data['createamid'] = this.createamid;
   /* if (this.teamSquard != null) {
      data['teamSquard'] = this.teamSquard!.toJson();
    }*/
    data['teamList'] = this.teamList;
    data['user_id'] = this.userId;
    data['createdAt'] = this.createdAt;
    data['leagueid'] = this.leagueid;
    data['tournamentId'] = this.tournamentId;
    data['venueId'] = this.venueId;
    data['matchid'] = this.matchid;
    data['updatedAt'] = this.updatedAt;
    data['status'] = this.status;
    data['teamname'] = this.teamname;
    data['position'] = this.position;
    data['league_Join_Amount'] = this.leagueJoinAmount;
    data['league_Win_Amount'] = this.leagueWinAmount;
    data['joininngStatus'] = this.joininngStatus;
    data['leagueCreatedAt'] = this.leagueCreatedAt;
    data['resultAt'] = this.resultAt;
    return data;
  }
}

/*class TeamSquard {
  Player5? player5;
  Player5? player6;
  Player5? player7;
  Player5? player11;
  Player5? player8;
  Player5? player10;
  Player5? player2;
  Player3? player3;
  Player5? player4;
  Player5? player1256;
  Player5? player9;
  Player5? player1;

  TeamSquard(
      {this.player5,
        this.player6,
        this.player7,
        this.player11,
        this.player8,
        this.player10,
        this.player2,
        this.player3,
        this.player4,
        this.player1256,
        this.player9,
        this.player1});

  TeamSquard.fromJson(Map<String, dynamic> json) {
    player5 =
    json['player5'] != null ? new Player5.fromJson(json['player5']) : null;
    player6 =
    json['player6'] != null ? new Player5.fromJson(json['player6']) : null;
    player7 =
    json['player7'] != null ? new Player5.fromJson(json['player7']) : null;
    player11 = json['player11'] != null
        ? new Player5.fromJson(json['player11'])
        : null;
    player8 =
    json['player8'] != null ? new Player5.fromJson(json['player8']) : null;
    player10 = json['player10'] != null
        ? new Player5.fromJson(json['player10'])
        : null;
    player2 =
    json['player2'] != null ? new Player5.fromJson(json['player2']) : null;
    player3 =
    json['player3'] != null ? new Player3.fromJson(json['player3']) : null;
    player4 =
    json['player4'] != null ? new Player5.fromJson(json['player4']) : null;
    player1256 = json['player1256'] != null
        ? new Player5.fromJson(json['player1256'])
        : null;
    player9 =
    json['player9'] != null ? new Player5.fromJson(json['player9']) : null;
    player1 =
    json['player1'] != null ? new Player5.fromJson(json['player1']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.player5 != null) {
      data['player5'] = this.player5!.toJson();
    }
    if (this.player6 != null) {
      data['player6'] = this.player6!.toJson();
    }
    if (this.player7 != null) {
      data['player7'] = this.player7!.toJson();
    }
    if (this.player11 != null) {
      data['player11'] = this.player11!.toJson();
    }
    if (this.player8 != null) {
      data['player8'] = this.player8!.toJson();
    }
    if (this.player10 != null) {
      data['player10'] = this.player10!.toJson();
    }
    if (this.player2 != null) {
      data['player2'] = this.player2!.toJson();
    }
    if (this.player3 != null) {
      data['player3'] = this.player3!.toJson();
    }
    if (this.player4 != null) {
      data['player4'] = this.player4!.toJson();
    }
    if (this.player1256 != null) {
      data['player1256'] = this.player1256!.toJson();
    }
    if (this.player9 != null) {
      data['player9'] = this.player9!.toJson();
    }
    if (this.player1 != null) {
      data['player1'] = this.player1!.toJson();
    }
    return data;
  }
}*/

class Player5 {
  String positionId;
  double point;
  String name;

  Player5({this.positionId, this.point, this.name});

  Player5.fromJson(Map<String, dynamic> json) {
    positionId = json['positionId'];
    point = json['point'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['positionId'] = this.positionId;
    data['point'] = this.point;
    data['name'] = this.name;
    return data;
  }
}

class Player3 {
  String positionId;
  int point;
  String name;

  Player3({this.positionId, this.point, this.name});

  Player3.fromJson(Map<String, dynamic> json) {
    positionId = json['positionId'];
    point = json['point'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['positionId'] = this.positionId;
    data['point'] = this.point;
    data['name'] = this.name;
    return data;
  }
}
