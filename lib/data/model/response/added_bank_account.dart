class AddedBankAccount {
  int id;
  String beneficiary_id;
  String bank_code;
  String account_no_mask;
  String full_name;
  String bank_name;
  int customer_id;
  String created_at;
  String updated_at;

  AddedBankAccount(
      {
        this.id,
        this.beneficiary_id,
        this.bank_code,
        this.account_no_mask,
        this.full_name,
        this.bank_name,
        this.customer_id,
        this.created_at,
        this.updated_at,
      });

  AddedBankAccount.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    beneficiary_id = json['beneficiary_id'];
    bank_code = json['bank_code'];
    account_no_mask = json['account_no_mask'];
    full_name = json['full_name'];
    bank_name = json['bank_name'];
    customer_id = json['customer_id'];
    created_at = json['created_at'];
    updated_at = json['updated_at'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['beneficiary_id'] = this.beneficiary_id;
    data['bank_code'] = this.bank_code;
    data['account_no_mask'] = this.account_no_mask;
    data['full_name'] = this.full_name;
    data['bank_name'] = this.bank_name;
    data['customer_id'] = this.customer_id;
    data['created_at'] = this.created_at;
    data['updated_at'] = this.updated_at;
    return data;
  }
}