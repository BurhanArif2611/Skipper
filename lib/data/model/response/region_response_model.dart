class RegionResponseModel {
  int id;
  String chief_place;
  String chief_place_ar;
  String provinces;
  String provinces_ar;


  RegionResponseModel(
      {this.id,
        this.chief_place,
        this.chief_place_ar,
        this.provinces,
        this.provinces_ar,

      });

  RegionResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    chief_place = json['chief_place'];
    chief_place_ar = json['chief_place_ar'];
    provinces = json['provinces'];
    provinces_ar = json['provinces_ar'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['chief_place'] = this.chief_place;
    data['chief_place_ar'] = this.chief_place_ar;
    data['provinces'] = this.provinces;
    data['provinces_ar'] = this.provinces_ar;

    return data;
  }
}