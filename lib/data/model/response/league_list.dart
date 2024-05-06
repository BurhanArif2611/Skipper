class LeagueList {
  Metadata metadata;
  List<Data> data;

  LeagueList({this.metadata, this.data});

  LeagueList.fromJson(Map<String, dynamic> json) {
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
  String code;
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
  String leagueId;
  String venueid;
  String leaguematch;
  String matchId;
  String tourNamentId;
  String teamCountMax;
  String teamCountMin;
  double leagueCost;
  String leaguecreateuser;
  String matchstatus;
  Null createdAt;
  Null updatedAt;

  Data(
      {this.leagueId,
        this.venueid,
        this.leaguematch,
        this.matchId,
        this.tourNamentId,
        this.teamCountMax,
        this.teamCountMin,
        this.leagueCost,
        this.leaguecreateuser,
        this.matchstatus,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    leagueId = json['leagueId'];
    venueid = json['venueid'];
    leaguematch = json['leaguematch'];
    matchId = json['matchId'];
    tourNamentId = json['tourNamentId'];
    teamCountMax = json['teamCountMax'];
    teamCountMin = json['teamCountMin'];
    leagueCost = json['leagueCost'];
    leaguecreateuser = json['leaguecreateuser'];
    matchstatus = json['matchstatus'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['leagueId'] = this.leagueId;
    data['venueid'] = this.venueid;
    data['leaguematch'] = this.leaguematch;
    data['matchId'] = this.matchId;
    data['tourNamentId'] = this.tourNamentId;
    data['teamCountMax'] = this.teamCountMax;
    data['teamCountMin'] = this.teamCountMin;
    data['leagueCost'] = this.leagueCost;
    data['leaguecreateuser'] = this.leaguecreateuser;
    data['matchstatus'] = this.matchstatus;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
