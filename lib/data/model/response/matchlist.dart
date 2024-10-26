import 'featured_matches.dart';
import 'matchList/matches.dart';

class Matchlist {
  Metadata metadata;
  List<Matches> data;

  Matchlist({this.metadata, this.data});

  Matchlist.fromJson(Map<String, dynamic> json) {
    metadata = json['metadata'] != null
        ? new Metadata.fromJson(json['metadata'])
        : null;
    if (json['data'] != null) {
      data = <Matches>[];
      json['data'].forEach((v) {
        data.add(new Matches.fromJson(v));
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
  List<Matches> matches;
  Null previousPageKey;
  int nextPageKey;

  Data({this.matches, this.previousPageKey, this.nextPageKey});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['matches'] != null) {
      matches = <Matches>[];
      json['matches'].forEach((v) {
        matches.add(new Matches.fromJson(v));
      });
    }
    previousPageKey = json['previous_page_key'];
    nextPageKey = json['next_page_key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.matches != null) {
      data['matches'] = this.matches.map((v) => v.toJson()).toList();
    }
    data['previous_page_key'] = this.previousPageKey;
    data['next_page_key'] = this.nextPageKey;
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
