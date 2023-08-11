class UserDetailModel {
  Name name;
  int role;
  String anonymous;
  String email;
  String passwordToken;
  String mobileNumber;
  String expireTime;
  List<int> scope;
  String sId;

  UserDetailModel(
      {this.name,
        this.role,
        this.anonymous,
        this.email,
        this.passwordToken,
        this.mobileNumber,
        this.expireTime,
        this.scope,
        this.sId});

  UserDetailModel.fromJson(Map<String, dynamic> json) {
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