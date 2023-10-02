class SurveyListModel {
  String message;
  int status;
  Data data;

  SurveyListModel({this.message, this.status, this.data});

  SurveyListModel.fromJson(Map<String, dynamic> json) {
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
  Docs docs;

  Data({this.docs});

  Data.fromJson(Map<String, dynamic> json) {
    docs = json['docs'] != null ? new Docs.fromJson(json['docs']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.docs != null) {
      data['docs'] = this.docs.toJson();
    }
    return data;
  }
}

class Docs {
  List<PendingSurvey> pendingSurvey;
  List<PendingSurvey> completedSurvey;

  Docs({this.pendingSurvey, this.completedSurvey});

  Docs.fromJson(Map<String, dynamic> json) {
    if (json['pending_survey'] != null) {
      pendingSurvey = <PendingSurvey>[];
      json['pending_survey'].forEach((v) {
        pendingSurvey.add(new PendingSurvey.fromJson(v));
      });
    }
    if (json['completed_survey'] != null) {
      completedSurvey = <PendingSurvey>[];
      json['completed_survey'].forEach((v) {
        completedSurvey.add(new PendingSurvey.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pendingSurvey != null) {
      data['pending_survey'] =
          this.pendingSurvey.map((v) => v.toJson()).toList();
    }
    if (this.completedSurvey != null) {
      data['completed_survey'] =
          this.completedSurvey.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PendingSurvey {
  String sId;
  String title;
  String description;
  String updatedAt;
  String createdAt;
  int iV;
  bool isSubmitted;
  bool isActive;

  PendingSurvey(
      {this.sId,
        this.title,
        this.description,
        this.updatedAt,
        this.createdAt,
        this.iV,
        this.isSubmitted,
        this.isActive});

  PendingSurvey.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
    iV = json['__v'];
    isSubmitted = json['isSubmitted'];
    isActive = json['isActive'];
    description = json['description']!=null? json['description']:"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['updatedAt'] = this.updatedAt;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    data['isSubmitted'] = this.isSubmitted;
    data['isActive'] = this.isActive;
    return data;
  }
}
