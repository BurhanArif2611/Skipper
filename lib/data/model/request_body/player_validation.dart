class PlayerValidation {
  String playerID;
  String skills;

  PlayerValidation({this.playerID, this.skills});

  PlayerValidation.fromJson(Map<String, dynamic> json) {
    playerID = json['playerID'];
    skills = json['skills'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['playerID'] = this.playerID;
    data['skills'] = this.skills;
    return data;
  }
}
