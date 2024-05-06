class TeamCreate {
  UserDetails userDetails;
  Request request;

  TeamCreate({this.userDetails, this.request});

  TeamCreate.fromJson(Map<String, dynamic> json) {
    userDetails = json['userDetails'] != null
        ? new UserDetails.fromJson(json['userDetails'])
        : null;
    request =
    json['request'] != null ? new Request.fromJson(json['request']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userDetails != null) {
      data['userDetails'] = this.userDetails.toJson();
    }
    if (this.request != null) {
      data['request'] = this.request.toJson();
    }
    return data;
  }
}

class UserDetails {
  String userName;
  String emailId;

  UserDetails({this.userName, this.emailId});

  UserDetails.fromJson(Map<String, dynamic> json) {
    userName = json['user_id'];
    emailId = json['email_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userName;
    data['email_id'] = this.emailId;
    return data;
  }
}

class Request {
  String teamName;
  String leagueId;
  String tournamentId;
  String matchId;
  String venueId;
  String capton;
  String captonId;
  String captonpoint;
  String playeridCapton;
  String team1;
  String team1Id;
  String team1point;
  String playerid1;
  String team2;
  String team2Id;
  String team2point;
  String playerid2;
  String team3;
  String team3Id;
  String team3point;
  String playerid3;
  String team4;
  String team4Id;
  String team4point;
  String playerid4;
  String team5;
  String team5Id;
  String team5point;
  String playerid5;
  String team6;
  String team6Id;
  String team6point;
  String playerid6;
  String team7;
  String team7Id;
  String team7point;
  String playerid7;
  String team8;
  String team8Id;
  String team8point;
  String playerid8;
  String team9;
  String team9Id;
  String team9point;
  String playerid9;
  String team10;
  String team10Id;
  String team10point;
  String playerid10;

  Request(
      {this.teamName,
        this.leagueId,
        this.tournamentId,
        this.matchId,
        this.venueId,
        this.capton,
        this.captonId,
        this.captonpoint,
        this.playeridCapton,
        this.team1,
        this.team1Id,
        this.team1point,
        this.playerid1,
        this.team2,
        this.team2Id,
        this.team2point,
        this.playerid2,
        this.team3,
        this.team3Id,
        this.team3point,
        this.playerid3,
        this.team4,
        this.team4Id,
        this.team4point,
        this.playerid4,
        this.team5,
        this.team5Id,
        this.team5point,
        this.playerid5,
        this.team6,
        this.team6Id,
        this.team6point,
        this.playerid6,
        this.team7,
        this.team7Id,
        this.team7point,
        this.playerid7,
        this.team8,
        this.team8Id,
        this.team8point,
        this.playerid8,
        this.team9,
        this.team9Id,
        this.team9point,
        this.playerid9,
        this.team10,
        this.team10Id,
        this.team10point,
        this.playerid10});

  Request.fromJson(Map<String, dynamic> json) {
    teamName = json['team_name'];
    leagueId = json['leagueId'];
    tournamentId = json['tournamentId'];
    matchId = json['matchId'];
    venueId = json['venueId'];
    capton = json['capton'];
    captonId = json['captonId'];
    captonpoint = json['captonpoint'];
    playeridCapton = json['playerid_capton'];
    team1 = json['team1'];
    team1Id = json['team1Id'];
    team1point = json['team1point'];
    playerid1 = json['playerid1'];
    team2 = json['team2'];
    team2Id = json['team2Id'];
    team2point = json['team2point'];
    playerid2 = json['playerid2'];
    team3 = json['team3'];
    team3Id = json['team3Id'];
    team3point = json['team3point'];
    playerid3 = json['playerid3'];
    team4 = json['team4'];
    team4Id = json['team4Id'];
    team4point = json['team4point'];
    playerid4 = json['playerid4'];
    team5 = json['team5'];
    team5Id = json['team5Id'];
    team5point = json['team5point'];
    playerid5 = json['playerid5'];
    team6 = json['team6'];
    team6Id = json['team6Id'];
    team6point = json['team6point'];
    playerid6 = json['playerid6'];
    team7 = json['team7'];
    team7Id = json['team7Id'];
    team7point = json['team7point'];
    playerid7 = json['playerid7'];
    team8 = json['team8'];
    team8Id = json['team8Id'];
    team8point = json['team8point'];
    playerid8 = json['playerid8'];
    team9 = json['team9'];
    team9Id = json['team9Id'];
    team9point = json['team9point'];
    playerid9 = json['playerid9'];
    team10 = json['team10'];
    team10Id = json['team10Id'];
    team10point = json['team10point'];
    playerid10 = json['playerid10'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['team_name'] = this.teamName;
    data['leagueId'] = this.leagueId;
    data['tournamentId'] = this.tournamentId;
    data['matchId'] = this.matchId;
    data['venueId'] = this.venueId;
    data['capton'] = this.capton;
    data['captonId'] = this.captonId;
    data['captonpoint'] = this.captonpoint;
    data['playerid_capton'] = this.playeridCapton;
    data['team1'] = this.team1;
    data['team1Id'] = this.team1Id;
    data['team1point'] = this.team1point;
    data['playerid1'] = this.playerid1;
    data['team2'] = this.team2;
    data['team2Id'] = this.team2Id;
    data['team2point'] = this.team2point;
    data['playerid2'] = this.playerid2;
    data['team3'] = this.team3;
    data['team3Id'] = this.team3Id;
    data['team3point'] = this.team3point;
    data['playerid3'] = this.playerid3;
    data['team4'] = this.team4;
    data['team4Id'] = this.team4Id;
    data['team4point'] = this.team4point;
    data['playerid4'] = this.playerid4;
    data['team5'] = this.team5;
    data['team5Id'] = this.team5Id;
    data['team5point'] = this.team5point;
    data['playerid5'] = this.playerid5;
    data['team6'] = this.team6;
    data['team6Id'] = this.team6Id;
    data['team6point'] = this.team6point;
    data['playerid6'] = this.playerid6;
    data['team7'] = this.team7;
    data['team7Id'] = this.team7Id;
    data['team7point'] = this.team7point;
    data['playerid7'] = this.playerid7;
    data['team8'] = this.team8;
    data['team8Id'] = this.team8Id;
    data['team8point'] = this.team8point;
    data['playerid8'] = this.playerid8;
    data['team9'] = this.team9;
    data['team9Id'] = this.team9Id;
    data['team9point'] = this.team9point;
    data['playerid9'] = this.playerid9;
    data['team10'] = this.team10;
    data['team10Id'] = this.team10Id;
    data['team10point'] = this.team10point;
    data['playerid10'] = this.playerid10;
    return data;
  }
}
