class UserDetailModel {
  String id;
  String username;
  String name;
  String surname;
  String gender;
  String birthDate;
  bool enabled;
  String note;
  String creationDt;
  String updatedDt;
  String loginDt;
  bool secured;
  ContactDTO contactDTO;
  AddressDTO addressDTO;
  List<String> roles;

  /* List<Null> permissions;*/

  UserDetailModel({
    this.id,
    this.username,
    this.name,
    this.surname,
    this.gender,
    this.birthDate,
    this.enabled,
    this.note,
    this.creationDt,
    this.updatedDt,
    this.loginDt,
    this.secured,
    this.contactDTO,
    this.addressDTO,
    this.roles,
    /*this.permissions*/
  });

  UserDetailModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] is String ? json['id'] : "";
    username = json['username'];
    name = json['name'];
    surname = json['surname'];
    gender = json['gender'];
    birthDate = json['birthDate'];
    enabled = json['enabled'];
    note = json['note'];
    creationDt = json['creationDt'];
    updatedDt = json['updatedDt'];
    loginDt = json['loginDt'];
    secured = json['secured'];
    contactDTO = json['contactDTO'] != null
        ? new ContactDTO.fromJson(json['contactDTO'])
        : null;
    addressDTO = json['addressDTO'] != null
        ? new AddressDTO.fromJson(json['addressDTO'])
        : null;
    roles = json['roles'] != null ? json['roles'].cast<String>() : [];
    /*   if (json['permissions'] != null) {
      permissions = <Null>[];
      json['permissions'].forEach((v) {
        permissions.add(new Null.fromJson(v));
      });
    }*/
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['name'] = this.name;
    data['surname'] = this.surname;
    data['gender'] = this.gender;
    data['birthDate'] = this.birthDate;
    data['enabled'] = this.enabled;
    data['note'] = this.note;
    data['creationDt'] = this.creationDt;
    data['updatedDt'] = this.updatedDt;
    data['loginDt'] = this.loginDt;
    data['secured'] = this.secured;

    if (this.contactDTO != null) {
      data['contactDTO'] = this.contactDTO.toJson();
    }
    if (this.addressDTO != null) {
      data['addressDTO'] = this.addressDTO.toJson();
    }
    data['roles'] = this.roles;
    /*if (this.permissions != null) {
      data['permissions'] = this.permissions!.map((v) => v.toJson()).toList();
    }*/
    return data;
  }
}

class AddressDTO {
  String address;
  String address2;
  String city;
  String country;
  String zipCode;

  AddressDTO(
      {this.address, this.address2, this.city, this.country, this.zipCode});

  AddressDTO.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    address2 = json['address2'];
    city = json['city'];
    country = json['country'];
    zipCode = json['zipCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['address2'] = this.address2;
    data['city'] = this.city;
    data['country'] = this.country;
    data['zipCode'] = this.zipCode;
    return data;
  }
}

class ContactDTO {
  String email;
  String phone;
  String skype;
  String facebook;
  String linkedin;
  String website;
  String contactNote;

  ContactDTO(
      {this.email,
      this.phone,
      this.skype,
      this.facebook,
      this.linkedin,
      this.website,
      this.contactNote});

  ContactDTO.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    phone = json['phone'];
    skype = json['skype'];
    facebook = json['facebook'];
    linkedin = json['linkedin'];
    website = json['website'];
    contactNote = json['contactNote'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['skype'] = this.skype;
    data['facebook'] = this.facebook;
    data['linkedin'] = this.linkedin;
    data['website'] = this.website;
    data['contactNote'] = this.contactNote;
    return data;
  }
}
