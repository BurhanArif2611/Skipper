import '../matchList/matches.dart';

class MyContestData {
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
  Matches match;

  MyContestData(
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
        this.resultAt,
        this.match,
      });

  MyContestData.fromJson(Map<String, dynamic> json) {
    leaguejoinid = json['leaguejoinid'];
    createamid = json['createamid'];
    match = json['match'] != null
        ? new Matches.fromJson(json['match'])
        : null;
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
    position = json['position']!=null?json['position']:"0";
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