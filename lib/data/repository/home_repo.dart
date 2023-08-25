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

import '../api/uploads3file.dart';
import '../model/body/news_submit_body.dart';
import '../model/body/report_incidence_body.dart';

class HomeRepo {
  final ApiClient apiClient;
  final UploadS3File apiClientother;
  final SharedPreferences sharedPreferences;
  HomeRepo({@required this.apiClient,@required this.apiClientother, @required this.sharedPreferences});

  Future<Response> registration(SignUpBody signUpBody) async {
    return await apiClient.postData(AppConstants.REGISTER_URI, signUpBody.toJson());
  }

  Future<Response> login({String phone, String password}) async {
    return await apiClient.postData(AppConstants.LOGIN_URI, {"username": phone, "password": password, "grant_type": 'password', "scope": "2"});
  }

  Future<Response> addSOSContact({String name, String relation,String phone}) async {
    return await apiClient.postData(AppConstants.ADD_SOS_CONTACT_URI, {"name": name, "relation": relation, "number": phone});
  }
  Future<Response> deleteSOSContact({String id}) async {
    return await apiClient.deleteData('${AppConstants.ADD_SOS_CONTACT_URI}/'+id );
  }


  Future<Response> uploadfile({String id}) async {
    return await apiClient.deleteData('${AppConstants.ADD_SOS_CONTACT_URI}/'+id );
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
    return await apiClient.postData(AppConstants.FORGET_PASSWORD_URI, {"email": phone});
  }

  Future<Response> verifyToken(String phone, String token) async {
    return await apiClient.postData(AppConstants.VERIFY_TOKEN_URI, {"phone": phone, "reset_token": token});
  }

  Future<Response> resetPassword(String resetToken, String number, String password, String confirmPassword) async {
    return await apiClient.postData(
      AppConstants.RESET_PASSWORD_URI,
      {"_method": "put", "reset_token": resetToken, "phone": number, "password": password, "confirm_password": confirmPassword},
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
  Future<Response> getIncidenceDetail(String id) async {
    return await apiClient.getData('${AppConstants.Incidents_URI}/$id');
  }
  Future<Response> getCommentList(String id) async {
    return await apiClient.getData('${AppConstants.IncidentComment_URI}/$id');
  }
  Future<Response> getSecurityOfficerCommentList(String id) async {
    return await apiClient.getData('${AppConstants.SecurityComment_URI}$id');
  }
  Future<Response> addReport(ReportIncidenceBody signUpBody) async {
    return await apiClient.postModelData(AppConstants.Incidents_URI, signUpBody);
  }

  Future<Response> submitSurveyResultu(NewsSubmitBody signUpBody) async {
    return await apiClient.postResultData(AppConstants.SubmitSurveys_URI, signUpBody);
  }

  Future<Response> getSurveyDetail(String id) async {
    return await apiClient.getData('${AppConstants.Surveys_URL}/$id');
  }
  Future<Response> getSOSContactList() async {
    return await apiClient.getData('${AppConstants.ADD_SOS_CONTACT_URI}');
  }
  Future<Response> getResourceCenterList() async {
    return await apiClient.getData('${AppConstants.Resource_Centers_URI}');
  }
  Future<Response> getContactCenterList() async {
    return await apiClient.getData('${AppConstants.Contact_Centers_URI}');
  }

  Future<Response> verifyPhone(String phone, String otp) async {
    return await apiClient.postData(AppConstants.VERIFY_PHONE_URI, {"phone": phone, "otp": otp});
  }
  Future<Response> addComments(String incidence_id,String text) async {
    return await apiClient.postData(AppConstants.Comment_URL, {"incident": incidence_id,"text": text});
  }

  // for  user token
  Future<bool> saveUserToken(String token) async {
    apiClient.token = token;
    apiClient.updateHeader(
      token, null, sharedPreferences.getString(AppConstants.LANGUAGE_CODE),
      Get.find<SplashController>().module != null ? Get.find<SplashController>().module.id : null,
    );
    return await sharedPreferences.setString(AppConstants.TOKEN, token);
  }

  String getUserToken() {
    return sharedPreferences.getString(AppConstants.TOKEN) ?? "";
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
}
