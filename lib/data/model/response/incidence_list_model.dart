class IncidenceListModel {
  List<Docs> docs;
  int total;
  int limit;
  int page;
  int pages;

  IncidenceListModel({this.docs, this.total, this.limit, this.page, this.pages});

  IncidenceListModel.fromJson(Map<String, dynamic> json) {
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
  List<String> images;
  List<String> video;
  String sId;
  Lga lga;
  User user;
  IncidentType incidentType;
  SubCategorieId subCategorieId;
  State state;
  String shortDescription;
  int status;
  bool isAnonymous;
  int comments;
  int view;
  String createdAt;

  Docs(
      {this.images,
        this.video,
        this.sId,
        this.lga,
        this.user,
        this.incidentType,
        this.subCategorieId,
        this.state,
        this.shortDescription,
        this.status,
        this.isAnonymous,
        this.comments,
        this.view,
        this.createdAt});

  Docs.fromJson(Map<String, dynamic> json) {
    images = json['images'].cast<String>();
    video = json['video'].cast<String>();
    sId = json['_id'];
    lga = json['lga'] != null ? new Lga.fromJson(json['lga']) : null;
    user = json['user'] != null?  new User.fromJson(json['user']) : null;
    incidentType = json['incident_type'] != null ?
         new IncidentType.fromJson(json['incident_type'])
        : null;
    subCategorieId = json['sub_categorie_id'] != null ?
         new SubCategorieId.fromJson(json['sub_categorie_id'])
        : null;
    state = json['state'] != null ? new State.fromJson(json['state']) : null;
    shortDescription = json['short_description'];
    status = json['status'];
    isAnonymous = json['isAnonymous'];
    comments = json['comments'];
    view = json['view'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['images'] = this.images;
    data['video'] = this.video;
    data['_id'] = this.sId;
    if (this.lga != null) {
      data['lga'] = this.lga.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    if (this.incidentType != null) {
      data['incident_type'] = this.incidentType.toJson();
    }
    if (this.subCategorieId != null) {
      data['sub_categorie_id'] = this.subCategorieId.toJson();
    }
    if (this.state != null) {
      data['state'] = this.state.toJson();
    }
    data['short_description'] = this.shortDescription;
    data['status'] = this.status;
    data['isAnonymous'] = this.isAnonymous;
    data['comments'] = this.comments;
    data['view'] = this.view;
    data['createdAt'] = this.createdAt;
    return data;
  }
}

class Lga {
  String sId;
  String name;
  String state;
  String updatedAt;
  String createdAt;
  int iV;

  Lga(
      {this.sId,
        this.name,
        this.state,
        this.updatedAt,
        this.createdAt,
        this.iV});

  Lga.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    state = json['state'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['state'] = this.state;
    data['updatedAt'] = this.updatedAt;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}

class User {
  Name name;
  int role;
  String anonymous;
  String email;
  String passwordToken;
  String mobileNumber;
  String expireTime;
  List<int> scope;
  String sId;

  User(
      {this.name,
        this.role,
        this.anonymous,
        this.email,
        this.passwordToken,
        this.mobileNumber,
        this.expireTime,
        this.scope,
        this.sId});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'] != null ? new Name.fromJson(json['name']) : null;
    role = json['role'];
    anonymous = json['anonymous'];
    email = json['email'];
    passwordToken = json['password_token'];
    mobileNumber = json['mobile_number'];
    expireTime = json['expire_time'];
    scope = json['scope'].cast<int>();
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.name != null) {
      data['name'] = this.name.toJson();
    }
    data['role'] = this.role;
    data['anonymous'] = this.anonymous;
    data['email'] = this.email;
    data['password_token'] = this.passwordToken;
    data['mobile_number'] = this.mobileNumber;
    data['expire_time'] = this.expireTime;
    data['scope'] = this.scope;
    data['_id'] = this.sId;
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

class IncidentType {
  List<Null> subCategories;
  String sId;
  String name;
  String hash;
  String updatedAt;
  String createdAt;
  int iV;
  int puCount;
  StateCount stateCount;

  IncidentType(
      {this.subCategories,
        this.sId,
        this.name,
        this.hash,
        this.updatedAt,
        this.createdAt,
        this.iV,
        this.puCount,
        this.stateCount});

  IncidentType.fromJson(Map<String, dynamic> json) {
    if (json['subCategories'] != null) {
      subCategories = <Null>[];
     /* json['subCategories'].forEach((v) {
        subCategories.add(new Null.fromJson(v));
      });*/
    }
    sId = json['_id'];
    name = json['name']!=null?json['name']:"";
    hash = json['hash'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
    iV = json['__v'];
    puCount = json['puCount'];
    stateCount = json['stateCount'] != null ?
         new StateCount.fromJson(json['stateCount'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.subCategories != null) {
     /* data['subCategories'] =
          this.subCategories.map((v) => v.toJson()).toList();*/
    }
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['hash'] = this.hash;
    data['updatedAt'] = this.updatedAt;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    data['puCount'] = this.puCount;
    if (this.stateCount != null) {
      data['stateCount'] = this.stateCount.toJson();
    }
    return data;
  }
}

class StateCount {
  int i5c3c2ac527f33d2961299507;

  StateCount({this.i5c3c2ac527f33d2961299507});

  StateCount.fromJson(Map<String, dynamic> json) {
    i5c3c2ac527f33d2961299507 = json['5c3c2ac527f33d2961299507'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['5c3c2ac527f33d2961299507'] = this.i5c3c2ac527f33d2961299507;
    return data;
  }
}

class SubCategorieId {
  String sId;
  String name;
  String hash;
  String incidentTypeId;
  String updatedAt;
  String createdAt;
  int iV;

  SubCategorieId(
      {this.sId,
        this.name,
        this.hash,
        this.incidentTypeId,
        this.updatedAt,
        this.createdAt,
        this.iV});

  SubCategorieId.fromJson(Map<String, dynamic> json) {
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

class State {
  String sId;
  String name;
  String updatedAt;
  String createdAt;
  int iV;

  State({this.sId, this.name, this.updatedAt, this.createdAt, this.iV});

  State.fromJson(Map<String, dynamic> json) {
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