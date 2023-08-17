import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';


import 'package:sixam_mart/util/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart' as Foundation;

import '../model/response/address_model.dart';
import '../model/response/module_model.dart';


class UploadS3File extends GetxService {
  final String appBaseUrl;
  SharedPreferences sharedPreferences;
  static  String noInternetMessage = 'connection_to_api_server_failed'.tr;
  final int timeoutInSeconds = 60;

  String token;
  Map<String, String> _mainHeaders;

  UploadS3File({@required this.appBaseUrl, @required this.sharedPreferences}) {
    token = sharedPreferences.getString(AppConstants.TOKEN);

    if (Foundation.kDebugMode) {
      print('Token: $token');
    }
    AddressModel _addressModel;
    try {
      _addressModel = AddressModel.fromJson(
          jsonDecode(sharedPreferences.getString(AppConstants.USER_ADDRESS)));
    } catch (e) {}
    int _moduleID;
    if (GetPlatform.isWeb &&
        sharedPreferences.containsKey(AppConstants.MODULE_ID)) {
      try {
        _moduleID = ModuleModel.fromJson(jsonDecode(sharedPreferences.getString(AppConstants.MODULE_ID))).id;
        print("_moduleID>123>"+_moduleID.toString());
      } catch (e) {}

      /* try {
          _moduleID = ModuleModel.fromJson(jsonDecode(sharedPreferences.getString(AppConstants.MODULE_ID))).id;
      } catch (e) {}*/


    }
    updateHeader(
      token,
      _addressModel == null ? null : _addressModel.zoneIds,
      sharedPreferences.getString(AppConstants.LANGUAGE_CODE),
      _moduleID,
    );
  }

  void updateHeader(String token, List<int> zoneIDs, String languageCode, int moduleID) {
    print("moduleID>>>"+moduleID.toString());
    if(moduleID != null){
      if(moduleID ==1){
        moduleID=AppConstants.ModelID;
      }
    }
    Map<String, String> _header;
    _header = {
      'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
      'Authorization': ' ${token!=null?'Bearer ' +token:'Basic REVNTzpERU1PMTIz'}',
    };

    _mainHeaders = _header;
  }

  Future sendFile(String url, File file) async {
    print("url>>>${url}");
    print("file>>>${file.path}");
    Dio dio = new Dio();
    var len = await file.length();
    var response = await dio.put(url,
        data: file.openRead(),
        options: Options(headers: {
          Headers.contentLengthHeader: len,
        } // set content-length
        ));
    print("response>>>>>${response.statusCode}");
   /* return response;*/
  }


}

class MultipartBody {
  String key;
  XFile file;

  MultipartBody(this.key, this.file);
}
