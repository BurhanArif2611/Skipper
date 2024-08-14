class CreateTeamRequest {
  UserDetails userDetails;
  Request request;

  CreateTeamRequest({this.userDetails, this.request});

  CreateTeamRequest.fromJson(Map<String, dynamic> json) {
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
  String userId;
  String emailId;

  UserDetails({this.userId, this.emailId});

  UserDetails.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    emailId = json['email_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['email_id'] = this.emailId;
    return data;
  }
}

class Request {
  String teamName;
  String tournamentId;
  String matchId;
  String venueId;
  List<Teams> teams;

  Request(
      {this.teamName,
        this.tournamentId,
        this.matchId,
        this.venueId,
        this.teams});

  Request.fromJson(Map<String, dynamic> json) {
    teamName = json['team_name'];
    tournamentId = json['tournamentId'];
    matchId = json['matchId'];
    venueId = json['venueId'];
    if (json['teams'] != null) {
      teams = <Teams>[];
      json['teams'].forEach((v) {
        teams.add(new Teams.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['team_name'] = this.teamName;
    data['tournamentId'] = this.tournamentId;
    data['matchId'] = this.matchId;
    data['venueId'] = this.venueId;
    if (this.teams != null) {
      data['teams'] = this.teams.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Teams {
  String playerId;
  String name;
  double point;
  String positionId;

  Teams({this.playerId, this.name, this.point, this.positionId});

  Teams.fromJson(Map<String, dynamic> json) {
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
