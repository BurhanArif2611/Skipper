import 'dart:async';
import 'dart:io';

import 'package:sixam_mart/controller/location_controller.dart';
import 'package:sixam_mart/controller/splash_controller.dart';
import 'package:sixam_mart/data/api/api_client.dart';
import 'package:sixam_mart/data/model/body/signup_body.dart';
import 'package:sixam_mart/data/model/body/social_log_in_body.dart';
import 'package:sixam_mart/util/app_constants.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';


class KycRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  KycRepo({@required this.apiClient, @required this.sharedPreferences});

  Future<Response> registration(SignUpBody signUpBody) async {
    return await apiClient.postData(AppConstants.REGISTER_URI, signUpBody.toJson());
  }
  Future<Response> updateProfile(SignUpBody signUpBody,String UserID) async {
    return await apiClient.putData('${AppConstants.REGISTER_URI}/$UserID', signUpBody.toJson());
  }

  Future<Response> login({String phone, String password,bool security_officer}) async {
    return await apiClient.postData(AppConstants.LOGIN_URI, {"username": phone, "password": password, "grant_type": 'password'});
  }



  Future<Response> checkMobileNumber({String phone}) async {
    return await apiClient.postData(AppConstants.CHECK_PHONE_URI, {"phone": phone});
  }

  Future<Response> loginWithSocialMedia(String email) async {
    return await apiClient.postData(AppConstants.SOCIAL_LOGIN_URL, {"email": email});
  }

  Future<Response> registerWithSocialMedia(SocialLogInBody socialLogInBody) async {
    return await apiClient.postData(AppConstants.SOCIAL_REGISTER_URL, socialLogInBody.toJson());
  }



  Future<Response> updateToken() async {
    String _deviceToken;
    //  saveUserToken(sharedPreferences.getString(AppConstants.TOKEN));
    if (GetPlatform.isIOS && !GetPlatform.isWeb) {
      FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true);
      NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
        alert: true, announcement: false, badge: true, carPlay: false,
        criticalAlert: false, provisional: false, sound: true,
      );
      if(settings.authorizationStatus == AuthorizationStatus.authorized) {
        _deviceToken = await _saveDeviceToken();
      }
    }else {
      _deviceToken = await _saveDeviceToken();
    }
    print("_deviceToken>>>"+_deviceToken);
    if(!GetPlatform.isWeb) {
      FirebaseMessaging.instance.subscribeToTopic(AppConstants.TOPIC);
    }
    //  return await apiClient.postData(AppConstants.TOKEN_URI, {"_method": "put", "cm_firebase_token": _deviceToken});
    return null;
  }

  Future<String> _saveDeviceToken() async {
    String _deviceToken = '@';
    if(!GetPlatform.isWeb) {
      try {
        _deviceToken = await FirebaseMessaging.instance.getToken();
      }catch(e) {}
    }
    if (_deviceToken != null) {
      print('--------Device Token---------- '+_deviceToken);
    }
    return _deviceToken;
  }

  Future<Response> forgetPassword(String phone) async {
    // return await apiClient.postData(AppConstants.FORGET_PASSWORD_URI, {"email": phone});
    return await apiClient.getData('${AppConstants.FORGET_PASSWORD_URI}$phone');
  }

  Future<Response> verifyToken(String phone, String token) async {
    return await apiClient.postData(AppConstants.VERIFY_TOKEN_URI, {"phone": phone, "reset_token": token});
  }
  Future<Response> pollingSurvey(String imei_number) async {
    return await apiClient.getData('${AppConstants.PollingSurvey_URI}?imei_number=$imei_number');
  }
  Future<Response> regions() async {
    return await apiClient.getData(AppConstants.Regions_URI);
  }

  Future<Response> resetPassword(String resetToken, String number, String password, String confirmPassword) async {
    return await apiClient.postData(
      AppConstants.RESET_PASSWORD_URI,
      { "email": resetToken,  "password": password, "confirmPassword": confirmPassword},
    );
  } Future<Response> updatePassword( String password, String confirmPassword, String token, String email) async {
    return await apiClient.postData(
      AppConstants.UPDATEPASSWORD_URI,
      { "email": email,  "password": password, "confirmPassword": confirmPassword, "token": token},
    );
  }


  Future<Response> checkEmail(String email) async {
    return await apiClient.postData(AppConstants.CHECK_EMAIL_URI, {"email": email});
  }

  Future<Response> verifyEmail(String email, String token) async {
    return await apiClient.postData(AppConstants.VERIFY_EMAIL_URI, {"email": email, "token": token});
  }

  Future<Response> updateZone() async {
    return await apiClient.getData(AppConstants.UPDATE_ZONE_URL);
  }

  Future<Response> getIncidents() async {
    return await apiClient.getData(AppConstants.Incidents_URL);
  }
  Future<Response> getNewsList() async {
    return await apiClient.getData(AppConstants.News_URL);
  }
  Future<Response> getCategoryList() async {
    return await apiClient.getData(AppConstants.Categories_URL);
  }
  Future<Response> getStateList() async {
    return await apiClient.getData(AppConstants.StateList_URL);
  }
  Future<Response> getIncidentTypesList() async {
    return await apiClient.getData(AppConstants.IncidentTypes_URL);
  }
  Future<Response> getLgaList(String state_id) async {
    return await apiClient.getData('${AppConstants.LgaList_URL}?state_id=$state_id');
  }
  Future<Response> getWardList(String state_id) async {
    return await apiClient.getData('${AppConstants.WardList_URL}?lga_id=$state_id');
  }
  Future<Response> getSurveyList() async {
    return await apiClient.getData(AppConstants.Surveys_URL);
  }

  Future<Response> getSurveyDetail(String id) async {
    return await apiClient.getData('${AppConstants.Surveys_URL}/$id');
  }


  Future<Response> verifyPhone(String otp_id, String otp) async {
    return await apiClient.postData(AppConstants.VERIFY_PHONE_URI, {"otp_id": otp_id, "otp": otp});
  }


  // for  user token
  Future<bool> saveUserToken(String token) async {
    /* apiClient.token = token;
    apiClient.updateHeader(
      token, null, sharedPreferences.getString(AppConstants.LANGUAGE_CODE),
      Get.find<SplashController>().module != null ? Get.find<SplashController>().module.id : null,
    );*/
    return await sharedPreferences.setString(AppConstants.TOKEN, token);
  }
  Future<bool> saveUserRole(bool role) async {
    print("role>>>> ${role}");
    return await sharedPreferences.setBool(AppConstants.ROLE, role);
  }

  String getUserToken() {
    return sharedPreferences.getString(AppConstants.TOKEN) ?? "";
  }
  String getLANGUAGE_CODE() {
    return sharedPreferences.getString(AppConstants.LANGUAGE_CODE) ;
  }

  bool isLoggedIn() {
    return sharedPreferences.containsKey(AppConstants.TOKEN);
  }

  bool clearSharedData() {
    if(!GetPlatform.isWeb) {
      FirebaseMessaging.instance.unsubscribeFromTopic(AppConstants.TOPIC);
      // apiClient.postData(AppConstants.TOKEN_URI, {"_method": "put", "cm_firebase_token": '@'});
    }
    sharedPreferences.remove(AppConstants.TOKEN);
    sharedPreferences.setStringList(AppConstants.CART_LIST, []);
    sharedPreferences.remove(AppConstants.USER_ADDRESS);
    apiClient.token = null;
    apiClient.updateHeader(null, null, null, null);
    return true;
  }

  bool clearSharedAddress(){
    sharedPreferences.remove(AppConstants.USER_ADDRESS);
    return true;
  }

  // for  Remember Email
  Future<void> saveUserNumberAndPassword(String number, String password, String countryCode) async {
    try {
      await sharedPreferences.setString(AppConstants.USER_PASSWORD, password);
      await sharedPreferences.setString(AppConstants.USER_NUMBER, number);
      await sharedPreferences.setString(AppConstants.USER_COUNTRY_CODE, countryCode);
    } catch (e) {
      throw e;
    }
  }

  String getUserNumber() {
    return sharedPreferences.getString(AppConstants.USER_NUMBER) ?? "";
  }

  String getUserCountryCode() {
    return sharedPreferences.getString(AppConstants.USER_COUNTRY_CODE) ?? "";
  }

  String getUserPassword() {
    return sharedPreferences.getString(AppConstants.USER_PASSWORD) ?? "";
  }

  bool isNotificationActive() {
    return sharedPreferences.getBool(AppConstants.NOTIFICATION) ?? true;
  }

  void setNotificationActive(bool isActive) {
    if(isActive) {
      updateToken();
    }else {
      if(!GetPlatform.isWeb) {
        FirebaseMessaging.instance.unsubscribeFromTopic(AppConstants.TOPIC);
        if(isLoggedIn()) {
          FirebaseMessaging.instance.unsubscribeFromTopic('zone_${Get.find<LocationController>().getUserAddress().zoneId}_customer');
        }
      }
    }
    sharedPreferences.setBool(AppConstants.NOTIFICATION, isActive);
  }

  Future<bool> clearUserNumberAndPassword() async {
    await sharedPreferences.remove(AppConstants.USER_PASSWORD);
    await sharedPreferences.remove(AppConstants.USER_COUNTRY_CODE);
    return await sharedPreferences.remove(AppConstants.USER_NUMBER);
  }

  Future<Response> createKYC(String name,String description,String user_id, XFile front_Id, XFile back_id, XFile ssn, String token) async {
    Map<String, String> _body = Map();
    _body.addAll(<String, String>{
      'name': name, 'description':description, 'user_id': user_id
    });

    return await apiClient.postMultipartData(AppConstants.POST_KYC_Document, _body, [MultipartBody('front_Id', front_Id),MultipartBody('back_id', back_id),MultipartBody('ssn', ssn),]);
  }
}
