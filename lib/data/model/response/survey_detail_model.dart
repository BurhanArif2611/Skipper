class SurveyDetailModel {
  String message;
  int status;
  Data data;

  SurveyDetailModel({this.message, this.status, this.data});

  SurveyDetailModel.fromJson(Map<String, dynamic> json) {
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
  Survey survey;
  List<SurveyQuestions> surveyQuestions;

  Data({this.survey, this.surveyQuestions});

  Data.fromJson(Map<String, dynamic> json) {
    survey =
    json['survey'] != null?  new Survey.fromJson(json['survey']) : null;
    if (json['surveyQuestions'] != null) {
      surveyQuestions = <SurveyQuestions>[];
      json['surveyQuestions'].forEach((v) {
        surveyQuestions.add(new SurveyQuestions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.survey != null) {
      data['survey'] = this.survey.toJson();
    }
    if (this.surveyQuestions != null) {
      data['surveyQuestions'] =
          this.surveyQuestions.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Survey {
  String sId;
  String title;
  bool isActive;
  String updatedAt;
  String createdAt;
  int iV;

  Survey(
      {this.sId,
        this.title,
        this.isActive,
        this.updatedAt,
        this.createdAt,
        this.iV});

  Survey.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    isActive = json['isActive'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['isActive'] = this.isActive;
    data['updatedAt'] = this.updatedAt;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}

class SurveyQuestions {
  String sId;
  String surveyId;
  String question;
  List<Options> options;
  String updatedAt;
  String createdAt;
  int iV;

  SurveyQuestions(
      {this.sId,
        this.surveyId,
        this.question,
        this.options,
        this.updatedAt,
        this.createdAt,
        this.iV});

  SurveyQuestions.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    surveyId = json['survey_id'];
    question = json['question'];
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options.add(new Options.fromJson(v));
      });
    }
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['survey_id'] = this.surveyId;
    data['question'] = this.question;
    if (this.options != null) {
      data['options'] = this.options.map((v) => v.toJson()).toList();
    }
    data['updatedAt'] = this.updatedAt;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Options {
  String isCorrect;
  String sId;
  String option;

  Options({this.isCorrect, this.sId, this.option});

  Options.fromJson(Map<String, dynamic> json) {
    isCorrect = json['isCorrect'];
    sId = json['_id'];
    option = json['option'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isCorrect'] = this.isCorrect;
    data['_id'] = this.sId;
    data['option'] = this.option;
    return data;
  }
}
