import 'package:sixam_mart/data/api/api_client.dart';
import 'package:sixam_mart/util/app_constants.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  NotificationRepo({@required this.apiClient, @required this.sharedPreferences});

  Future<Response> getNotificationList(int offset,String userID) async {
    //return await apiClient.getData(AppConstants.NOTIFICATION_URI);
    return await apiClient.getMatchData('${AppConstants.NOTIFICATION_LIST}?user_id=$userID&offset=$offset&limit=10');

  }

  void saveSeenNotificationCount(int count) {
    sharedPreferences.setInt(AppConstants.NOTIFICATION_COUNT, count);
  }

  int getSeenNotificationCount() {
    return sharedPreferences.getInt(AppConstants.NOTIFICATION_COUNT);
  }

}
