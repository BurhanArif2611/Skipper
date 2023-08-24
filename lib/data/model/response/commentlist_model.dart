class CommentListModel {
  List<Docs> docs;
  int total;
  int limit;
  int page;
  int pages;

  CommentListModel({this.docs, this.total, this.limit, this.page, this.pages});

  CommentListModel.fromJson(Map<String, dynamic> json) {
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
  String text;
  User user;
  String incident;
  String scope;
  String sId;
  String createdAt;

  Docs(
      {this.text,
      this.user,
      this.incident,
      this.scope,
      this.sId,
      this.createdAt});

  Docs.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    incident = json['incident'];
    scope = json['scope'];
    sId = json['_id'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['incident'] = this.incident;
    data['scope'] = this.scope;
    data['_id'] = this.sId;
    data['createdAt'] = this.createdAt;
    return data;
  }
}

class User {
  Name name;
  String sId;
  String image;

  User({this.name, this.sId, this.image});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'] != null ? new Name.fromJson(json['name']) : null;
    sId = json['_id'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.name != null) {
      data['name'] = this.name.toJson();
    }
    data['_id'] = this.sId;
    data['image'] = this.image;
    return data;
  }
}

class Name {
  String first;
  String last;

  Name({this.first, this.last});

  Name.fromJson(Map<String, dynamic> json) {
    first = json['first'];
    last = json['last'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first'] = this.first;
    data['last'] = this.last;
    return data;
  }
}
