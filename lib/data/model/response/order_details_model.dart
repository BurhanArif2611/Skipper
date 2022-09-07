import 'package:sixam_mart/data/model/response/item_model.dart';

class OrderDetailsModel {
  int id;
  int itemId;
  int orderId;
  double price;
  Item itemDetails;
  List<Variation> variation;
  List<AddOn> addOns;
  double discountOnItem;
  String discountType;
  int quantity;
  double taxAmount;
  String variant;
  String createdAt;
  String updatedAt;
  int itemCampaignId;
  double totalAddOnPrice;
  List<Errand_bids> errand_bids;
  List<Errand_Task> errand_tasks;

  OrderDetailsModel({
    this.id,
    this.itemId,
    this.orderId,
    this.price,
    this.itemDetails,
    this.variation,
    this.addOns,
    this.discountOnItem,
    this.discountType,
    this.quantity,
    this.taxAmount,
    this.variant,
    this.createdAt,
    this.updatedAt,
    this.itemCampaignId,
    this.totalAddOnPrice,
    this.errand_bids,
    this.errand_tasks,
  });

  OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemId = json['item_id'] == null ? 0 : json['item_id'];
    orderId = json['order_id'] == null ? 0 : json['order_id'];
    price = json['price'] == null ? 0 : json['price'].toDouble();
    itemDetails = json['item_details'] != null
        ? new Item.fromJson(json['item_details'])
        : null;
    if (json['variation'] != null) {
      variation = [];
      json['variation'].forEach((v) {
        variation.add(new Variation.fromJson(v));
      });
    }
    if (json['add_ons'] != null) {
      addOns = [];
      json['add_ons'].forEach((v) {
        addOns.add(new AddOn.fromJson(v));
      });
    }
    discountOnItem = json['discount_on_item'] != null
        ? json['discount_on_item'].toDouble()
        : 0;
    discountType = json['discount_type'] != null ? json['discount_type'] : "";
    quantity = json['quantity'];
    taxAmount = json['tax_amount'] != null
        ? json['tax_amount'] == 0
            ? json['tax_amount'].toDouble()
            : json['tax_amount'].toDouble()
        : 0.0;
    variant = json['variant'] != null ? json['variant'] : "";
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    itemCampaignId =
        json['item_campaign_id'] != null ? json['item_campaign_id'] : 0;
    totalAddOnPrice = json['total_add_on_price'] != null
        ? json['total_add_on_price'].toDouble()
        : 0;
    if (json['errand_bids'] != null) {
      errand_bids = [];
      json['errand_bids'].forEach((v) {
        errand_bids.add(new Errand_bids.fromJson(v));
      });
    } if (json['errand_tasks'] != null) {
      errand_tasks = [];
      json['errand_tasks'].forEach((v) {
        errand_tasks.add(new Errand_Task.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['item_id'] = this.itemId;
    data['order_id'] = this.orderId;
    data['price'] = this.price;
    if (this.itemDetails != null) {
      data['item_details'] = this.itemDetails.toJson();
    }
    if (this.variation != null) {
      data['variation'] = this.variation.map((v) => v.toJson()).toList();
    }
    if (this.addOns != null) {
      data['add_ons'] = this.addOns.map((v) => v.toJson()).toList();
    }
    data['discount_on_item'] = this.discountOnItem;
    data['discount_type'] = this.discountType;
    data['quantity'] = this.quantity;
    data['tax_amount'] = this.taxAmount;
    data['variant'] = this.variant;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['item_campaign_id'] = this.itemCampaignId;
    data['total_add_on_price'] = this.totalAddOnPrice;
    if (this.errand_bids != null) {
      data['errand_bids'] = this.errand_bids.map((v) => v.toJson()).toList();
    } if (this.errand_tasks != null) {
      data['errand_tasks'] = this.errand_tasks.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AddOn {
  String name;
  double price;
  int quantity;

  AddOn({this.name, this.price, this.quantity});

  AddOn.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    price = json['price'].toDouble();
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    return data;
  }
}

class Errand_bids {
  int id;
  int order_id;
  int delivery_man_id;
  String amount;
  String counter_amount;
  String created_at;
  String updated_at;
  String status;
  int is_counter_offer;
  int is_counter_accepted;
  String validity;

  Errand_bids({
    this.id,
    this.order_id,
    this.delivery_man_id,
    this.amount,
    this.counter_amount,
    this.created_at,
    this.updated_at,
    this.status,
    this.is_counter_offer,
    this.is_counter_accepted,
    this.validity,
  });

  Errand_bids.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    order_id = json['order_id'];
    delivery_man_id = json['delivery_man_id'];
    amount = json['amount'];
    counter_amount = json['counter_amount'];
    created_at = json['created_at'];
    updated_at = json['updated_at'];
    status = json['status'];
    is_counter_offer = json['is_counter_offer'];
    is_counter_accepted = json['is_counter_accepted'];
    validity = json['validity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.order_id;
    data['delivery_man_id'] = this.delivery_man_id;
    data['amount'] = this.amount;
    data['counter_amount'] = this.counter_amount;
    data['created_at'] = this.created_at;
    data['updated_at'] = this.updated_at;
    data['status'] = this.status;
    data['is_counter_offer'] = this.is_counter_offer;
    data['is_counter_accepted'] = this.is_counter_accepted;
    data['validity'] = this.validity;

    return data;
  }
}

class Errand_Task {
  int id;
  int order_id;
  String title;
  String description;
  String status;
  String created_at;
  String updated_at;
  List<Errand_Task_Media> errand_task_media;

  Errand_Task({
    this.id,
    this.order_id,
    this.title,
    this.description,
    this.status,
    this.created_at,
    this.updated_at,
    this.errand_task_media,
  });

  Errand_Task.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    order_id = json['order_id'];
    title = json['title'];
    description = json['description'];
    created_at = json['created_at'];
    updated_at = json['updated_at'];
    status = json['status'];
    errand_task_media = json['errand_task_media'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.order_id;
    data['description'] = this.description;
    data['title'] = this.title;
    data['created_at'] = this.created_at;
    data['updated_at'] = this.updated_at;
    data['status'] = this.status;
    data['errand_task_media'] = this.errand_task_media;

    return data;
  }
}

class Errand_Task_Media {
  int id;
  int task_id;
  String image;

  Errand_Task_Media({
    this.id,
    this.task_id,
    this.image,
  });

  Errand_Task_Media.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    task_id = json['task_id'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['task_id'] = this.task_id;
    return data;
  }
}
