import 'dart:convert';

import 'package:sixam_mart/data/api/api_checker.dart';
import 'package:sixam_mart/data/model/response/notification_model.dart';
import 'package:sixam_mart/data/repository/notification_repo.dart';
import 'package:sixam_mart/helper/date_converter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/model/response/order_model.dart';

class NotificationController extends GetxController implements GetxService {
  final NotificationRepo notificationRepo;
  NotificationController({@required this.notificationRepo});

  List<NotificationModel> _notificationList;
  List<NotificationModel> get notificationList => _notificationList;
  bool _hasNotification = false;

  bool get hasNotification => _hasNotification;
  int _offset=1;
  int get offset => _offset;

  Future<int> getNotificationList(int offset,bool reload) async {
    if (offset == 1) {
      _notificationList = null;
     // update();
    }
    if(_notificationList == null || reload && offset == 1) {
      Response response = await notificationRepo.getNotificationList(offset);
      if (response.statusCode == 200) {
        _notificationList = [];
       /* List<dynamic> list = response.body;
        print("response>>>>>"+response.body.toString());
        if(list.length>0) {*/
        try{
          _offset = int.parse(response.body['offset']);}
        catch(e){}
          response.body['products'].forEach((notification) =>
              _notificationList.add(NotificationModel.fromJson(notification)));
          _notificationList.sort((a, b) {
            return DateConverter.isoStringToLocalDate(a.updatedAt).compareTo(
                DateConverter.isoStringToLocalDate(b.updatedAt));
          });
          Iterable iterable = _notificationList.reversed;
          _notificationList = iterable.toList();
          _hasNotification =
              _notificationList.length != getSeenNotificationCount();
        /*}*/
      } else {
        ApiChecker.checkApi(response);
      }
      update();
    }
    else {
      Response response = await notificationRepo.getNotificationList(offset);
      if (response.statusCode == 200) {
        _offset=int.parse(response.body['offset']);
        response.body['products'].forEach((notification) => _notificationList.add(NotificationModel.fromJson(notification)));
        _notificationList.sort((a, b) {
          return DateConverter.isoStringToLocalDate(a.updatedAt).compareTo(DateConverter.isoStringToLocalDate(b.updatedAt));
        });
        Iterable iterable = _notificationList.reversed;
        _notificationList = iterable.toList();
        _hasNotification = _notificationList.length != getSeenNotificationCount();
      } else {
        ApiChecker.checkApi(response);
      }
      update();
    }
   // print("_notificationList>>>"+_notificationList.length.toString());
    return _notificationList.length;
  }

  void saveSeenNotificationCount(int count) {
    notificationRepo.saveSeenNotificationCount(count);
  }

  int getSeenNotificationCount() {
    return notificationRepo.getSeenNotificationCount();
  }

  void clearNotification() {
    _notificationList = null;
  }

}
