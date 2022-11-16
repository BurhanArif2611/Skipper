import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sixam_mart/data/api/api_client.dart';
import 'package:sixam_mart/util/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/response/response.dart';

import '../model/response/address_model.dart';

class StoreRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
 // StoreRepo({@required this.apiClient});
  StoreRepo({@required this.apiClient, @required this.sharedPreferences});
  Future<Response> getStoreList(int offset, String filterBy) async {
    AddressModel _addressModel;
    try {
      _addressModel = AddressModel.fromJson(jsonDecode(sharedPreferences.getString(AppConstants.USER_ADDRESS)));
    } catch (e) {}
    apiClient.updateHeader(
      sharedPreferences.getString(AppConstants.TOKEN),_addressModel.zoneIds, sharedPreferences.getString(AppConstants.LANGUAGE_CODE),
      AppConstants.ModelID,
    );
    return await apiClient.getData('${AppConstants.STORE_URI}/$filterBy?offset=$offset&limit=10');
  }

  Future<Response> getPopularStoreList(String type) async {
    return await apiClient.getData('${AppConstants.POPULAR_STORE_URI}?type=$type');
  }

  Future<Response> getLatestStoreList(String type) async {
    AddressModel _addressModel;
    try {
      _addressModel = AddressModel.fromJson(jsonDecode(sharedPreferences.getString(AppConstants.USER_ADDRESS)));
    } catch (e) {}
    apiClient.updateHeader(
      sharedPreferences.getString(AppConstants.TOKEN),_addressModel.zoneIds, sharedPreferences.getString(AppConstants.LANGUAGE_CODE),
      AppConstants.ModelID,
    );
    return await apiClient.getData('${AppConstants.LATEST_STORE_URI}?type=$type');
  }

  Future<Response> getFeaturedStoreList() async {
    AddressModel _addressModel;
    try {
      _addressModel = AddressModel.fromJson(jsonDecode(sharedPreferences.getString(AppConstants.USER_ADDRESS)));
    } catch (e) {}
    apiClient.updateHeader(
      sharedPreferences.getString(AppConstants.TOKEN),_addressModel.zoneIds, sharedPreferences.getString(AppConstants.LANGUAGE_CODE),
      AppConstants.ModelID,
    );
    return await apiClient.getData('${AppConstants.STORE_URI}/all?featured=1&offset=1&limit=50');
  }

  Future<Response> getStoreDetails(String storeID) async {
    AddressModel _addressModel;
    try {
      _addressModel = AddressModel.fromJson(jsonDecode(sharedPreferences.getString(AppConstants.USER_ADDRESS)));
    } catch (e) {}
    apiClient.updateHeader(
      sharedPreferences.getString(AppConstants.TOKEN),_addressModel !=null&&_addressModel.zoneIds!=null?_addressModel.zoneIds:[], sharedPreferences.getString(AppConstants.LANGUAGE_CODE),
      AppConstants.ModelID,
    );
    return await apiClient.getData('${AppConstants.STORE_DETAILS_URI}$storeID');
  }

  Future<Response> getStoreItemList(int storeID, int offset, int categoryID, String type) async {
    AddressModel _addressModel;
    try {
      _addressModel = AddressModel.fromJson(jsonDecode(sharedPreferences.getString(AppConstants.USER_ADDRESS)));
    } catch (e) {}
    apiClient.updateHeader(
      sharedPreferences.getString(AppConstants.TOKEN),_addressModel!=null && _addressModel.zoneIds!=null?_addressModel.zoneIds:[], sharedPreferences.getString(AppConstants.LANGUAGE_CODE),
      AppConstants.ModelID,
    );
    return await apiClient.getData(
      '${AppConstants.STORE_ITEM_URI}?store_id=$storeID&category_id=$categoryID&offset=$offset&limit=10&type=$type',
    );
  }

  Future<Response> getStoreSearchItemList(String searchText, String storeID, int offset, String type) async {

    return await apiClient.getData(
      '${AppConstants.SEARCH_URI}items/search?store_id=$storeID&name=$searchText&offset=$offset&limit=10&type=$type',
    );
  }

  Future<Response> getStoreReviewList(String storeID) async {
    return await apiClient.getData('${AppConstants.STORE_REVIEW_URI}?store_id=$storeID');
  }

}