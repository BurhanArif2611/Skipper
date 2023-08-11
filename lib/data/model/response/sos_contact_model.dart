class SOSContactModel {
  List<Data> data;

  SOSContactModel({this.data});

  SOSContactModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String sId;
  String name;
  String relation;
  String number;
  String user;
  String updatedAt;
  String createdAt;
  int iV;

  Data(
      {this.sId,
      this.name,
      this.relation,
      this.number,
      this.user,
      this.updatedAt,
      this.createdAt,
      this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    relation = json['relation'];
    number = json['number'];
    user = json['user'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['relation'] = this.relation;
    data['number'] = this.number;
    data['user'] = this.user;
    data['updatedAt'] = this.updatedAt;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}
