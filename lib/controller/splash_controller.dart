import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sixam_mart/controller/auth_controller.dart';
import 'package:sixam_mart/controller/banner_controller.dart';
import 'package:sixam_mart/controller/cart_controller.dart';
import 'package:sixam_mart/controller/category_controller.dart';
import 'package:sixam_mart/controller/location_controller.dart';
import 'package:sixam_mart/controller/store_controller.dart';
import 'package:sixam_mart/data/api/api_checker.dart';
import 'package:sixam_mart/data/api/api_client.dart';
import 'package:sixam_mart/data/model/response/config_model.dart';
import 'package:sixam_mart/data/model/response/module_model.dart';
import 'package:sixam_mart/data/repository/splash_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/util/html_type.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/view/base/confirmation_dialog.dart';
import 'package:sixam_mart/view/base/custom_snackbar.dart';
import 'package:sixam_mart/view/screens/home/home_screen.dart';

import '../data/model/response/app_info_model.dart';
import '../data/model/response/block_geo_list.dart';
import '../data/model/response/store_model.dart';
import '../data/repository/auth_repo.dart';
import '../helper/route_helper.dart';
import '../util/app_constants.dart';
import '../view/base/common_dailog.dart';

class SplashController extends GetxController implements GetxService {
  final SplashRepo splashRepo;
 /* final AuthRepo authRepo;*/

  SplashController({@required this.splashRepo});

  ConfigModel _configModel;
  bool _firstTimeConnectionCheck = true;
  bool _hasConnection = true;
  ModuleModel _module;
  List<ModuleModel> _moduleList;
  int _moduleIndex = 0;
  Map<String, dynamic> _data = Map();
  String _htmlText;
  bool _isLoading = false;

  ConfigModel get configModel => _configModel;
  DateTime get currentTime => DateTime.now();
  bool get firstTimeConnectionCheck => _firstTimeConnectionCheck;
  bool get hasConnection => _hasConnection;
  ModuleModel get module => _module;
  int get moduleIndex => _moduleIndex;
  List<ModuleModel> get moduleList => _moduleList;
  String get htmlText => _htmlText;
  bool get isLoading => _isLoading;

  bool _isSecurityOfficer = false;
  bool get isSecurityOfficer => _isSecurityOfficer;

  AppInfoModel _appInfoModel ;
  AppInfoModel get appInfoModel => _appInfoModel;

  BlockGeoList _blockGeoList ;
  BlockGeoList get blockGeoList => _blockGeoList;

  bool _isWithinRadius = false;
  bool get isWithinRadius => _isWithinRadius;


  Future<bool> getConfigData() async {
    _hasConnection = true;
    _moduleIndex = 0;
    Response response = await splashRepo.getConfigData();
    bool _isSuccess = false;
    if(response.statusCode == 200) {
      _data = response.body;
      _configModel = ConfigModel.fromJson(response.body);
      if(_configModel.module != null) {
        setModule(_configModel.module);
      }else if(GetPlatform.isWeb) {
        setModule(splashRepo.getModule());
      }
      _isSuccess = true;
    }else {
      ApiChecker.checkApi(response);
      if(response.statusText == ApiClient.noInternetMessage) {
        _hasConnection = false;
      }
      _isSuccess = false;
    }
    update();
    return _isSuccess;
  }

  Future<bool> saveToken(String token) async {

    Response response = await splashRepo.saveToken(token);

    if(response.statusCode == 200) {

    }
    update();
    return true;
  }

  Future<void> initSharedData() async {
    if(!GetPlatform.isWeb) {
      _module = null;
      splashRepo.initSharedData();
    }else {
      _module = await splashRepo.initSharedData();
    }
    await setModule(_module, notify: false);
  }
  bool isSecuryOfficer() {
    _isSecurityOfficer=splashRepo.isSecuryOfficer();
    print("check it ${splashRepo.isSecuryOfficer()}");
    update();
    return splashRepo.isSecuryOfficer();


  }
  bool showIntro() {
    return splashRepo.showIntro();
  }

  void disableIntro() {
    splashRepo.disableIntro();
  }

  void setFirstTimeConnectionCheck(bool isChecked) {
    _firstTimeConnectionCheck = isChecked;
  }

  Future<void> setModule(ModuleModel module, {bool notify = true}) async {
    _module = module;
    splashRepo.setModule(module);
    if(module != null) {
      _configModel.moduleConfig.module = Module.fromJson(_data['module_config'][module.moduleType]);
    }
    if(notify) {
      update();
    }
  }
  Future<void> setModuleWithCallStoreAPI(ModuleModel module,int id, {bool notify = true}) async {

    _module = module;
    splashRepo.setModule(module);
    Get.find<StoreController>().getStoreDetails(Store(id: id),true);
    Get.find<StoreController>().getStoreItemList(id, 1, 'all', false);
    /*if(Get.find<CategoryController>().categoryList == null) {*/
    Get.find<CategoryController>().getCategoryList(true);
    /*}*/
    if(module != null) {
      _configModel.moduleConfig.module = Module.fromJson(_data['module_config'][module.moduleType]);
    }
    if(notify) {
      update();
    }
  }
  Module getModule(String moduleType) => Module.fromJson(_data['module_config'][moduleType]);

