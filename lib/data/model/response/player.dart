class Player{
  String key;
  String name;
  String jerseyName;
  String legalName;
  String gender;
  Nationality nationality;
  String dateOfBirth;
  String seasonalRole;
  List<String> roles;
  String battingStyle;
  BowlingStyle bowlingStyle;
  List<String> skills;

  Player(
      {this.key,
        this.name,
        this.jerseyName,
        this.legalName,
        this.gender,
        this.nationality,
        this.dateOfBirth,
        this.seasonalRole,
        this.roles,
        this.battingStyle,
        this.bowlingStyle,
        this.skills});

  Player.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    name = json['name'];
    jerseyName = json['jersey_name'];
    legalName = json['legal_name'];
    gender = json['gender'];
    nationality = json['nationality'] != null
        ? new Nationality.fromJson(json['nationality'])
        : null;
    dateOfBirth = json['date_of_birth'].toString();
    seasonalRole = json['seasonal_role'];
    roles = json['roles'].cast<String>();
    battingStyle = json['batting_style'];
    bowlingStyle = json['bowling_style'] !=null?new BowlingStyle.fromJson(json['bowling_style']):null;
    skills = json['skills'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['name'] = this.name;
    data['jersey_name'] = this.jerseyName;
    data['legal_name'] = this.legalName;
    data['gender'] = this.gender;
    if (this.nationality != null) {
      data['nationality'] = this.nationality.toJson();
    }
    data['date_of_birth'] = this.dateOfBirth;
    data['seasonal_role'] = this.seasonalRole;
    data['roles'] = this.roles;
    data['batting_style'] = this.battingStyle;


    if (this.bowlingStyle != null) {
      data['bowling_style'] = this.bowlingStyle.toJson();
    }
    data['skills'] = this.skills;
    return data;
  }
}

class Nationality {
  String shortCode;
  String code;
  String name;
  String officialName;
  bool isRegion;

  Nationality(
      {this.shortCode, this.code, this.name, this.officialName, this.isRegion});

  Nationality.fromJson(Map<String, dynamic> json) {
    shortCode = json['short_code'];
    code = json['code'];
    name = json['name'];
    officialName = json['official_name'];
    isRegion = json['is_region'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['short_code'] = this.shortCode;
    data['code'] = this.code;
    data['name'] = this.name;
    data['official_name'] = this.officialName;
    data['is_region'] = this.isRegion;
    return data;
  }


}

class BowlingStyle {
  String arm;
  String pace;
  String bowlingType;


  BowlingStyle({this.arm, this.pace, this.bowlingType});

  BowlingStyle.fromJson(Map<String, dynamic> json) {
    arm = json['arm'];
    pace = json['pace'];
    bowlingType = json['bowling_type']!=null?json['bowling_type']:"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['arm'] = this.arm;
    data['pace'] = this.pace;
    data['bowling_type'] = this.bowlingType;
    return data;
  }
}

