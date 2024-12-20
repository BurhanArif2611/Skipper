class AppInfoModel {
  Metadata metadata;
  Data data;

  AppInfoModel({this.metadata, this.data});

  AppInfoModel.fromJson(Map<String, dynamic> json) {
    metadata = json['metadata'] != null
        ? new Metadata.fromJson(json['metadata'])
        : null;
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.metadata != null) {
      data['metadata'] = this.metadata.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data.toJson();
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
  String versionIOS;
  String versionAndriod;
  String version;
  String build;
  String buildDate;

  Data({this.versionIOS, this.versionAndriod, this.version, this.build, this.buildDate});

  Data.fromJson(Map<String, dynamic> json) {
    versionIOS = json['versionIOS'];
    versionAndriod = json['versionAndriod'];
    version = json['version'];
    build = json['build'];
    buildDate = json['buildDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['versionIOS'] = this.versionIOS;
    data['versionAndriod'] = this.versionAndriod;
    data['version'] = this.version;
    data['build'] = this.build;
    data['buildDate'] = this.buildDate;
    return data;
  }
}
