class SetErrandOrderBody {

  int orderId;
  int bid_id;
  String payment_method;



  SetErrandOrderBody({ this.orderId, this.bid_id, this.payment_method});

  SetErrandOrderBody.fromJson(Map<String, dynamic> json) {

    orderId = json['order_id'];
    bid_id = json['bid_id'];
    payment_method = json['payment_method'];


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['order_id'] = this.orderId;
    data['bid_id'] = this.bid_id;
    data['payment_method'] = this.payment_method;
    return data;
  }
}
