import 'package:sixam_mart/data/api/api_client.dart';
import 'package:sixam_mart/data/model/response/userinfo_model.dart';
import 'package:sixam_mart/util/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:image_picker/image_picker.dart';

class UserRepo {
  final ApiClient apiClient;
  UserRepo({@required this.apiClient});

  Future<Response> getUserInfo() async {
    return await apiClient.getData(AppConstants.CUSTOMER_INFO_URI);
  }
  Future<Response> updateProfileDetails(String firstName,String lastName,String phone,String anonymous,String email) async {
    return await apiClient.putData('${AppConstants.CUSTOMER_INFO_URI}', {'first': firstName, 'last':lastName,
    'mobile_number': phone,'email': email, 'anonymous':anonymous});
  }
  Future<Response> updateProfile(UserInfoModel userInfoModel, XFile data, String token) async {
    Map<String, String> _body = Map();
    _body.addAll(<String, String>{
      'f_name': userInfoModel.fName, 'l_name': userInfoModel.lName, 'email': userInfoModel.email
    });
    return await apiClient.postMultipartData(AppConstants.UPDATE_PROFILE_URI, _body, [MultipartBody('image', data)]);
  }

  Future<Response> changePassword(String currentPassword,String newPassword,String confirmPassword) async {
    return await apiClient.putData('${AppConstants.CHANGE_PASSWORD_URI}', {'old_password': currentPassword, 'new_password':newPassword,
      'confirm_password': confirmPassword});
  }

  Future<Response> deleteUser() async {
    return await apiClient.deleteData(AppConstants.CUSTOMER_REMOVE);
  }

}