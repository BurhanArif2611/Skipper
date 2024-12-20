class BlockGeoList {
  Metadata metadata;
  List<Data> data;

  BlockGeoList({this.metadata, this.data});

  BlockGeoList.fromJson(Map<String, dynamic> json) {
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
  String id;
  double latitude;
  double longitude;
 /* double radiusInKm;*/
  bool status;
  String statename;

  Data(
      {this.id,
        this.latitude,
        this.longitude,
       /* this.radiusInKm,*/
        this.status,
        this.statename});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  /*  radiusInKm = json['radiusInKm']!=null ? json['radiusInKm']*1000:0.00;
  */  statename = json['statename'];
      status = json['status']!=null?json['status']:false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
   /* data['radiusInKm'] = this.radiusInKm;
   */
    data['statename'] = this.statename;
    data['status'] = this.status;
    return data;
  }
}
