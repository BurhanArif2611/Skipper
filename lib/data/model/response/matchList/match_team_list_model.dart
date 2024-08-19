class MatchTeamList {
  Metadata metadata;
  List<Data> data;

  MatchTeamList({this.metadata, this.data});

  MatchTeamList.fromJson(Map<String, dynamic> json) {
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
  String teamId;
  String userId;
  String emailId;
  String venueid;
  String teamName;
  String tournamentId;
  String matchId;
  List<Teamlist> teamlist;
  Null createUser;
  Null createUserid;
  Null createdat;
  Null updatedat;

  Data(
      {this.teamId,
        this.userId,
        this.emailId,
        this.venueid,
        this.teamName,
        this.tournamentId,
        this.matchId,
        this.teamlist,
        this.createUser,
        this.createUserid,
        this.createdat,
        this.updatedat});

  Data.fromJson(Map<String, dynamic> json) {
    teamId = json['teamId'];
    userId = json['user_id'];
    emailId = json['email_id'];
    venueid = json['venueid'];
    teamName = json['teamName'];
    tournamentId = json['tournamentId'];
    matchId = json['matchId'];
    if (json['teamlist'] != null) {
      teamlist = <Teamlist>[];
      json['teamlist'].forEach((v) {
        teamlist.add(new Teamlist.fromJson(v));
      });
    }
    createUser = json['create_user'];
    createUserid = json['create_userid'];
    createdat = json['createdat'];
    updatedat = json['updatedat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['teamId'] = this.teamId;
    data['user_id'] = this.userId;
    data['email_id'] = this.emailId;
    data['venueid'] = this.venueid;
    data['teamName'] = this.teamName;
    data['tournamentId'] = this.tournamentId;
    data['matchId'] = this.matchId;
    if (this.teamlist != null) {
      data['teamlist'] = this.teamlist.map((v) => v.toJson()).toList();
    }
    data['create_user'] = this.createUser;
    data['create_userid'] = this.createUserid;
    data['createdat'] = this.createdat;
    data['updatedat'] = this.updatedat;
    return data;
  }
}

class Teamlist {
  String playerId;
  String name;
  double point;
  String positionId;

  Teamlist({this.playerId, this.name, this.point, this.positionId});

  Teamlist.fromJson(Map<String, dynamic> json) {
    playerId = json['playerId'];
    name = json['name'];
    point = json['point'];
    positionId = json['positionId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['playerId'] = this.playerId;
    data['name'] = this.name;
    data['point'] = this.point;
    data['positionId'] = this.positionId;
    return data;
  }
}
