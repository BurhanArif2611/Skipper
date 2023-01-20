class BranchModel {
  int id;
  String name;
  String phone;
  String email;
  String logo;

  BranchModel(this.id, this.name, this.phone, this.email, this.logo);

  BranchModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        phone = json['phone'],
        email = json['email'],
        logo = json['logo'];

  Map<String, dynamic> toJson() =>
      {
        'id' : id,
        'name': name,
        'phone': phone,
        'email': email,
        'logo': logo,
      };
}