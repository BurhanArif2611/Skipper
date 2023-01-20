import 'dart:convert';

import 'package:image_picker/image_picker.dart';
import 'package:sixam_mart/controller/parcel_controller.dart';
import 'package:sixam_mart/data/api/api_client.dart';
import 'package:sixam_mart/data/model/body/errand_order_body.dart';
import 'package:sixam_mart/data/model/body/place_order_body.dart';
import 'package:sixam_mart/util/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/body/set_errand_order_body.dart';
import '../model/response/address_model.dart';

class OrderRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  OrderRepo({@required this.apiClient, @required this.sharedPreferences});

  Future<Response> getRunningOrderList(int offset) async {
    AddressModel _addressModel;
    try {
      _addressModel = AddressModel.fromJson(jsonDecode(sharedPreferences.getString(AppConstants.USER_ADDRESS)));
    } catch (e) {}
    apiClient.updateHeader(
      sharedPreferences.getString(AppConstants.TOKEN),_addressModel.zoneIds, sharedPreferences.getString(AppConstants.LANGUAGE_CODE),
      AppConstants.ModelID,
    );
    return await apiClient.getData(
        '${AppConstants.RUNNING_ORDER_LIST_URI}?offset=$offset&limit=10');
  }

  Future<Response> getHistoryOrderList(int offset) async {
    AddressModel _addressModel;
    try {
      _addressModel = AddressModel.fromJson(jsonDecode(sharedPreferences.getString(AppConstants.USER_ADDRESS)));
    } catch (e) {}
    apiClient.updateHeader(
      sharedPreferences.getString(AppConstants.TOKEN),_addressModel.zoneIds, sharedPreferences.getString(AppConstants.LANGUAGE_CODE),
      AppConstants.ModelID,
    );
    return await apiClient.getData(
        '${AppConstants.HISTORY_ORDER_LIST_URI}?offset=$offset&limit=10');
  }

  Future<Response> getOrderDetails(String orderID) async {
    AddressModel _addressModel;
    try {
      _addressModel = AddressModel.fromJson(jsonDecode(sharedPreferences.getString(AppConstants.USER_ADDRESS)));
    } catch (e) {}
    apiClient.updateHeader(
      sharedPreferences.getString(AppConstants.TOKEN),_addressModel.zoneIds, sharedPreferences.getString(AppConstants.LANGUAGE_CODE),
      AppConstants.ModelID,
    );
    return await apiClient.getData('${AppConstants.ORDER_DETAILS_URI}$orderID');
  }

  Future<Response> cancelOrder(String orderID) async {
    AddressModel _addressModel;
    try {
      _addressModel = AddressModel.fromJson(jsonDecode(sharedPreferences.getString(AppConstants.USER_ADDRESS)));
    } catch (e) {}
    apiClient.updateHeader(
      sharedPreferences.getString(AppConstants.TOKEN),_addressModel.zoneIds, sharedPreferences.getString(AppConstants.LANGUAGE_CODE),
      AppConstants.ModelID,
    );
    return await apiClient.postData(
        AppConstants.ORDER_CANCEL_URI, {'_method': 'put', 'order_id': orderID});
  }

  Future<Response> trackOrder(String orderID) async {
    AddressModel _addressModel;
    try {
      _addressModel = AddressModel.fromJson(jsonDecode(sharedPreferences.getString(AppConstants.USER_ADDRESS)));
    } catch (e) {}
    apiClient.updateHeader(
      sharedPreferences.getString(AppConstants.TOKEN),_addressModel.zoneIds, sharedPreferences.getString(AppConstants.LANGUAGE_CODE),
      AppConstants.ModelID,
    );
    return await apiClient.getData('${AppConstants.TRACK_URI}$orderID');
  }

  Future<Response> placeOrder(

      PlaceOrderBody orderBody, XFile orderAttachment) async {
    AddressModel _addressModel;
    try {
      _addressModel = AddressModel.fromJson(jsonDecode(sharedPreferences.getString(AppConstants.USER_ADDRESS)));
    } catch (e) {}
    apiClient.updateHeader(
      sharedPreferences.getString(AppConstants.TOKEN),_addressModel.zoneIds, sharedPreferences.getString(AppConstants.LANGUAGE_CODE),
      AppConstants.ModelID,
    );
    return await apiClient.postMultipartData(
      AppConstants.PLACE_ORDER_URI,
      orderBody.toJson(),
      [MultipartBody('order_attachment', orderAttachment)],
    );
  }

  Future<Response> errandPlaceOrder(ErrandOrderBody orderBody) async {
    AddressModel _addressModel;
    try {
      _addressModel = AddressModel.fromJson(jsonDecode(sharedPreferences.getString(AppConstants.USER_ADDRESS)));
    } catch (e) {}
    apiClient.updateHeader(
      sharedPreferences.getString(AppConstants.TOKEN),_addressModel.zoneIds, sharedPreferences.getString(AppConstants.LANGUAGE_CODE),
      AppConstants.ModelID,
    );
    List<MultipartBody> multipartBody = [];
    if (Get.find<ParcelController>().anothertaskList.length > 0) {
      for (int i = 0; i < Get.find<ParcelController>().anothertaskList.length; i++) {
        if (Get.find<ParcelController>().anothertaskList[i].task_media != null) {
          for (int j = 0; j < Get
              .find<ParcelController>()
              .anothertaskList[i].task_media.length; j++) {
            print("image>>"+'task_media_file_$i[${j}]');
            multipartBody.add(MultipartBody('task_media_file_$i[${j}]', Get
                .find<ParcelController>()
                .anothertaskList[i].task_media[j].file));
          }
        }
      }
    }

    return await apiClient.postMultipartData(
        AppConstants.PLACE_ORDER_URI, orderBody.toJson(), multipartBody
        /* [MultipartBody('order_attachment', orderAttachment)],*/
        /* [MultipartBody('task_media_file_1[0]', Get.find<ParcelController>().anothertaskList[0].task_media)],*/
        );
  }

  Future<Response> getDeliveryManData(String orderID) async {
    AddressModel _addressModel;
    try {
      _addressModel = AddressModel.fromJson(jsonDecode(sharedPreferences.getString(AppConstants.USER_ADDRESS)));
    } catch (e) {}
    apiClient.updateHeader(
      sharedPreferences.getString(AppConstants.TOKEN),_addressModel.zoneIds, sharedPreferences.getString(AppConstants.LANGUAGE_CODE),
      AppConstants.ModelID,
    );
    return await apiClient.getData('${AppConstants.LAST_LOCATION_URI}$orderID');
  }

  Future<Response> switchToCOD(String orderID) async {
    AddressModel _addressModel;
    try {
      _addressModel = AddressModel.fromJson(jsonDecode(sharedPreferences.getString(AppConstants.USER_ADDRESS)));
    } catch (e) {}
    apiClient.updateHeader(
      sharedPreferences.getString(AppConstants.TOKEN),_addressModel.zoneIds, sharedPreferences.getString(AppConstants.LANGUAGE_CODE),
      AppConstants.ModelID,
    );
    return await apiClient.postData(
        AppConstants.COD_SWITCH_URL, {'_method': 'put', 'order_id': orderID});
  }

  Future<Response> getDistanceInMeter(LatLng originLatLng,
      LatLng destinationLatLng, String multiDroplocation) async {
    AddressModel _addressModel;
    try {
      _addressModel = AddressModel.fromJson(jsonDecode(sharedPreferences.getString(AppConstants.USER_ADDRESS)));
    } catch (e) {}
    apiClient.updateHeader(
      sharedPreferences.getString(AppConstants.TOKEN),_addressModel.zoneIds, sharedPreferences.getString(AppConstants.LANGUAGE_CODE),
      AppConstants.ModelID,
    );
    print("getDistanceInMeter>>" +
        ('${AppConstants.DISTANCE_MATRIX_URI}'
            '?origin_lat=${originLatLng.latitude}&origin_lng=${originLatLng.longitude}'
            '&destination_lat=${destinationLatLng.latitude}&destination_lng=${destinationLatLng.longitude}'
            '&destinations=${multiDroplocation}'));
    return await apiClient.getData('${AppConstants.DISTANCE_MATRIX_URI}'
        '?origin_lat=${originLatLng.latitude}&origin_lng=${originLatLng.longitude}'
        '&destination_lat=${destinationLatLng.latitude}&destination_lng=${destinationLatLng.longitude}'
        '&destinations=${multiDroplocation}');
  }

  Future<Response> setErrandCounter(SetErrandOrderBody updateStatusBody) {
    AddressModel _addressModel;
    try {
      _addressModel = AddressModel.fromJson(jsonDecode(sharedPreferences.getString(AppConstants.USER_ADDRESS)));
    } catch (e) {}
    apiClient.updateHeader(
      sharedPreferences.getString(AppConstants.TOKEN),_addressModel.zoneIds, sharedPreferences.getString(AppConstants.LANGUAGE_CODE),
      AppConstants.ModelID,
    );
    return apiClient.putData(
        AppConstants.Accept_ERRAND_COUNTER_URI, updateStatusBody.toJson());
  }
}


