import 'package:sixam_mart/controller/cart_controller.dart';
import 'package:sixam_mart/controller/splash_controller.dart';
import 'package:sixam_mart/data/api/api_checker.dart';
import 'package:sixam_mart/data/model/body/review_body.dart';
import 'package:sixam_mart/data/model/response/cart_model.dart';
import 'package:sixam_mart/data/model/response/order_details_model.dart';
import 'package:sixam_mart/data/model/response/item_model.dart';
import 'package:sixam_mart/data/model/response/response_model.dart';
import 'package:sixam_mart/data/repository/item_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/helper/date_converter.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/view/base/custom_snackbar.dart';
import 'package:sixam_mart/view/base/item_bottom_sheet.dart';
import 'package:sixam_mart/view/screens/dashboard/dashboard_screen.dart';

class DashboardController extends GetxController implements GetxService {
  DashboardController();
  PageController _pageController = PageController(initialPage: 0);

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;


  PageController get pageController => _pageController;



  void changeIndex( int index) {
    _currentIndex = index;
    _pageController.jumpToPage(index);
    update();
  }
















}
