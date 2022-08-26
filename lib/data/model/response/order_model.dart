import 'package:sixam_mart/data/model/response/address_model.dart';
import 'package:sixam_mart/data/model/response/parcel_category_model.dart';
import 'package:sixam_mart/data/model/response/store_model.dart';

class PaginatedOrderModel {
  int totalSize;
  String limit;
  int offset;
  List<OrderModel> orders;

  PaginatedOrderModel({this.totalSize, this.limit, this.offset, this.orders});

  PaginatedOrderModel.fromJson(Map<String, dynamic> json) {
    totalSize = json['total_size'];
    limit = json['limit'].toString();
    offset = (json['offset'] != null && json['offset'].toString().trim().isNotEmpty) ? int.parse(json['offset'].toString()) : null;
    if (json['orders'] != null) {
      orders = [];
      json['orders'].forEach((v) {
        orders.add(new OrderModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_size'] = this.totalSize;
    data['limit'] = this.limit;
    data['offset'] = this.offset;
    if (this.orders != null) {
      data['orders'] = this.orders.map((v) => v.toJson()).toList();
    }
    return data;
  }

}
class Receiver_details {
  int id;
  int order_id;
  String status;
  String otp;
  AddressModel receiver_details;

  Receiver_details(
      {this.id,
        this.order_id,
        this.status,
        this.otp,
        this.receiver_details,
      });

  Receiver_details.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    order_id = json['order_id'];
    status = json['status'];
    otp = json['otp'];
    receiver_details = json['receiver_details'] != null ? new AddressModel.fromJson(json['receiver_details']) : null;


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.order_id;
    data['status'] = this.status;
    data['otp'] = this.otp;

    if (this.receiver_details != null) {
      data['receiver_details'] = this.receiver_details.toJson();
    }

    return data;
  }
}
class OrderModel {
  int id;
  int userId;
  double orderAmount;
  double couponDiscountAmount;
  String couponDiscountTitle;
  String paymentStatus;
  String orderStatus;
  double totalTaxAmount;
  String paymentMethod;
  String couponCode;
  String orderNote;
  String orderType;
  String createdAt;
  String updatedAt;
  double deliveryCharge;
  String scheduleAt;
  String otp;
  String pending;
  String accepted;
  String confirmed;
  String processing;
  String handover;
  String pickedUp;
  String delivered;
  String canceled;
  String refundRequested;
  String refunded;
  int scheduled;
  double storeDiscountAmount;
  String failed;
  int detailsCount;
  String orderAttachment;
  String chargePayer;
  String moduleType;
  DeliveryMan deliveryMan;
  Store store;
  AddressModel deliveryAddress;
  AddressModel receiverDetails;
  ParcelCategoryModel parcelCategory;
  List<Receiver_details> dropoff_locations;
  List<Errand_bids> errand_bids;
  List<Errand_Task> errand_tasks;
  double dmTips;
  OrderModel(
      {this.id,
        this.userId,
        this.orderAmount,
        this.couponDiscountAmount,
        this.couponDiscountTitle,
        this.paymentStatus,
        this.orderStatus,
        this.totalTaxAmount,
        this.paymentMethod,
        this.couponCode,
        this.orderNote,
        this.orderType,
        this.createdAt,
        this.updatedAt,
        this.deliveryCharge,
        this.scheduleAt,
        this.otp,
        this.pending,
        this.accepted,
        this.confirmed,
        this.processing,
        this.handover,
        this.pickedUp,
        this.delivered,
        this.canceled,
        this.refundRequested,
        this.refunded,
        this.scheduled,
        this.storeDiscountAmount,
        this.failed,
        this.detailsCount,
        this.chargePayer,
        this.moduleType,
        this.deliveryMan,
        this.deliveryAddress,
        this.receiverDetails,
        this.parcelCategory,
        this.store,
        this.orderAttachment,
        this.dropoff_locations,
        this.errand_bids,
        this.errand_tasks,
        this.dmTips,
      });

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    orderAmount = json['order_amount'] !=null? json['order_amount'].toDouble():0;
    couponDiscountAmount = json['coupon_discount_amount'] !=null ? json['coupon_discount_amount'].toDouble():0;
    couponDiscountTitle = json['coupon_discount_title'];
    paymentStatus = json['payment_status'];
    orderStatus = json['order_status'];
    totalTaxAmount = json['total_tax_amount'] !=null?json['total_tax_amount'].toDouble():0;
    paymentMethod = json['payment_method'];
    couponCode = json['coupon_code'];
    orderNote = json['order_note'];
    orderType = json['order_type'] !=null ? json['order_type']:"";
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deliveryCharge = json['delivery_charge']!=null?json['delivery_charge'].toDouble():0;
    scheduleAt = json['schedule_at'];
    otp = json['otp'];
    pending = json['pending'];
    accepted = json['accepted'];
    confirmed = json['confirmed'];
    processing = json['processing'];
    handover = json['handover'];
    pickedUp = json['picked_up'];
    delivered = json['delivered'];
    canceled = json['canceled'];
    refundRequested = json['refund_requested'];
    refunded = json['refunded'];
    scheduled = json['scheduled'];
    storeDiscountAmount = json['store_discount_amount'] !=null?json['store_discount_amount'].toDouble():0;
    failed = json['failed'];
    detailsCount = json['details_count'];
    orderAttachment = json['order_attachment'];
    chargePayer = json['charge_payer'];
    moduleType = json['module_type'];
    deliveryMan = json['delivery_man'] != null ? new DeliveryMan.fromJson(json['delivery_man']) : null;
    store = json['store'] != null ? new Store.fromJson(json['store']) : null;
    deliveryAddress = json['delivery_address'] != null ? new AddressModel.fromJson(json['delivery_address']) : null;
    receiverDetails = json['receiver_details'] != null ? new AddressModel.fromJson(json['receiver_details']) : null;
    parcelCategory = json['parcel_category'] != null ? new ParcelCategoryModel.fromJson(json['parcel_category']) : null;
    dmTips = json['dm_tips']!=null?json['dm_tips'].toDouble():0.0;
    if (json['dropoff_locations'] != null) {
      dropoff_locations = [];
      json['dropoff_locations'].forEach((v) {
        dropoff_locations.add(new Receiver_details.fromJson(v));
      });
    }
    if (json['errand_bids'] != null) {
      errand_bids = [];
      json['errand_bids'].forEach((v) {
        errand_bids.add(new Errand_bids.fromJson(v));
      });
    }if (json['errand_tasks'] != null) {
      errand_tasks = [];
      json['errand_tasks'].forEach((v) {
        errand_tasks.add(new Errand_Task.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['order_amount'] = this.orderAmount;
    data['coupon_discount_amount'] = this.couponDiscountAmount;
    data['coupon_discount_title'] = this.couponDiscountTitle;
    data['payment_status'] = this.paymentStatus;
    data['order_status'] = this.orderStatus;
    data['total_tax_amount'] = this.totalTaxAmount;
    data['payment_method'] = this.paymentMethod;
    data['coupon_code'] = this.couponCode;
    data['order_note'] = this.orderNote;
    data['order_type'] = this.orderType;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['delivery_charge'] = this.deliveryCharge;
    data['schedule_at'] = this.scheduleAt;
    data['otp'] = this.otp;
    data['pending'] = this.pending;
    data['accepted'] = this.accepted;
    data['confirmed'] = this.confirmed;
    data['processing'] = this.processing;
    data['handover'] = this.handover;
    data['picked_up'] = this.pickedUp;
    data['delivered'] = this.delivered;
    data['canceled'] = this.canceled;
    data['refund_requested'] = this.refundRequested;
    data['refunded'] = this.refunded;
    data['scheduled'] = this.scheduled;
    data['store_discount_amount'] = this.storeDiscountAmount;
    data['failed'] = this.failed;
    data['order_attachment'] = this.orderAttachment;
    data['charge_payer'] = this.chargePayer;
    data['module_type'] = this.moduleType;
    data['details_count'] = this.detailsCount;
    if (this.deliveryMan != null) {
      data['delivery_man'] = this.deliveryMan.toJson();
    }
    if (this.store != null) {
      data['store'] = this.store.toJson();
    }
    if (this.deliveryAddress != null) {
      data['delivery_address'] = this.deliveryAddress.toJson();
    }

    if (this.receiverDetails != null) {
      data['receiver_details'] = this.receiverDetails.toJson();
    }
    if (this.parcelCategory != null) {
      data['parcel_category'] = this.parcelCategory.toJson();
    }


    if (this.dropoff_locations != null) {
      data['dropoff_locations'] = this.dropoff_locations.map((v) => v.toJson()).toList();
    }
    if (this.errand_bids != null) {
      data['errand_bids'] = this.errand_bids.map((v) => v.toJson()).toList();
    }
    if (this.errand_tasks != null) {
      data['errand_tasks'] = this.errand_tasks.map((v) => v.toJson()).toList();
    }
    data['dm_tips'] = this.dmTips;
    return data;
  }
}

class DeliveryMan {
  int id;
  String fName;
  String lName;
  String phone;
  String email;
  String image;
  int zoneId;
  int active;
  int available;
  double avgRating;
  int ratingCount;
  String lat;
  String lng;
  String location;

  DeliveryMan(
      {this.id,
        this.fName,
        this.lName,
        this.phone,
        this.email,
        this.image,
        this.zoneId,
        this.active,
        this.available,
        this.avgRating,
        this.ratingCount,
        this.lat,
        this.lng,
        this.location
      });

  DeliveryMan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fName = json['f_name'];
    lName = json['l_name'];
    phone = json['phone'];
    email = json['email'];
    image = json['image'];
    zoneId = json['zone_id'];
    active = json['active'];
    available = json['available'];
    avgRating = json['avg_rating'].toDouble();
    ratingCount = json['rating_count'];
    lat = json['lat'];
    lng = json['lng'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['f_name'] = this.fName;
    data['l_name'] = this.lName;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['image'] = this.image;
    data['zone_id'] = this.zoneId;
    data['active'] = this.active;
    data['available'] = this.available;
    data['avg_rating'] = this.avgRating;
    data['rating_count'] = this.ratingCount;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['location'] = this.location;
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
  Delivery_man delivery_man;



  Errand_bids(
      {this.id,
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
        this.delivery_man,

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
    delivery_man = json['delivery_man'] != null ? new Delivery_man.fromJson(json['delivery_man']) : null;



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

    if (this.delivery_man != null) {
      data['delivery_man'] = this.delivery_man.toJson();
    }

    return data;
  }


}
class Delivery_man {
  int id;
  String f_name;
  String l_name;
  String phone;
  String email;
  String identity_image;
  String updated_at;

  Delivery_man(
      {this.id,
        this.f_name,
        this.l_name,
        this.phone,
        this.email,
        this.updated_at,
        this.identity_image,
      });

  Delivery_man.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    f_name = json['f_name'];
    l_name = json['l_name'];
    phone = json['phone'];
    email = json['email'];
    updated_at = json['updated_at'];
    identity_image = json['identity_image'];



  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['f_name'] = this.f_name;
    data['l_name'] = this.l_name;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['updated_at'] = this.updated_at;
    data['identity_image'] = this.identity_image;
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
    if (json['errand_task_media'] != null) {
      errand_task_media = [];
      json['errand_task_media'].forEach((v) {
        errand_task_media.add(new Errand_Task_Media.fromJson(v));
      });
    }
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
    if (this.errand_task_media != null) {
      data['errand_task_media'] = this.errand_task_media.map((v) => v.toJson()).toList();
    }
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