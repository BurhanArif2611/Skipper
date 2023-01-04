import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_compression_flutter/image_compression_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sixam_mart/controller/location_controller.dart';
import 'package:sixam_mart/controller/order_controller.dart';
import 'package:sixam_mart/controller/splash_controller.dart';
import 'package:sixam_mart/controller/store_controller.dart';
import 'package:sixam_mart/data/api/api_checker.dart';
import 'package:sixam_mart/data/model/response/address_model.dart';
import 'package:sixam_mart/data/model/response/parcel_category_model.dart';
import 'package:sixam_mart/data/model/response/place_details_model.dart';
import 'package:sixam_mart/data/model/response/task_model.dart';
import 'package:sixam_mart/data/model/response/zone_response_model.dart';
import 'package:sixam_mart/data/repository/parcel_repo.dart';
import 'package:sixam_mart/util/app_constants.dart';
import 'package:sixam_mart/view/base/custom_snackbar.dart';

import '../helper/network_info.dart';

class ParcelController extends GetxController implements GetxService {
  final ParcelRepo parcelRepo;

  ParcelController({@required this.parcelRepo});

  List<ParcelCategoryModel> _parcelCategoryList;
  List<AddressModel> _anotherList = [];
  List<TaskModel> _anothertaskList = [];
  AddressModel _pickupAddress;
  AddressModel _destinationAddress;
  bool _isPickedUp = true;
  bool _isSender = true;
  bool _isLoading = false;
  double _distance = -1;
  double _deliveryCharge = 0;
  double _deliveryFinalCharge = 0;
  List<String> _payerTypes = ['sender', 'receiver'];
  int _payerIndex = 0;
  int _paymentIndex = 0;
  String _parcelType = "EXPRESS DELIVERY";

  List<ParcelCategoryModel> get parcelCategoryList => _parcelCategoryList;

  List<AddressModel> get anotherList => _anotherList;

  List<TaskModel> get anothertaskList => _anothertaskList;

  AddressModel get pickupAddress => _pickupAddress;

  AddressModel get destinationAddress => _destinationAddress;

  bool get isPickedUp => _isPickedUp;

  bool get isSender => _isSender;

  bool get isLoading => _isLoading;

  double get distance => _distance;

  double get deliveryCharge => _deliveryCharge;
  double get deliveryFinalCharge => _deliveryFinalCharge;

  int get payerIndex => _payerIndex;

  int get paymentIndex => _paymentIndex;

  String get parcelType => _parcelType;

  List<String> get payerTypes => _payerTypes;

  List<File_path> _pickedFileList = [];

  List<File_path> get pickedFileList => _pickedFileList;

  List<File_Unitpath> _pickedUintFileList = [];

  List<File_Unitpath> get pickedUintFileList => _pickedUintFileList;
  XFile _pickedFile;
  Uint8List _rawFile;

  XFile get pickedFile => _pickedFile;

  Uint8List get rawFile => _rawFile;

  void clear() {
    /* _parcelCategoryList = [];*/
    _anotherList = [];
    _anothertaskList = [];
    _destinationAddress = null;
    _pickupAddress = null;
  }

