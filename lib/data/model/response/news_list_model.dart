class NewsListModel {
  String message;
  int status;
  Data data;

  NewsListModel({this.message, this.status, this.data});

  NewsListModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  List<Docs> docs;
  int total;
  int limit;
  int page;
  int pages;

  Data({this.docs, this.total, this.limit, this.page, this.pages});

  Data.fromJson(Map<String, dynamic> json) {
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
  String title;
  Category category;
  String description;
  String image;
  String updatedAt;
  String createdAt;
  int iV;

  Docs(
      {this.sId,
        this.title,
        this.category,
        this.description,
        this.image,
        this.updatedAt,
        this.createdAt,
        this.iV});

  Docs.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    category = json['category'] != null ?
         new Category.fromJson(json['category'])
        : null;
    description = json['description'];
    image = json['image'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    if (this.category != null) {
      data['category'] = this.category.toJson();
    }
    data['description'] = this.description;
    data['image'] = this.image;
    data['updatedAt'] = this.updatedAt;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Category {
  String sId;
  String name;
  String image;
  String updatedAt;
  String createdAt;
  int iV;

  Category(
      {this.sId,
        this.name,
        this.image,
        this.updatedAt,
        this.createdAt,
        this.iV});

  Category.fromJson(Map<String, dynamic> json) {
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
