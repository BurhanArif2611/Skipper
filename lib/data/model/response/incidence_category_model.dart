class IncidenceCategoryModel {
  List<SubCategories> subCategories;
  String sId;
  String name;
  String hash;
  String updatedAt;
  String createdAt;
  int iV;

  IncidenceCategoryModel(
      {this.subCategories,
      this.sId,
      this.name,
      this.hash,
      this.updatedAt,
      this.createdAt,
      this.iV});

  IncidenceCategoryModel.fromJson(Map<String, dynamic> json) {
    if (json['subCategories'] != null) {
      subCategories = <SubCategories>[];
      json['subCategories'].forEach((v) {
        subCategories.add(new SubCategories.fromJson(v));
      });
    }
    sId = json['_id'];
    name = json['name'];
    hash = json['hash'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.subCategories != null) {
      data['subCategories'] =
          this.subCategories.map((v) => v.toJson()).toList();
    }
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['hash'] = this.hash;
    data['updatedAt'] = this.updatedAt;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}

class SubCategories {
  String sId;
  String name;
  String hash;
  String incidentTypeId;
  String updatedAt;
  String createdAt;
  int iV;

  SubCategories(
      {this.sId,
      this.name,
      this.hash,
      this.incidentTypeId,
      this.updatedAt,
      this.createdAt,
      this.iV});

  SubCategories.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    hash = json['hash'];
    incidentTypeId = json['incident_type_id'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['hash'] = this.hash;
    data['incident_type_id'] = this.incidentTypeId;
    data['updatedAt'] = this.updatedAt;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}
