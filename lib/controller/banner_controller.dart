
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sixam_mart/data/api/api_checker.dart';
import 'package:sixam_mart/data/model/response/banner_model.dart';
import 'package:sixam_mart/data/model/response/branch.dart';
import 'package:sixam_mart/data/model/response/branch_model.dart';
import 'package:sixam_mart/data/model/response/store_model.dart';
import 'package:sixam_mart/data/model/response/store_model.dart';
import 'package:sixam_mart/data/repository/banner_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/util/app_constants.dart';





class BannerController extends GetxController implements GetxService {
  final BannerRepo bannerRepo;
  BannerController({@required this.bannerRepo});
  int Module_id=0;
  List<String> _bannerImageList;
  List<String> _featuredBannerList;
  List<dynamic> _bannerDataList;
  //List<Store> _branchStoreList;
  Store _branchStoreList;
  List<dynamic> _featuredBannerDataList;
  int _currentIndex = 0;
  //List<Store> get branchStoreList => _branchStoreList;
  Store get branchStoreList => _branchStoreList;
  int get _Module_id => Module_id;
  List<String> get bannerImageList => _bannerImageList;
  List<String> get featuredBannerList => _featuredBannerList;
  List<dynamic> get bannerDataList => _bannerDataList;
  List<dynamic> get featuredBannerDataList => _featuredBannerDataList;
  int get currentIndex => _currentIndex;
  SharedPreferences sharedPreferences;

  Future<void> getFeaturedBanner() async {
    Response response = await bannerRepo.getFeaturedBannerList();
    if (response.statusCode == 200) {
      _featuredBannerList = [];
      _featuredBannerDataList = [];
      BannerModel _bannerModel = BannerModel.fromJson(response.body);
      _bannerModel.campaigns.forEach((campaign) {
        _featuredBannerList.add(campaign.image);
        _featuredBannerDataList.add(campaign);
      });
      _bannerModel.banners.forEach((banner) {
        _featuredBannerList.add(banner.image);
        if(banner.item != null) {
          _featuredBannerDataList.add(banner.item);
        }else {
          _featuredBannerDataList.add(banner.store);
        }
      });
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<void> getBannerList(bool reload) async {
    if(_bannerImageList == null || reload) {
      _bannerImageList = null;
      Response response = await bannerRepo.getBannerList();
      if (response.statusCode == 200) {
        _bannerImageList = [];
        _bannerDataList = [];
        BannerModel _bannerModel = BannerModel.fromJson(response.body);
        _bannerModel.campaigns.forEach((campaign) {
          _bannerImageList.add(campaign.image);
          _bannerDataList.add(campaign);
        });
        _bannerModel.banners.forEach((banner) {
          _bannerImageList.add(banner.image);
          if(banner.item != null) {
            _bannerDataList.add(banner.item);
          }else {
            _bannerDataList.add(banner.store);
          }
        });
      } else {
        ApiChecker.checkApi(response);
      }
      update();
    }
  }

  Future<void> getBranchList(bool reload) async {
    if(_branchStoreList == null || reload) {
      Response response = await bannerRepo.getBranchList();
      if (response.statusCode == 200) {
      //  _branchStoreList=[];
        /*response.body.forEach((store)  {

          Store branch=Store.fromJson(store);
          _branchStoreList.add(branch);
        });*/
        _branchStoreList = Store.fromJson(response.body);
        // Module_id=_branchStoreList.moduleId;
        AppConstants.ModelID=branchStoreList.moduleId;
        print("getBranchList>>123>>"+_branchStoreList.moduleId.toString());

       // print("getBranchList>>123>>"+_branchStoreList.toString());
      //  response.body.forEach((store) => print("getBranchList>123123>>"+store.toString()));
      } else {
        ApiChecker.checkApi(response);
      }
      update();
    }
  }

  void setCurrentIndex(int index, bool notify) {
    _currentIndex = index;
    if(notify) {
      update();
    }
  }
}
