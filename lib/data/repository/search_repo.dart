import 'dart:convert';

import 'package:sixam_mart/data/api/api_client.dart';
import 'package:sixam_mart/util/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/response/address_model.dart';

class SearchRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  SearchRepo({@required this.apiClient, @required this.sharedPreferences});

  Future<Response> getSearchData(String query, bool isStore) async {
    AddressModel _addressModel;
    try {
      _addressModel = AddressModel.fromJson(jsonDecode(sharedPreferences.getString(AppConstants.USER_ADDRESS)));
    } catch (e) {}
    print("_addressModel.zoneIds>>>"+_addressModel.zoneIds.toString());
    apiClient.updateHeader(
      sharedPreferences.getString(AppConstants.TOKEN),_addressModel.zoneIds, sharedPreferences.getString(AppConstants.LANGUAGE_CODE),
      AppConstants.ModelID,
    );
    return await apiClient.getData('${AppConstants.SEARCH_URI}${isStore ? 'stores' : 'items'}/search?name=$query&offset=1&limit=50');
  }

  Future<Response> getSuggestedItems() async {
    print("_addressModel.zoneIds>>>12");
    return await apiClient.getData(AppConstants.SUGGESTED_ITEM_URI);
  }

  Future<bool> saveSearchHistory(List<String> searchHistories) async {
    print("_addressModel.zoneIds>>>1223");
    return await sharedPreferences.setStringList(AppConstants.SEARCH_HISTORY, searchHistories);
  }

  List<String> getSearchAddress() {
    return sharedPreferences.getStringList(AppConstants.SEARCH_HISTORY) ?? [];
  }

  Future<bool> clearSearchHistory() async {
    return sharedPreferences.setStringList(AppConstants.SEARCH_HISTORY, []);
  }
}
