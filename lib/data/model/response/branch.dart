import 'dart:convert';
import 'package:sixam_mart/data/model/response/basic_campaign_model.dart';
import 'package:sixam_mart/data/model/response/item_model.dart';
import 'package:sixam_mart/data/model/response/store_model.dart';
/// id : 8
/// name : "Veg Restaurant"
/// phone : "7770999156"
/// email : "lokendra.verma@yopmail.com"
/// logo : "2022-07-11-62cbf54db4f03.png"
/// latitude : "22.697253856631338"
/// longitude : "75.86350713881338"
/// address : "Indore"
/// footer_text : null
/// minimum_order : 0
/// comission : null
/// schedule_order : false
/// status : 1
/// vendor_id : 9
/// created_at : "2022-07-11T10:02:53.000000Z"
/// updated_at : "2022-07-11T10:02:53.000000Z"
/// free_delivery : false
/// rating : [0,0,0,0,0]
/// cover_photo : "2022-07-11-62cbf54db9dc1.png"
/// delivery : true
/// take_away : true
/// item_section : true
/// tax : 10
/// zone_id : 1
/// reviews_section : true
/// active : true
/// off_day : " "
/// self_delivery_system : 0
/// pos_system : false
/// delivery_charge : 0
/// delivery_time : "10-30 min"
/// veg : 1
/// non_veg : 1
/// order_count : 0
/// total_order : 0
/// module_id : 1
/// order_place_to_schedule_interval : 0
/// featured : 0
/// parent_id : 7
/// gst_status : false
/// gst_code : ""

Branch branchFromJson(String str) => Branch.fromJson(json.decode(str));
String branchToJson(Branch data) => json.encode(data.toJson());
class Branch {
  Branch({
      int id, 
      String name, 
      String phone, 
      String email, 
      String logo, 
      String latitude, 
      String longitude, 
      String address, 
      dynamic footerText, 
      int minimumOrder, 
      dynamic comission, 
      bool scheduleOrder, 
      int status, 
      int vendorId, 
      String createdAt, 
      String updatedAt, 
      bool freeDelivery, 
      List<int> rating, 
      String coverPhoto, 
      bool delivery, 
      bool takeAway, 
      bool itemSection, 
      int tax, 
      int zoneId, 
      bool reviewsSection, 
      bool active, 
      String offDay, 
      int selfDeliverySystem, 
      bool posSystem, 
      int deliveryCharge, 
      String deliveryTime, 
      int veg, 
      int nonVeg, 
      int orderCount, 
      int totalOrder, 
      int moduleId, 
      int orderPlaceToScheduleInterval, 
      int featured, 
      int parentId, 
      bool gstStatus, 
      String gstCode,}){
    _id = id;
    _name = name;
    _phone = phone;
    _email = email;
    _logo = logo;
    _latitude = latitude;
    _longitude = longitude;
    _address = address;
    _footerText = footerText;
    _minimumOrder = minimumOrder;
    _comission = comission;
    _scheduleOrder = scheduleOrder;
    _status = status;
    _vendorId = vendorId;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _freeDelivery = freeDelivery;
   // _rating = rating;
    _coverPhoto = coverPhoto;
    _delivery = delivery;
    _takeAway = takeAway;
    _itemSection = itemSection;
    _tax = tax;
    _zoneId = zoneId;
    _reviewsSection = reviewsSection;
    _active = active;
    _offDay = offDay;
    _selfDeliverySystem = selfDeliverySystem;
    _posSystem = posSystem;
    _deliveryCharge = deliveryCharge;
    _deliveryTime = deliveryTime;
    _veg = veg;
    _nonVeg = nonVeg;
    _orderCount = orderCount;
    _totalOrder = totalOrder;
    _moduleId = moduleId;
    _orderPlaceToScheduleInterval = orderPlaceToScheduleInterval;
    _featured = featured;
    _parentId = parentId;
    _gstStatus = gstStatus;
    _gstCode = gstCode;
}

