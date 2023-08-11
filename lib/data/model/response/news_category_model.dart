class NewsCategoryModel {
  String message;
  int status;
  List<Data> data;

  NewsCategoryModel({this.message, this.status, this.data});

  NewsCategoryModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String sId;
  String name;
  String image;
  String updatedAt;
  String createdAt;
  int iV;

  Data(
      {this.sId,
        this.name,
        this.image,
        this.updatedAt,
        this.createdAt,
        this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    image = json['image'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['image'] = this.image;
    data['updatedAt'] = this.updatedAt;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}
