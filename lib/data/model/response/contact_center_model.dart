class ContactCenterModel {
  List<Docs> docs;
  int total;
  int limit;
  int page;
  int pages;

  ContactCenterModel({this.docs, this.total, this.limit, this.page, this.pages});

  ContactCenterModel.fromJson(Map<String, dynamic> json) {
    if (json['docs'] != null) {
      docs = <Docs>[];
      json['docs'].forEach((v) {
        docs.add(new Docs.fromJson(v));
      });
    }
    total = json['total'];
    limit = json['limit'];
    page = json['page'];
    pages = json['pages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.docs != null) {
      data['docs'] = this.docs.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    data['limit'] = this.limit;
    data['page'] = this.page;
    data['pages'] = this.pages;
    return data;
  }
}

class Docs {
  String sId;
  String name;
  String email;
  String designation;
  int mobileNumber;
  String updatedAt;
  String createdAt;
  int iV;

  Docs(
      {this.sId,
        this.name,
        this.email,
        this.designation,
        this.mobileNumber,
        this.updatedAt,
        this.createdAt,
        this.iV});

  Docs.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    designation = json['designation'];
    mobileNumber = json['mobile_number'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['designation'] = this.designation;
    data['mobile_number'] = this.mobileNumber;
    data['updatedAt'] = this.updatedAt;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}