  Branch.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _phone = json['phone'];
    _email = json['email'];
    _logo = json['logo'];
    _latitude = json['latitude'];
    _longitude = json['longitude'];
    _address = json['address'];
    _footerText = json['footer_text'];
    _minimumOrder = json['minimum_order'];
    _comission = json['comission'];
    _scheduleOrder = json['schedule_order'];
    _status = json['status'];
    _vendorId = json['vendor_id'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _freeDelivery = json['free_delivery'];
  //  _rating = json['rating'] != null  json['rating'].cast<int>() : [];
    _coverPhoto = json['cover_photo'];
    _delivery = json['delivery'];
    _takeAway = json['take_away'];
    _itemSection = json['item_section'];
    _tax = json['tax'];
    _zoneId = json['zone_id'];
    _reviewsSection = json['reviews_section'];
    _active = json['active'];
    _offDay = json['off_day'];
    _selfDeliverySystem = json['self_delivery_system'];
    _posSystem = json['pos_system'];
    _deliveryCharge = json['delivery_charge'];
    _deliveryTime = json['delivery_time'];
    _veg = json['veg'];
    _nonVeg = json['non_veg'];
    _orderCount = json['order_count'];
    _totalOrder = json['total_order'];
    _moduleId = json['module_id'];
    _orderPlaceToScheduleInterval = json['order_place_to_schedule_interval'];
    _featured = json['featured'];
    _parentId = json['parent_id'];
    _gstStatus = json['gst_status'];
    _gstCode = json['gst_code'];
  }
  int _id;
  String _name;
  String _phone;
  String _email;
  String _logo;
  String _latitude;
  String _longitude;
  String _address;
  dynamic _footerText;
  int _minimumOrder;
  dynamic _comission;
  bool _scheduleOrder;
  int _status;
  int _vendorId;
  String _createdAt;
  String _updatedAt;
  bool _freeDelivery;
  //List<int> _rating;
  String _coverPhoto;
  bool _delivery;
  bool _takeAway;
  bool _itemSection;
  int _tax;
  int _zoneId;
  bool _reviewsSection;
  bool _active;
  String _offDay;
  int _selfDeliverySystem;
  bool _posSystem;
  int _deliveryCharge;
  String _deliveryTime;
  int _veg;
  int _nonVeg;
  int _orderCount;
  int _totalOrder;
  int _moduleId;
  int _orderPlaceToScheduleInterval;
  int _featured;
  int _parentId;
  bool _gstStatus;
  String _gstCode;
Branch copyWith({  int id,
  String name,
  String phone,
  String email,
  String logo,
  String latitude,
  String longitude,
  String address,
  dynamic footerText,
  int minimumOrder,
  dynamic comission,
  bool scheduleOrder,
  int status,
  int vendorId,
  String createdAt,
  String updatedAt,
  bool freeDelivery,
  List<int> rating,
  String coverPhoto,
  bool delivery,
  bool takeAway,
  bool itemSection,
  int tax,
  int zoneId,
  bool reviewsSection,
  bool active,
  String offDay,
  int selfDeliverySystem,
  bool posSystem,
  int deliveryCharge,
  String deliveryTime,
  int veg,
  int nonVeg,
  int orderCount,
  int totalOrder,
  int moduleId,
  int orderPlaceToScheduleInterval,
  int featured,
  int parentId,
  bool gstStatus,
  String gstCode,
}) => Branch(  id: id ?? _id,
  name: name ?? _name,
  phone: phone ?? _phone,
  email: email ?? _email,
  logo: logo ?? _logo,
  latitude: latitude ?? _latitude,
  longitude: longitude ?? _longitude,
  address: address ?? _address,
  footerText: footerText ?? _footerText,
  minimumOrder: minimumOrder ?? _minimumOrder,
  comission: comission ?? _comission,
  scheduleOrder: scheduleOrder ?? _scheduleOrder,
  status: status ?? _status,
  vendorId: vendorId ?? _vendorId,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  freeDelivery: freeDelivery ?? _freeDelivery,
  //rating: rating ?? _rating,
  coverPhoto: coverPhoto ?? _coverPhoto,
  delivery: delivery ?? _delivery,
  takeAway: takeAway ?? _takeAway,
  itemSection: itemSection ?? _itemSection,
  tax: tax ?? _tax,
  zoneId: zoneId ?? _zoneId,
  reviewsSection: reviewsSection ?? _reviewsSection,
  active: active ?? _active,
  offDay: offDay ?? _offDay,
  selfDeliverySystem: selfDeliverySystem ?? _selfDeliverySystem,
  posSystem: posSystem ?? _posSystem,
  deliveryCharge: deliveryCharge ?? _deliveryCharge,
  deliveryTime: deliveryTime ?? _deliveryTime,
  veg: veg ?? _veg,
  nonVeg: nonVeg ?? _nonVeg,
  orderCount: orderCount ?? _orderCount,
  totalOrder: totalOrder ?? _totalOrder,
  moduleId: moduleId ?? _moduleId,
  orderPlaceToScheduleInterval: orderPlaceToScheduleInterval ?? _orderPlaceToScheduleInterval,
  featured: featured ?? _featured,
  parentId: parentId ?? _parentId,
  gstStatus: gstStatus ?? _gstStatus,
  gstCode: gstCode ?? _gstCode,
);
  int get id => _id;
  String get name => _name;
  String get phone => _phone;
  String get email => _email;
  String get logo => _logo;
  String get latitude => _latitude;
  String get longitude => _longitude;
  String get address => _address;
  dynamic get footerText => _footerText;
  int get minimumOrder => _minimumOrder;
  dynamic get comission => _comission;
  bool get scheduleOrder => _scheduleOrder;
  int get status => _status;
  int get vendorId => _vendorId;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;
  bool get freeDelivery => _freeDelivery;
 // List<int> get rating => _rating;
  String get coverPhoto => _coverPhoto;
  bool get delivery => _delivery;
  bool get takeAway => _takeAway;
  bool get itemSection => _itemSection;
  int get tax => _tax;
  int get zoneId => _zoneId;
  bool get reviewsSection => _reviewsSection;
  bool get active => _active;
  String get offDay => _offDay;
  int get selfDeliverySystem => _selfDeliverySystem;
  bool get posSystem => _posSystem;
  int get deliveryCharge => _deliveryCharge;
  String get deliveryTime => _deliveryTime;
  int get veg => _veg;
  int get nonVeg => _nonVeg;
  int get orderCount => _orderCount;
  int get totalOrder => _totalOrder;
  int get moduleId => _moduleId;
  int get orderPlaceToScheduleInterval => _orderPlaceToScheduleInterval;
  int get featured => _featured;
  int get parentId => _parentId;
  bool get gstStatus => _gstStatus;
  String get gstCode => _gstCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['phone'] = _phone;
    map['email'] = _email;
    map['logo'] = _logo;
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    map['address'] = _address;
    map['footer_text'] = _footerText;
    map['minimum_order'] = _minimumOrder;
    map['comission'] = _comission;
    map['schedule_order'] = _scheduleOrder;
    map['status'] = _status;
    map['vendor_id'] = _vendorId;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['free_delivery'] = _freeDelivery;
   // map['rating'] = _rating;
    map['cover_photo'] = _coverPhoto;
    map['delivery'] = _delivery;
    map['take_away'] = _takeAway;
    map['item_section'] = _itemSection;
    map['tax'] = _tax;
    map['zone_id'] = _zoneId;
    map['reviews_section'] = _reviewsSection;
    map['active'] = _active;
    map['off_day'] = _offDay;
    map['self_delivery_system'] = _selfDeliverySystem;
    map['pos_system'] = _posSystem;
    map['delivery_charge'] = _deliveryCharge;
    map['delivery_time'] = _deliveryTime;
    map['veg'] = _veg;
    map['non_veg'] = _nonVeg;
    map['order_count'] = _orderCount;
    map['total_order'] = _totalOrder;
    map['module_id'] = _moduleId;
    map['order_place_to_schedule_interval'] = _orderPlaceToScheduleInterval;
    map['featured'] = _featured;
    map['parent_id'] = _parentId;
    map['gst_status'] = _gstStatus;
    map['gst_code'] = _gstCode;
    return map;
  }

}