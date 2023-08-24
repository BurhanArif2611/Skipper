class ComplaintListModel {
  List<Docs> docs;
  int total;
  int limit;
  int page;
  int pages;

  ComplaintListModel({this.docs, this.total, this.limit, this.page, this.pages});

  ComplaintListModel.fromJson(Map<String, dynamic> json) {
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
  String image;
  String user;
  String category;
  String complaint;
  int status;
  String updatedAt;
  String createdAt;
  int iV;

  Docs(
      {this.sId,
        this.image,
        this.user,
        this.category,
        this.complaint,
        this.status,
        this.updatedAt,
        this.createdAt,
        this.iV});

  Docs.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    image = json['image'];
    user = json['user'];
    category = json['category'];
    complaint = json['complaint'];
    status = json['status'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['image'] = this.image;
    data['user'] = this.user;
    data['category'] = this.category;
    data['complaint'] = this.complaint;
    data['status'] = this.status;
    data['updatedAt'] = this.updatedAt;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}
