
  class SignUpBody {
  String username;
  String name;
  String gender;
  String surname;
  String email;
  String password;
  String birthDate;
  bool enabled;
  String note;
  String roles;
  String creationDt;
  String updatedDt;
  String loginDt;
  String secured;
  String phone;
  String skype;
  String facebook;
  String linkedin;
  String website;
  String contactNote;
  String address;
  String address2;
  String city;
  String country;
  String zipCode;

  SignUpBody(
  {this.username,
  this.name,
  this.gender,
  this.surname,
  this.email,
  this.password,
  this.birthDate,
  this.enabled,
  this.note,
  this.roles,
  this.creationDt,
  this.updatedDt,
  this.loginDt,
  this.secured,
  this.phone,
  this.skype,
  this.facebook,
  this.linkedin,
  this.website,
  this.contactNote,
  this.address,
  this.address2,
  this.city,
  this.country,
  this.zipCode});

  SignUpBody.fromJson(Map<String, dynamic> json) {
  username = json['username'];
  name = json['name'];
  gender = json['gender'];
  surname = json['surname'];
  email = json['email'];
  password = json['password'];
  birthDate = json['birthDate'];
  enabled = json['enabled'];
  note = json['note'];
  roles = json['roles'];
  creationDt = json['creationDt'];
  updatedDt = json['updatedDt'];
  loginDt = json['loginDt'];
  secured = json['secured'];
  phone = json['phone'];
  skype = json['skype'];
  facebook = json['facebook'];
  linkedin = json['linkedin'];
  website = json['website'];
  contactNote = json['contactNote'];
  address = json['address'];
  address2 = json['address2'];
  city = json['city'];
  country = json['country'];
  zipCode = json['zipCode'];
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['username'] = this.username;
  data['name'] = this.name;
  data['gender'] = this.gender;
  data['surname'] = this.surname;
  data['email'] = this.email;
  data['password'] = this.password;
  data['birthDate'] = this.birthDate;
  data['enabled'] = this.enabled;
  data['note'] = this.note;
  data['roles'] = this.roles;
  data['creationDt'] = this.creationDt;
  data['updatedDt'] = this.updatedDt;
  data['loginDt'] = this.loginDt;
  data['secured'] = this.secured;
  data['phone'] = this.phone;
  data['skype'] = this.skype;
  data['facebook'] = this.facebook;
  data['linkedin'] = this.linkedin;
  data['website'] = this.website;
  data['contactNote'] = this.contactNote;
  data['address'] = this.address;
  data['address2'] = this.address2;
  data['city'] = this.city;
  data['country'] = this.country;
  data['zipCode'] = this.zipCode;
  return data;
  }
  }
