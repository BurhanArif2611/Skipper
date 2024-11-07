
import 'package:flutter/material.dart';
import 'package:get/get.dart';


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
