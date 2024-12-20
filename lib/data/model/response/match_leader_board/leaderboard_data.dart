class LeaderBoardData {
  Metadata metadata;
  Data data;

  LeaderBoardData({this.metadata, this.data});

  LeaderBoardData.fromJson(Map<String, dynamic> json) {
    metadata = json['metadata'] != null
        ? new Metadata.fromJson(json['metadata'])
        : null;
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.metadata != null) {
      data['metadata'] = this.metadata.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data.toJson();
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
  List<LeaderBoardDetails> leaderBoardDetails;

  Data({this.leaderBoardDetails});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['leaderBoardDetails'] != null) {
      leaderBoardDetails = <LeaderBoardDetails>[];
      json['leaderBoardDetails'].forEach((v) {
        leaderBoardDetails.add(new LeaderBoardDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.leaderBoardDetails != null) {
      data['leaderBoardDetails'] =
          this.leaderBoardDetails.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LeaderBoardDetails {
  String leaguejoinid;
  String createamid;
 // TeamSquard teamSquard;
  List<String> teamList;
  String userId;
  String createdAt;
  String leagueid;
  Null tournament;
  String tournamentId;
  String venueId;
  // Match match;
  String matchid;
  String updatedAt;
  String status;
  String teamname;
  String position;
 /* String leagueJoinAmount;
  String leagueWinAmount;
  String joininngStatus;
  Null leagueCreatedAt;
  Null resultAt;*/

  LeaderBoardDetails(
      {this.leaguejoinid,
        this.createamid,
       /* this.teamSquard,*/
        this.teamList,
        this.userId,
        this.createdAt,
        this.leagueid,
        this.tournament,
        this.tournamentId,
        this.venueId,
        // this.match,
        this.matchid,
        this.updatedAt,
        this.status,
        this.teamname,
        this.position,
        /*this.leagueJoinAmount,
        this.leagueWinAmount,
        this.joininngStatus,
        this.leagueCreatedAt,
        this.resultAt*/});

  LeaderBoardDetails.fromJson(Map<String, dynamic> json) {
    leaguejoinid = json['leaguejoinid'];
    createamid = json['createamid'];
   /* teamSquard = json['teamSquard'] != null
        ? new TeamSquard.fromJson(json['teamSquard'])
        : null;*/
    teamList = json['teamList'].cast<String>();
    userId = json['user_id'];
    createdAt = json['createdAt'];
    leagueid = json['leagueid'];
    tournament = json['tournament'];
    tournamentId = json['tournamentId'];
    venueId = json['venueId'];
 //   match = json['match'] != null ? new Match.fromJson(json['match']) : null;
    matchid = json['matchid'];
    updatedAt = json['updatedAt'];
    status = json['status'];
    teamname = json['teamname'];
    position = json['position'];
   /* leagueJoinAmount = json['league_Join_Amount'];
    leagueWinAmount = json['league_Win_Amount'];
    joininngStatus = json['joininngStatus'];
    leagueCreatedAt = json['leagueCreatedAt'];
    resultAt = json['resultAt'];*/
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
    data['tournament'] = this.tournament;
    data['tournamentId'] = this.tournamentId;
    data['venueId'] = this.venueId;
   /* if (this.match != null) {
      data['match'] = this.match!.toJson();
    }*/
    data['matchid'] = this.matchid;
    data['updatedAt'] = this.updatedAt;
    data['status'] = this.status;
    data['teamname'] = this.teamname;
    data['position'] = this.position;
 /*   data['league_Join_Amount'] = this.leagueJoinAmount;
    data['league_Win_Amount'] = this.leagueWinAmount;
    data['joininngStatus'] = this.joininngStatus;
    data['leagueCreatedAt'] = this.leagueCreatedAt;
    data['resultAt'] = this.resultAt;*/
    return data;
  }
}


