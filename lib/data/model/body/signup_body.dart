class SignUpBody {
  String fName;
  String lName;
  String phone;
  String email;
  String password;
  String refCode;

  SignUpBody({this.fName, this.lName, this.phone, this.email='', this.password, this.refCode = ''});

  SignUpBody.fromJson(Map<String, dynamic> json) {
    fName = json['first_name'];
    lName = json['last_name'];
    phone = json['mobile_number'];
    email = json['email'];
    password = json['password'];
    refCode = json['anonymous'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.fName;
    data['last_name'] = this.lName;
    data['mobile_number'] = this.phone;
    data['email'] = this.email;
    data['password'] = this.password;
    data['anonymous'] = this.refCode;
    return data;
  }
}
