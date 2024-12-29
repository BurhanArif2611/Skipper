import 'dart:async';
import 'dart:ffi';
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
import '../model/body/team_create.dart';
import '../model/request_body/create_team.dart';

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


  bool isNotificationActive() {
    return sharedPreferences.getBool(AppConstants.NOTIFICATION) ?? true;
  }


  Future<Response> getMatchList() async {
    //return await apiClient.getMatchData("/tournament/v1/fixture?tournamentkey=a-rz--cricket--icc--ctt-KLAd--2024-amCD");
   // return await apiClient.getMatchData("/tournament/v1/featuredmatches?tournamentkey=a-rz--cricket--icc--ctt-KLAd--2024-amCD");
    return await apiClient.getMatchData("/tournament/v1/featured");
  }
  Future<Response> getFeaturedMatchList() async {
   // return await apiClient.getMatchData("/tournament/v1/featured");
   // return await apiClient.getMatchData("/v1/associate/featuredtournament?page=1");
    return await apiClient.getMatchData("/tournament/v1/featured");
  }
  Future<Response> getBannerList() async {
    return await apiClient.getMatchData("/v5/bannerget");
  }

  Future<Response> getSquadlList(String tournamentkey,String teamkey,String matchKey) async {
   // return await apiClient.getMatchData("/tournament/v1/squadlist?tournamentkey=$tournamentkey&teamkey=$teamkey}");
    debugPrint("getSquadlList>>>${matchKey} }");
    Map<String, String> _header;
    _header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'mathchid': matchKey,

    };

    return await apiClient.getMatchData("/tournament/v1/squadlist",headers:_header);
  }

  Future<Response> getleagueList(String matchKey) async {
    Map<String, String> _header;
    _header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
       'mathchid': matchKey,

    };
    return await apiClient.getMatchData("/v4/leaguelist",headers:_header);
  }

  Future<Response> getUserDetails(String userName) async {
    return await apiClient.getData("/users/$userName");
  }


  Future<Response> createTeam(CreateTeamRequest signUpBody) async {
    return await apiClient.postMatchData(AppConstants.CreateTeam_URI, signUpBody.toJson());
  }

  Future<Response> getTeamList(String matchId,String userid,String teamid) async {
    Map<String, String> _mainHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'matchId': matchId,
      'userid': userid,
      'teamid': teamid,
      /*,
        'Authorization': ' ${token!=null?'Bearer ' +token:'Basic REVNTzpERU1PMTIz'}',*/
    };


    return await apiClient.getTeamListData(AppConstants.teamList, _mainHeaders);
  }
  Future<Response> getMyContestList(String matchId,String userid) async {
    Map<String, String> _mainHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'mathchid': matchId,
      'user_id': userid,

      /*,
        'Authorization': ' ${token!=null?'Bearer ' +token:'Basic REVNTzpERU1PMTIz'}',*/
    };


    return await apiClient.getTeamListData(AppConstants.teamjoinList, _mainHeaders);
  }
  Future<Response> getMyContestListData(String matchId,String userid) async {
    Map<String, String> _mainHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'mathchid': matchId,
      'user_id': userid,
    };
    return await apiClient.getTeamListData(AppConstants.MyContestList, _mainHeaders);
  }
  Future<Response> getMatchLeaderboard(String leagueid,String userid) async {
    Map<String, String> _mainHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'leagueid': leagueid,
      'user_id': userid,

      /*,
        'Authorization': ' ${token!=null?'Bearer ' +token:'Basic REVNTzpERU1PMTIz'}',*/
    };


    return await apiClient.getTeamListData(AppConstants.MATCH_leaderboard, _mainHeaders);
  }
  Future<Response> joinContestTeam(String leagueid,String userid,String teamid) async {
    Map<String, String> _mainHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'leagueid': leagueid,
      'user_id': userid,
      'teamid': teamid,
      /*,
        'Authorization': ' ${token!=null?'Bearer ' +token:'Basic REVNTzpERU1PMTIz'}',*/
    };



    return await apiClient.postJoinTeamData(AppConstants.teamjoin, _mainHeaders);
  }
}
