class BannerList {
  Metadata metadata;
  List<Data> data;

  BannerList({this.metadata, this.data});

  BannerList.fromJson(Map<String, dynamic> json) {
    metadata = json['metadata'] != null
        ? new Metadata.fromJson(json['metadata'])
        : null;
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
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
  String bannerId;
  String urlDetails;
  String bannerName;
  String banner;
  String bannerDescription;
  String bannerStatus;
  String createdAt;
  String updatedAt;

  Data(
      {this.bannerId,
        this.urlDetails,
        this.bannerName,
        this.banner,
        this.bannerDescription,
        this.bannerStatus,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    bannerId = json['banner_id'];
    urlDetails = json['url_details'];
    bannerName = json['banner_name'];
    banner = json['banner'];
    bannerDescription = json['banner_description'];
    bannerStatus = json['banner_status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['banner_id'] = this.bannerId;
    data['url_details'] = this.urlDetails;
    data['banner_name'] = this.bannerName;
    data['banner'] = this.banner;
    data['banner_description'] = this.bannerDescription;
    data['banner_status'] = this.bannerStatus;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
