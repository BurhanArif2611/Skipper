import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sixam_mart/data/api/api_client.dart';
import 'package:sixam_mart/util/app_constants.dart';

import '../../controller/splash_controller.dart';

class ParcelRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  int module_id;
 // ParcelRepo(this.sharedPreferences, {@required this.apiClient});
  ParcelRepo({@required this.sharedPreferences, @required this.apiClient});
  Future<Response> getParcelCategory() {
    if (Get.find<SplashController>().moduleList != null &&
        Get.find<SplashController>().moduleList.length > 0) {
      Get.find<SplashController>().moduleList.forEach(
              (storeCategory) => {
            if(storeCategory.moduleType=='parcel'){
              module_id = storeCategory.id
            }
          });
    }
    apiClient.updateHeader(
      sharedPreferences.getString(AppConstants.TOKEN),null, sharedPreferences.getString(AppConstants.LANGUAGE_CODE),
      module_id,
    );
    return apiClient.getData(AppConstants.PARCEL_CATEGORY_URI);
  }

  Future<Response> getPlaceDetails(String placeID) async {
    return await apiClient.getData('${AppConstants.PLACE_DETAILS_URI}?placeid=$placeID');
  }

}