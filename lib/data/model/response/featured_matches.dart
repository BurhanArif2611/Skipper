class featuredMatches {
  Data data;
  Cache cache;
  Schema schema;
  Null error;
  int httpStatusCode;

  featuredMatches(
      {this.data, this.cache, this.schema, this.error, this.httpStatusCode});

  featuredMatches.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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

class Data {
  List<Tournaments> tournaments;

  Data({this.tournaments});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['tournaments'] != null) {
      tournaments = <Tournaments>[];
      json['tournaments'].forEach((v) {
        tournaments.add(new Tournaments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.tournaments != null) {
      data['tournaments'] = this.tournaments.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Tournaments {
  String key;
  String name;
  String shortName;
  List<Countries> countries;
  double startDate;
  String gender;
  String pointSystem;
  Competition competition;
  String associationKey;
  String metricGroup;
  String sport;
  bool isDateConfirmed;
  bool isVenueConfirmed;
  double lastScheduledMatchDate;
  List<String> formats;

  Tournaments(
      {this.key,
        this.name,
        this.shortName,
        this.countries,
        this.startDate,
        this.gender,
        this.pointSystem,
        this.competition,
        this.associationKey,
        this.metricGroup,
        this.sport,
        this.isDateConfirmed,
        this.isVenueConfirmed,
        this.lastScheduledMatchDate,
        this.formats});

  Tournaments.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    name = json['name'];
    shortName = json['short_name'];
    if (json['countries'] != null) {
      countries = <Countries>[];
      json['countries'].forEach((v) {
        countries.add(new Countries.fromJson(v));
      });
    }
    startDate = json['start_date'];
    gender = json['gender'];
    pointSystem = json['point_system'];
    competition = json['competition'] != null
        ? new Competition.fromJson(json['competition'])
        : null;
    associationKey = json['association_key'];
    metricGroup = json['metric_group'];
    sport = json['sport'];
    isDateConfirmed = json['is_date_confirmed'];
    isVenueConfirmed = json['is_venue_confirmed'];
    lastScheduledMatchDate = json['last_scheduled_match_date'];
    formats = json['formats'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['name'] = this.name;
    data['short_name'] = this.shortName;
    if (this.countries != null) {
      data['countries'] = this.countries.map((v) => v.toJson()).toList();
    }
    data['start_date'] = this.startDate;
    data['gender'] = this.gender;
    data['point_system'] = this.pointSystem;
    if (this.competition != null) {
      data['competition'] = this.competition.toJson();
    }
    data['association_key'] = this.associationKey;
    data['metric_group'] = this.metricGroup;
    data['sport'] = this.sport;
    data['is_date_confirmed'] = this.isDateConfirmed;
    data['is_venue_confirmed'] = this.isVenueConfirmed;
    data['last_scheduled_match_date'] = this.lastScheduledMatchDate;
    data['formats'] = this.formats;
    return data;
  }
}

class Countries {
  String shortCode;
  String code;
  String name;
  String officialName;
  bool isRegion;

  Countries(
      {this.shortCode, this.code, this.name, this.officialName, this.isRegion});

  Countries.fromJson(Map<String, dynamic> json) {
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

class Competition {
  String key;
  String code;
  String name;

  Competition({this.key, this.code, this.name});

  Competition.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    code = json['code'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['code'] = this.code;
    data['name'] = this.name;
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
