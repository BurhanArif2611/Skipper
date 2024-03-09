class SurveyListModel {
  String message;
  List<Data> data;
  String Language_code;

  SurveyListModel({this.message, this.data});

  SurveyListModel.fromJson(Map<String, dynamic> json, String language_code) {
    Language_code=language_code;
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v,Language_code));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int id;
  String question;
  String question_arbic;
  List<String> options;
  List<String> options_arbic;
  int status;
  String createdAt;
  String updatedAt;
  bool attempt;

  Data(
      {this.id,
        this.question,
        this.question_arbic,
        this.options,
        this.options_arbic,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.attempt
      });

  Data.fromJson(Map<String, dynamic> json, String Language_code) {
    id = json['id'];
    question =Language_code =='ar'?json['question_arbic']!=null?json['question_arbic']:"": json['question'];
   // question_arbic = json['question_arbic']!=null?json['question_arbic']:"";
    options =Language_code =='ar'?json['options_arbic']!=null? json['options_arbic'].cast<String>():[]: json['options'].cast<String>();
  //  options_arbic =json['options_arbic']!=null? json['options_arbic'].cast<String>():[];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    attempt = json['attempt']!=null ?json['attempt']:false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['question'] = this.question;
    data['question_arbic'] = this.question_arbic;
    data['options'] = this.options;
    data['options_arbic'] = this.options_arbic;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['attempt'] = this.attempt;
    return data;
  }
}
