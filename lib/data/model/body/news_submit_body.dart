class NewsSubmitBody {
  String surveyId;
  List<Answers> answers;

  NewsSubmitBody({this.surveyId, this.answers});

  NewsSubmitBody.fromJson(Map<String, dynamic> json) {
    surveyId = json['survey_id'];
    if (json['answers'] != null) {
      answers = <Answers>[];
      json['answers'].forEach((v) {
        answers.add(new Answers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['survey_id'] = this.surveyId;
    if (this.answers != null) {
      data['answers'] = this.answers.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Answers {
  String question;
  String options;

  Answers({this.question, this.options});

  Answers.fromJson(Map<String, dynamic> json) {
    question = json['question'];
    options = json['options'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['question'] = this.question;
    data['options'] = this.options;
    return data;
  }
}