  Future<void> getModules() async {
    _moduleIndex = 0;
    Response response = await splashRepo.getModules();
    if (response.statusCode == 200) {
      _moduleList = [];
      response.body.forEach((storeCategory) => _moduleList.add(ModuleModel.fromJson(storeCategory)));
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void switchModule(int index, bool fromPhone) async {

    if(_module == null || _module.id != _moduleList[index].id) {
      bool _clearData = (Get.find<CartController>().cartList.length > 0
          && Get.find<CartController>().cartList[0].item.moduleId != _moduleList[index].id);
      bool _switch = _module != null && _module.id != _moduleList[index].id;
      if(_clearData || (_switch && !fromPhone)) {

        Get.dialog(ConfirmationDialog(
          icon: Images.warning, title: _clearData ? 'are_you_sure_to_reset'.tr : null,
          description: 'if_you_continue_without_another_store'.tr,
          onYesPressed: () async {
            Get.back();
            Get.find<CartController>().clearCartList();
            await Get.find<SplashController>().setModule(_moduleList[index]);

          },
        ));
      }else {
        await Get.find<SplashController>().setModule(_moduleList[index]);



      }
    }
  }

  void setModuleIndex(int index) {
    _moduleIndex = index;
    update();
  }
  void showLoader() {
    try {
      _isLoading = true;
      update();
    }catch(_){}
  }


  void removeModule() {
    setModule(null);
    Get.find<BannerController>().getFeaturedBanner();
    getModules();
    if(Get.find<AuthController>().isLoggedIn()) {
      Get.find<LocationController>().getAddressList();
    }
    Get.find<StoreController>().getFeaturedStoreList();
  }

  Future<void> getHtmlText(HtmlType htmlType) async {
    _htmlText = null;
    Response response = await splashRepo.getHtmlText(htmlType);
    if (response.statusCode == 200) {
      _htmlText = response.body;
      if(_htmlText != null && _htmlText.isNotEmpty) {
        _htmlText = _htmlText.replaceAll('href=', 'target="_blank" href=');
      }else {
        _htmlText = '';
      }
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<bool> subscribeMail(String email) async {
    _isLoading = true;
    bool _isSuccess = false;
    update();
    Response response = await splashRepo.subscribeEmail(email);
    if (response.statusCode == 200) {
      showCustomSnackBar('subscribed_successfully'.tr, isError: false);
      _isSuccess = true;
    }else {
      ApiChecker.checkApi(response);
    }
    _isLoading = false;
    update();
    return _isSuccess;
  }


  Future<AppInfoModel> getVersionInfo() async {
    _moduleIndex = 0;
    Response response = await splashRepo.getVersionInfo();
    if (response.statusCode == 200) {
      _appInfoModel=AppInfoModel.fromJson(response.body);
      } else {
      ApiChecker.checkApi(response);
    }
    update();
    return _appInfoModel;
  }
  Future<bool> getBlackGeoList(double latitude, double longitude) async {
    Response response = await splashRepo.getBlackGeoList();
    if (response.statusCode == 200) {
      _isLoading=false;
      _isWithinRadius = false;
      _blockGeoList=BlockGeoList.fromJson(response.body);
      if(_blockGeoList!=null){
        await getStateFromLatLong(latitude,longitude)
            .then((state) async {
          for (var location in _blockGeoList.data) {
           if(location.status) {
           //  debugPrint("state>>${location.statename}<><>${state}");
             if (location.statename.contains(findState(state))) {
               _isWithinRadius = true;
             }
           }
          }
            });
      }
      else {
        Get.offNamed(RouteHelper
            .getInitialRoute());
      }
      }
    else {
      _isLoading=false;
    }
    update();
    return _isWithinRadius;
  }
  Future<Position> determinePosition(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    // Check for location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        CommonDialog.confirm(context,
            "You have permanently denied location permissions. Please enable it in the app settings.",
            onPress: () async {
              await openAppSettings();
            });
        throw Exception('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      CommonDialog.confirm(context,
          "You have permanently denied location permissions. Please enable it in the app settings.",
          onPress: () async {
            await openAppSettings();
          });
      throw Exception('Location permissions are permanently denied.');
    }

    // Get the current position
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  String findState(String input) {
    input = input.toLowerCase();
    for (var entry in (AppConstants.state)) {
      if (entry["name"].toLowerCase() == input ||
          entry["abbreviation"].toLowerCase() == input) {
        return entry["name"];
      }
    }
    return "State not found";
  }

  Future<String> getStateFromLatLong(double latitude, double longitude) async {
    try {
      // Perform reverse geocoding
      List<Placemark> placemarks =
      await placemarkFromCoordinates(latitude, longitude);

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        debugPrint("place.administrativeArea>>${place.administrativeArea}");
        return place.administrativeArea ?? "";
      } else {
        return "";
      }
    } catch (e) {
      return "";
    }
  }
}
