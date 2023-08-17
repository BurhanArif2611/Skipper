class CountryListModel {
  String sId;
  String name;
  String updatedAt;
  String createdAt;
  int iV;

  CountryListModel({this.sId, this.name, this.updatedAt, this.createdAt, this.iV});

  CountryListModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['updatedAt'] = this.updatedAt;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}
