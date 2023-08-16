import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sixam_mart/data/model/response/incidence_list_model.dart';

import '../data/api/api_checker.dart';
import '../data/model/response/news_category_model.dart';
import '../data/model/response/news_list_model.dart';
import '../data/model/response/response_model.dart';
import '../data/model/response/sos_contact_model.dart';
import '../data/model/response/survey_detail_model.dart';
import '../data/model/response/survey_list_model.dart';
import '../data/repository/auth_repo.dart';
import '../view/base/custom_loader.dart';
import 'package:sixam_mart/helper/network_info.dart';

class HomeController extends GetxController implements GetxService {
  final AuthRepo authRepo;

  HomeController({@required this.authRepo}) {
    _notification = authRepo.isNotificationActive();
  }

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  bool _notification = true;

  IncidenceListModel _incidenceListModel;

  IncidenceListModel get incidenceListModel => _incidenceListModel;

  NewsListModel _newsListModel;

  NewsListModel get newsListModel => _newsListModel;

  SurveyDetailModel _surveyDetailModel;

  SurveyDetailModel get surveyDetailModel => _surveyDetailModel;

  NewsCategoryModel _newsCategoryListModel;

  NewsCategoryModel get newsCategoryListModel => _newsCategoryListModel;

  SurveyListModel _surveyListModel;

  SurveyListModel get surveyListModel => _surveyListModel;

  SOSContactModel _sosContactListModel;

  SOSContactModel get sosContactListModel => _sosContactListModel;

  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  int _selectedCategoryIndex = 0;

  int get selectedCategoryIndex => _selectedCategoryIndex;

  int _selectedOptionIndex = 0;

  int get selectedOptionIndex => _selectedOptionIndex;

  XFile _pickedFile;
  Uint8List _rawFile;

  XFile get pickedFile => _pickedFile;

  Uint8List get rawFile => _rawFile;

  List<Uint8List> _raw_arrayList = [];

  List get raw_arrayList => _raw_arrayList;

  void changeSelectIndex(int index) {
    _selectedIndex = index;
    update();
  }

  void changeCategorySelectIndex(int index) {
    _selectedCategoryIndex = index;
    update();
  }

  void changeOptionSelectIndex(int index) {
    _selectedOptionIndex = index;
    update();
  }

  Future<void> getIncidenceList() async {
    _isLoading = true;

    Response response = await authRepo.getIncidents();
    if (response.statusCode == 200) {
      _incidenceListModel = IncidenceListModel.fromJson(response.body);

      update();
    } else {
      ApiChecker.checkApi(response);
    }

    _isLoading = false;
  }

  Future<void> getNewsList() async {
    _isLoading = true;

    Response response = await authRepo.getNewsList();
    if (response.statusCode == 200) {
      _newsListModel = NewsListModel.fromJson(response.body);

      update();
    } else {
      ApiChecker.checkApi(response);
    }

    _isLoading = false;
  }

  Future<void> getCategoryList() async {
    Response response = await authRepo.getCategoryList();
    if (response.statusCode == 200) {
      _newsCategoryListModel = NewsCategoryModel.fromJson(response.body);

      update();
    } else {
      ApiChecker.checkApi(response);
    }
  }

  Future<void> getSurveyList() async {
    Response response = await authRepo.getSurveyList();
    if (response.statusCode == 200) {
      _surveyListModel = SurveyListModel.fromJson(response.body);

      update();
    } else {
      ApiChecker.checkApi(response);
    }
  }

  Future<void> getSurveysDetail(String id) async {
    _isLoading = true;

    Response response = await authRepo.getSurveyDetail(/*id*/
        "64afb5cbdc66ae6bcda502a3");
    if (response.statusCode == 200) {
      _surveyDetailModel = SurveyDetailModel.fromJson(response.body);

      update();
    } else {
      ApiChecker.checkApi(response);
    }

    _isLoading = false;
  }

  Future<void> getSOSContactList() async {
    _isLoading = true;

    Response response = await authRepo.getSOSContactList();
    if (response.statusCode == 200) {
      _sosContactListModel = SOSContactModel.fromJson(response.body);

      update();
    } else {
      ApiChecker.checkApi(response);
    }

    _isLoading = false;
  }

  Future<Response> addSOSContact(
      String name, String relation, String phone) async {
    _isLoading = true;
    update();
    // Get.dialog(CustomLoader(), barrierDismissible: false);
    Response response = await authRepo.addSOSContact(
        name: name, relation: relation, phone: phone);
    // ResponseModel responseModel;

    if (response.statusCode == 200) {
      /*  authRepo.saveUserToken(response.body['data']['token']['accessToken']);
      await authRepo.updateToken();

      responseModel = ResponseModel(true,response.body['data']['token']['accessToken']);
     */
      //  Get.back();
    } else {
      //   Get.back();
      //  responseModel = ResponseModel(false, response.statusText);
    }
    _isLoading = false;
    update();
    return response;
  }

  void pickImage() async {
    _pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (_pickedFile != null) {
      _pickedFile = await NetworkInfo.compressImage(_pickedFile);
      _rawFile = await _pickedFile.readAsBytes();
      print("pickImage" + _pickedFile.path);
      print("pickImage" + _rawFile.toString());
      _raw_arrayList.add(_rawFile);
    }
    update();
  }
  void pickCameraImage() async {
    _pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
    if (_pickedFile != null) {
      _pickedFile = await NetworkInfo.compressImage(_pickedFile);
      _rawFile = await _pickedFile.readAsBytes();
      print("pickImage" + _pickedFile.path);
      print("pickImage" + _rawFile.toString());
      _raw_arrayList.add(_rawFile);
    }
    update();
  }

  void removeSelectedImage(int Index)  {
    try {
      _raw_arrayList.removeAt(Index);
      print(">>>>>>>${_raw_arrayList.length.toString()}");
      update();
    } catch (e) {
      print(">>>>>>>${e.toString()}");
    }
  }
}
