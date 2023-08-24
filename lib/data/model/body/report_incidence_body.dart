class ReportIncidenceBody {
  String incidentType;
  String subCategoryId;
  String state;
  String lga;
  String ward;
  List<String> image;
  List<String> video;
  List<String> audio;
  String description;
  String shortDescription;
  bool isAnonymous;

  ReportIncidenceBody(
      {this.incidentType,
        this.subCategoryId,
        this.state,
        this.lga,
        this.ward,
        this.image,
        this.video,
        this.audio,
        this.description,
        this.shortDescription,
        this.isAnonymous});

  ReportIncidenceBody.fromJson(Map<String, dynamic> json) {
    incidentType = json['incident_type'];
    subCategoryId = json['sub_category_id'];
    state = json['state'];
    lga = json['lga'];
    ward = json['ward'];
    image = json['image'];
    video = json['video'];
    audio = json['audio'];
    description = json['description'];
    shortDescription = json['short_description'];
    isAnonymous = json['isAnonymous'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['incident_type'] = this.incidentType;
    data['sub_category_id'] = this.subCategoryId;
    data['state'] = this.state;
    data['lga'] = this.lga;
    data['ward'] = this.ward;
    data['image'] = this.image;
    data['video'] = this.video;
    data['audio'] = this.audio;
    data['description'] = this.description;
    data['short_description'] = this.shortDescription;
    data['isAnonymous'] = this.isAnonymous;
    return data;
  }
}
