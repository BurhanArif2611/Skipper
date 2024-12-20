class NotificationModel {
  int id;
  List<Data> data;
  String createdAt;
  String updatedAt;

  NotificationModel({this.id, this.data, this.createdAt, this.updatedAt});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
   /* data = json['data'] != null ? new Data.fromJson(json['data']) : null;
   */
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Data {
  String title;
  String notification_text;
  String image;
  String type;
  String userName;
  String createdAt;

  Data({this.title, this.notification_text, this.image, this.type, this.userName, this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    notification_text = json['notification_text'];
    image = json['image'];
    type = json['type'];
    userName = json['userName'];
    createdAt = json['createdAt']!=null?json['createdAt']:"2024-11-23 01:20:20";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['notification_text'] = this.notification_text;
    data['image'] = this.image;
    data['type'] = this.type;
    data['userName'] = this.userName;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
