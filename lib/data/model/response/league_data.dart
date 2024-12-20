class LeagueData {
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
  String entryfees;
  String totalParticipent;
  String total_join_participent_count;
  Null createdAt;
  Null updatedAt;

  LeagueData(
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
        this.entryfees,
        this.totalParticipent,
        this.total_join_participent_count,
        this.createdAt,
        this.updatedAt});

  LeagueData.fromJson(Map<String, dynamic> json) {
    leagueId = json['leagueid'];
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
    entryfees = json['entryfees'];
    totalParticipent = json['totalParticipent'] is String ?json['totalParticipent']:json['totalParticipent'].toString();
    total_join_participent_count = json['total_join_participent_count'] is String ?json['total_join_participent_count']:json['total_join_participent_count'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['leagueid'] = this.leagueId;
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
    data['entryfees'] = this.entryfees;
    data['totalParticipent'] = this.totalParticipent;
    data['total_join_participent_count'] = this.total_join_participent_count;
    return data;
  }
}