  Future<void> getParcelCategoryList() async {
    print("getParcelCategoryList<><>");
    Response response = await parcelRepo.getParcelCategory();

    if (response.statusCode == 200) {
      _parcelCategoryList = [];

      response.body.forEach((parcel) =>
          _parcelCategoryList.add(ParcelCategoryModel.fromJson(parcel)));
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void pickImage() async {
    _pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (_pickedFile != null) {
      _pickedFile = await NetworkInfo.compressImage(_pickedFile);
      _rawFile = await _pickedFile.readAsBytes();
      File_path file_path = File_path(file: _pickedFile);
      _pickedFileList.add(file_path);

      File_Unitpath file_unitpath = File_Unitpath(rawFile: _rawFile);
      _pickedUintFileList.add(file_unitpath);

      print("pickImage" + _pickedFile.path);
    }

    update();
  }

  void clear_pickupImage() {
    _pickedFileList.clear();
    _pickedUintFileList.clear();
  }

  void setPickupAddress(AddressModel addressModel, bool notify) {
    _pickupAddress = addressModel;
    if (notify) {
      update();
    }
  }

  void setDestinationAddress(AddressModel addressModel, bool notify) {
    if (notify) {
      _destinationAddress = null;
    }
    _destinationAddress = addressModel;
    update();
  }

  void removeDestinationAddress() {
    _destinationAddress = null;
    update();
  }

  void setMultiDropDestinationAddress(AddressModel addressModel) {
    print("setMultiDropDestinationAddress>>++++");
    _anotherList.add(addressModel);
    print("setMultiDropDestinationAddress>>" + _anotherList.length.toString());
    update();
  }

  void removeMultiDropDestinationAddress(int position) {
    _anotherList.removeAt(position);
    print("setMultiDropDestinationAddress>>");
    update();
  }

  void setMultiTask(TaskModel addressModel) {
    print("setMultiDropDestinationAddress>>++++" +
        addressModel.rawFile.length.toString());
    print("setMultiDropDestinationAddress>>++++" +
        addressModel.task_media.length.toString());
    _anothertaskList.add(addressModel);
    print("setMultiDropDestinationAddress>>" +
        _anothertaskList.length.toString());
    update();
  }

  void removeMultiTask(int position) {
    print("setMultiDropDestinationAddress>>++++");
    _anothertaskList.removeAt(position);
    update();
  }

  void removeImageInList(int position) {
    print("setMultiDropDestinationAddress>>++++");
    _pickedUintFileList.removeAt(position);
    _pickedFileList.removeAt(position);
    update();
  }

  void clearMultiTask() {
    _anothertaskList.clear();
    update();
  }

  void clearMultiDropDestinationAddress() {
    _anotherList.clear();
  }

  void setLocationFromPlace(
      String placeID, String address, bool isPickedUp) async {
    Response response = await parcelRepo.getPlaceDetails(placeID);
    if (response.statusCode == 200) {
      PlaceDetailsModel _placeDetails =
          PlaceDetailsModel.fromJson(response.body);
      if (_placeDetails.status == 'OK') {
        AddressModel _address = AddressModel(
          address: address,
          addressType: 'others',
          latitude: _placeDetails.result.geometry.location.lat.toString(),
          longitude: _placeDetails.result.geometry.location.lng.toString(),
          contactPersonName:
              Get.find<LocationController>().getUserAddress().contactPersonName,
          contactPersonNumber: Get.find<LocationController>()
              .getUserAddress()
              .contactPersonNumber,
        );

        ZoneResponseModel _response = await Get.find<LocationController>()
            .getZone(_address.latitude, _address.longitude, false);

        /* print("Location>>1>"+Get.find<LocationController>()
            .getUserAddress()
            .zoneIds.toString());
        print("Location>>2>"+_response.zoneIds[0].toString());*/
        if (_response.isSuccess) {
          /*  if (Get.find<LocationController>()
              .getUserAddress()
              .zoneIds
              .contains(_response.zoneIds[0])) {
            _address.zoneId = _response.zoneIds[0];
            _address.zoneIds = [];
            _address.zoneIds.addAll(_response.zoneIds);
            if (isPickedUp) {
              setPickupAddress(_address, true);
            } else {
              setDestinationAddress(_address);
            }
          } else {
            showCustomSnackBar(
                'your_selected_location_is_from_different_zone_store'.tr);
          }*/
          bool check = false;
          if (Get.find<StoreController>().store.zones != null) {
            for (int i = 0;
                i < Get.find<StoreController>().store.zones.length;
                i++) {
              if (Get.find<StoreController>().store.zones != null &&
                  Get.find<StoreController>().store.zones[i].zone_id ==
                      _response.zoneIds[0]) {
                check = true;
                break;
              }
            }
          }
          if (check) {
            _address.zoneId = _response.zoneIds[0];
            _address.zoneIds = [];
            _address.zoneIds.addAll(_response.zoneIds);
            if (isPickedUp) {
              setPickupAddress(_address, true);
            } else {
              setDestinationAddress(_address, true);
            }
          } else {
            showCustomSnackBar(
                'your_selected_location_is_from_different_zone_store'.tr);
          }
        } else {
          print("message>>>" + _response.message);
          showCustomSnackBar(_response.message);
        }
      }
    }
  }

  void setIsPickedUp(bool isPickedUp, bool notify) {
    _isPickedUp = isPickedUp;
    if (notify) {
      update();
    }
  }

  void setIsSender(bool sender, bool notify) {
    _isSender = sender;
    if (notify) {
      update();
    }
  }

  void getDistance(
      AddressModel pickedUpAddress, AddressModel destinationAddress) async {
    _distance = -1;
    String multidrop_array = "";
    if (_anotherList.length > 0) {
      _anotherList.forEach((addressmodel) {
        if (multidrop_array == "") {
          multidrop_array = multidrop_array +
              "[" +
              addressmodel.latitude +
              "," +
              addressmodel.longitude +
              "]";
        } else {
          multidrop_array = multidrop_array +
              ",[" +
              addressmodel.latitude +
              "," +
              addressmodel.longitude +
              "]";
        }
      });
    }
    multidrop_array = "[" + multidrop_array + "]";
    print("multidrop_array<><>" + multidrop_array);
    print("multidrop_array<><>" +
        destinationAddress.latitude +
        "<><>" +
        destinationAddress.longitude);
    if (multidrop_array == "") {
      _distance = await Get.find<OrderController>().getDistanceInKM(
          LatLng(double.parse(pickedUpAddress.latitude),
              double.parse(pickedUpAddress.longitude)),
          LatLng(double.parse(destinationAddress.latitude),
              double.parse(destinationAddress.longitude)),
          multidrop_array);
    } else {
      _distance = await Get.find<OrderController>().getDistanceInKM(
          LatLng(double.parse(pickedUpAddress.latitude),
              double.parse(pickedUpAddress.longitude)),
          LatLng(0.0, 0.0),
          multidrop_array);
    }
    _isLoading = false;
    update();
  }

  void setPayerIndex(int index, bool notify) {
    _payerIndex = index;
    if (_payerIndex == 1) {
      _paymentIndex = 0;
    }
    if (notify) {
      update();
    }
  }

  void setParcelType(String parcelType) {
    _parcelType = parcelType;
    try{
     update();}catch(e){}
  }

  void setDeliveryCharge(double deliveryCharge) {
    _deliveryCharge = deliveryCharge;
    if (deliveryCharge> 0) {
      try{
      update();}catch(e){}
    }
  }
  void setDeliveryFinalCharge(double deliveryCharge) {
    _deliveryFinalCharge = deliveryCharge;
    if (deliveryCharge> 0) {
      try{
      update();}catch(e){}
    }
    print("setDeliveryFinalCharge>>>"+_deliveryFinalCharge.toString());
  }

  void setPaymentIndex(int index, bool notify) {
    _paymentIndex = index;
    if (notify) {
      update();
    }
  }

  void startLoader(bool isEnable) {
    _isLoading = isEnable;
    update();
  }

  void pickedFile_null() {
    _pickedFile = null;
    _rawFile = null;
  }
}
