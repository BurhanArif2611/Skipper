class RegionsResponse {
  String message;
  List<RegionsData> data;

  RegionsResponse({this.message, this.data});

  RegionsResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <RegionsData>[];
      json['data'].forEach((v) {
        data.add(new RegionsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RegionsData {
  int id;
  String provinces;
  String chiefPlace;
  Null createdAt;
  Null updatedAt;

  RegionsData(
      {this.id,
        this.provinces,
        this.chiefPlace,
        this.createdAt,
        this.updatedAt});

  RegionsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    provinces = json['provinces'];
    chiefPlace = json['chief_place'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['provinces'] = this.provinces;
    data['chief_place'] = this.chiefPlace;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
