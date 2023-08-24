class SignUpBody {
  String fName;
  String lName;
  String phone;
  String email;
  String password;
  String refCode;
  String scope;
  String role;

  SignUpBody({this.fName, this.lName, this.phone, this.email='', this.password, this.refCode = '', this.scope, this.role });

  SignUpBody.fromJson(Map<String, dynamic> json) {
    fName = json['first_name'];
    lName = json['last_name'];
    phone = json['mobile_number'];
    email = json['email'];
    password = json['password'];
    refCode = json['anonymous'];
    scope = json['scope'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.fName;
    data['last_name'] = this.lName;
    data['mobile_number'] = this.phone;
    data['email'] = this.email;
    data['password'] = this.password;
    data['anonymous'] = this.refCode;
    data['scope'] = this.scope;
    data['role'] = this.role;
    return data;
  }
}
