class WalletModel {
  int totalSize;
  String limit;
  String offset;
  List<Transaction> data;

  WalletModel({this.totalSize, this.limit, this.offset, this.data});

  WalletModel.fromJson(Map<String, dynamic> json) {
    totalSize = json["total_size"];
    limit = json["limit"].toString();
    offset = json["offset"].toString();
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data.add(new Transaction.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_size'] = this.totalSize;
    data['limit'] = this.limit;
    data['offset'] = this.offset;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Transaction {
  int userId;
  int id;
  String transactionId;
  double credit;
  double debit;
  double adminBonus;
  double balance;
  double amount;
  String transactionType;
  String status;
  DateTime createdAt;
  DateTime updatedAt;

  Transaction({
    this.userId,
    this.id,
    this.transactionId,
    this.credit,
    this.debit,
    this.adminBonus,
    this.balance,
    this.transactionType,
    this.createdAt,
    this.updatedAt,
    this.status,
    this.amount,
  });

  Transaction.fromJson(Map<String, dynamic> json) {
    userId = json["user_id"];
    id = json["id"]!=null?json["id"]:0;
    transactionId = json["transaction_id"];
    credit = json["credit"] != null && json["credit"] != ""? json["credit"].toDouble() : 0.0;
    debit = json["debit"] != null ? json["debit"].toDouble() : 0.0;

      adminBonus =
          json["admin_bonus"] != null ? json["admin_bonus"].toDouble() : 0.0;

    balance = json["balance"]!=null?json["balance"].toDouble():0.0;
    amount = json["amount"]!=null?json["amount"].toDouble():0.0;
    status = json["status"];
    transactionType = json["transaction_type"];
    createdAt =
        json["created_at"] != null ? DateTime.parse(json["created_at"]) : null;
    updatedAt =
        json["updated_at"] != null ? DateTime.parse(json["updated_at"]) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["user_id"] = this.userId;
    data["id"] = this.id;
    data["transaction_id"] = this.transactionId;
    data["credit"] = this.credit;
    data["debit"] = this.debit;
    data["admin_bonus"] = this.adminBonus;
    data["balance"] = this.balance;
    data["amount"] = this.amount;
    data["status"] = this.status;
    data["transaction_type"] = this.transactionType;
    data["created_at"] = this.createdAt.toIso8601String();
    data["updated_at"] = this.updatedAt.toIso8601String();
    return data;
  }
}
