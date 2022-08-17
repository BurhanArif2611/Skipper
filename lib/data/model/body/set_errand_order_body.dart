class SetErrandOrderBody {

  int orderId;
  int bid_id;



  SetErrandOrderBody({ this.orderId, this.bid_id});

  SetErrandOrderBody.fromJson(Map<String, dynamic> json) {

    orderId = json['order_id'];
    bid_id = json['bid_id'];


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['order_id'] = this.orderId;
    data['bid_id'] = this.bid_id;
    return data;
  }
}
