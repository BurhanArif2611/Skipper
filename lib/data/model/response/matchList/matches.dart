import 'package:intl/intl.dart';
class Matches {
  String key;
  String name;
  String shortName;
  String subTitle;
  Teams teams;
  String startAt;
  String start_at_local;
  Venue venue;
  Tournament tournament;
  Association association;
  String metricGroup;
  String status;
  String winner;
  /* List<Null> messages;*/
  String gender;
  String sport;
  String play_status;
  String position;
  String format;
  Squad squad;

  Matches(
      {this.key,
        this.name,
        this.shortName,
        this.subTitle,
        this.teams,
        this.startAt,
        this.start_at_local,
        this.venue,
        this.tournament,
        this.association,
        this.metricGroup,
        this.status,
        this.winner,
        /* this.messages,*/
        this.gender,
        this.sport,
        this.play_status,
        this.position,

        this.squad,
        this.format});

  Matches.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    name = json['name'];
    shortName = json['short_name'];
    subTitle = json['sub_title'];
    play_status = json['play_status']!=null?json['play_status']:"";
    position = json['position']!=null?json['position']:"0";
    teams = json['teams'] != null ? new Teams.fromJson(json['teams']) : null;
    startAt =json['start_at']!=null ? changeDateFormat(json['start_at'].toString()):"";
    start_at_local =json['start_at_local']!=null ? changeDateFormat(json['start_at_local'].toString()):"";
    venue = json['venue'] != null ? new Venue.fromJson(json['venue']) : null;
    squad = json['squad'] != null ? new Squad.fromJson(json['squad']) : null;
    tournament = json['tournament'] != null
        ? new Tournament.fromJson(json['tournament'])
        : null;
    association = json['association'] != null
        ? new Association.fromJson(json['association'])
        : null;
    metricGroup = json['metric_group'];
    status = json['status'];
    winner = json['winner'];
    /*if (json['messages'] != null) {
      messages = <Null>[];
      json['messages'].forEach((v) {
        messages.add(new Null.fromJson(v));
      });
    }*/
    gender = json['gender'];
    sport = json['sport'];
    format = json['format'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['name'] = this.name;
    data['short_name'] = this.shortName;
    data['play_status'] = this.play_status;
    data['position'] = this.position;
    data['sub_title'] = this.subTitle;
    if (this.teams != null) {
      data['teams'] = this.teams.toJson();
    }
    data['start_at'] = this.startAt;
    data['start_at_local'] = this.start_at_local;
    if (this.venue != null) {
      data['venue'] = this.venue.toJson();
    } if (this.squad != null) {
      data['squad'] = this.squad.toJson();
    }
    if (this.tournament != null) {
      data['tournament'] = this.tournament.toJson();
    }
    if (this.association != null) {
      data['association'] = this.association.toJson();
    }
    data['metric_group'] = this.metricGroup;
    data['status'] = this.status;
    data['winner'] = this.winner;
    /*if (this.messages != null) {
      data['messages'] = this.messages.map((v) => v.toJson()).toList();
    }*/
    data['gender'] = this.gender;
    data['sport'] = this.sport;
    data['format'] = this.format;
    return data;
  }

  String changeDateFormat(String date) {
    try {
      // Treat the input as GMT by appending 'Z'
      DateTime dateTime = DateTime.parse("${date}Z").toUtc();
      DateTime localTime = dateTime.toLocal();

      // Format the local time
      String formattedDate = DateFormat('dd MMM yyyy \n hh:mm a').format(localTime);
      return formattedDate;
    } catch (e) {
      // Return an empty string in case of an error
      return "";
    }
  }
}
class Squad{
  SquadListTeam a;
  SquadListTeam b;
  Squad({this.a, this.b});

  Squad.fromJson(Map<String, dynamic> json) {
    a = json['a'] != null ? new SquadListTeam.fromJson(json['a']) : null;
    b = json['b'] != null ? new SquadListTeam.fromJson(json['b']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.a != null) {
      data['a'] = this.a.toJson();
    }
    if (this.b != null) {
      data['b'] = this.b.toJson();
    }
    return data;
  }
}

class Teams {
  A a;
  A b;

  Teams({this.a, this.b});

  Teams.fromJson(Map<String, dynamic> json) {
    a = json['a'] != null ? new A.fromJson(json['a']) : null;
    b = json['b'] != null ? new A.fromJson(json['b']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.a != null) {
      data['a'] = this.a.toJson();
    }
    if (this.b != null) {
      data['b'] = this.b.toJson();
    }
    return data;
  }
}
class SquadListTeam {
  List<String> playerKeys;
  String captain;
  String keeper;
  List<String> playingXi;
  List<String> replacements;

  SquadListTeam(
      {this.playerKeys,
        this.captain,
        this.keeper,
        this.playingXi,
        this.replacements});

  SquadListTeam.fromJson(Map<String, dynamic> json) {
    playerKeys = json['player_keys'].cast<String>();
    captain = json['captain'];
    keeper = json['keeper'];
    playingXi = json['playing_xi'].cast<String>();
    replacements = json['replacements'].cast<String>();

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['player_keys'] = this.playerKeys;
    data['captain'] = this.captain;
    data['keeper'] = this.keeper;
    data['playing_xi'] = this.playingXi;
    data['replacements'] = this.replacements;

    return data;
  }
}

class A {
  String key;
  String code;
  String name;
  String countryCode;

  A({this.key, this.code, this.name, this.countryCode});

  A.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    code = json['code'];
    name = json['name'];
    countryCode = json['country_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['code'] = this.code;
    data['name'] = this.name;
    data['country_code'] = this.countryCode;
    return data;
  }
}

class Venue {
  String key;
  String name;
  String city;
  Country country;

  Venue({this.key, this.name, this.city, this.country});

  Venue.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    name = json['name'];
    city = json['city'];
    country =
    json['country'] != null ? new Country.fromJson(json['country']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['name'] = this.name;
    data['city'] = this.city;
    if (this.country != null) {
      data['country'] = this.country.toJson();
    }
    return data;
  }
}

class Country {
  String shortCode;
  String code;
  String name;
  String officialName;
  bool isRegion;

  Country(
      {this.shortCode, this.code, this.name, this.officialName, this.isRegion});

  Country.fromJson(Map<String, dynamic> json) {
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

class Tournament {
  String key;
  String name;
  String shortName;

  Tournament({this.key, this.name, this.shortName});

  Tournament.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    name = json['name'];
    shortName = json['short_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['name'] = this.name;
    data['short_name'] = this.shortName;
    return data;
  }
}

class Association {
  String key;
  String code;
  String name;
  /* Null country;*/
  Null parent;

  Association({this.key, this.code, this.name/*, this.country*/, this.parent});

  Association.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    code = json['code'];
    name = json['name'];
    /* country = json['country'];*/
    parent = json['parent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['code'] = this.code;
    data['name'] = this.name;
    /*data['country'] = this.country;*/
    data['parent'] = this.parent;
    return data;
  }
}

