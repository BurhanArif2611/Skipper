import 'dart:ffi';

class featuredMatches {
  MatchData data;
  Cache cache;
  Schema schema;
  Null error;
  int httpStatusCode;

  featuredMatches(
      {this.data, this.cache, this.schema, this.error, this.httpStatusCode});

  featuredMatches.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new MatchData.fromJson(json['data']) : null;
    cache = json['cache'] != null ? new Cache.fromJson(json['cache']) : null;
    schema =
    json['schema'] != null ? new Schema.fromJson(json['schema']) : null;
    error = json['error'];
    httpStatusCode = json['http_status_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    if (this.cache != null) {
      data['cache'] = this.cache.toJson();
    }
    if (this.schema != null) {
      data['schema'] = this.schema.toJson();
    }
    data['error'] = this.error;
    data['http_status_code'] = this.httpStatusCode;
    return data;
  }
}

class MatchData {
  List<Matches> matches;
  List<String> intelligentOrder;

  MatchData({this.matches, this.intelligentOrder});

  MatchData.fromJson(Map<String, dynamic> json) {
    if (json['matches'] != null) {
      matches = <Matches>[];
      json['matches'].forEach((v) {
        matches.add(new Matches.fromJson(v));
      });
    }
    intelligentOrder = json['intelligent_order'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.matches != null) {
      data['matches'] = this.matches.map((v) => v.toJson()).toList();
    }
    data['intelligent_order'] = this.intelligentOrder;
    return data;
  }
}

class Matches {
  String key;
  String name;
  String shortName;
  String subTitle;
  TeamsNames teams;
  double startAt;
  Venue venue;
  Tournament tournament;
  Association association;
  String metricGroup;
  String status;
  Null winner;
  List<Null> messages;
  String gender;
  String sport;
  String format;

  Matches(
      {this.key,
        this.name,
        this.shortName,
        this.subTitle,
        this.teams,
        this.startAt,
        this.venue,
        this.tournament,
        this.association,
        this.metricGroup,
        this.status,
        this.winner,
        this.messages,
        this.gender,
        this.sport,
        this.format});

  Matches.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    name = json['name'];
    shortName = json['short_name'];
    subTitle = json['sub_title'];
    teams = json['teams'] != null ? new TeamsNames.fromJson(json['teams']) : null;
    startAt = json['start_at'] is Double?json['start_at']:json['start_at'].toDouble();
    venue = json['venue'] != null ? new Venue.fromJson(json['venue']) : null;
    tournament = json['tournament'] != null
        ? new Tournament.fromJson(json['tournament'])
        : null;
    association = json['association'] != null
        ? new Association.fromJson(json['association'])
        : null;
    metricGroup = json['metric_group'];
    status = json['status'];
    winner = json['winner'];
    if (json['messages'] != null) {
     /* messages = <Null>[];
      json['messages'].forEach((v) {
        messages.add(new Null.fromJson(v));
      });*/
    }
    gender = json['gender'];
    sport = json['sport'];
    format = json['format'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['name'] = this.name;
    data['short_name'] = this.shortName;
    data['sub_title'] = this.subTitle;
    if (this.teams != null) {
      data['teams'] = this.teams.toJson();
    }
    data['start_at'] = this.startAt;
    if (this.venue != null) {
      data['venue'] = this.venue.toJson();
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
    if (this.messages != null) {
      //data['messages'] = this.messages.map((v) => v.toJson()).toList();
    }
    data['gender'] = this.gender;
    data['sport'] = this.sport;
    data['format'] = this.format;
    return data;
  }
}

class TeamsNames {
  A a;
  A b;

  TeamsNames({this.a, this.b});

  TeamsNames.fromJson(Map<String, dynamic> json) {
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

class A {
  String key;
  String code;
  String name;
  Null countryCode;

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
  Null country;
  Null parent;

  Association({this.key, this.code, this.name, this.country, this.parent});

  Association.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    code = json['code'];
    name = json['name'];
    country = json['country'];
    parent = json['parent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['code'] = this.code;
    data['name'] = this.name;
    data['country'] = this.country;
    data['parent'] = this.parent;
    return data;
  }
}

class Cache {
  String key;
  double expires;
  String etag;
  int maxAge;

  Cache({this.key, this.expires, this.etag, this.maxAge});

  Cache.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    expires = json['expires'];
    etag = json['etag'];
    maxAge = json['max_age'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['expires'] = this.expires;
    data['etag'] = this.etag;
    data['max_age'] = this.maxAge;
    return data;
  }
}

class Schema {
  String majorVersion;
  String minorVersion;

  Schema({this.majorVersion, this.minorVersion});

  Schema.fromJson(Map<String, dynamic> json) {
    majorVersion = json['major_version'];
    minorVersion = json['minor_version'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['major_version'] = this.majorVersion;
    data['minor_version'] = this.minorVersion;
    return data;
  }
}
