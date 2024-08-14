import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:aws_s3_upload/aws_s3_upload.dart';
import 'package:flutter/services.dart';
import 'package:get/get_connect/http/src/_http/_html/_file_decoder_html.dart';
import 'package:image_compression_flutter/image_compression_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sixam_mart/controller/splash_controller.dart';
import 'package:sixam_mart/data/api/api_checker.dart';
import 'package:sixam_mart/data/model/body/signup_body.dart';
import 'package:sixam_mart/data/model/body/social_log_in_body.dart';
import 'package:sixam_mart/data/model/response/response_model.dart';
import 'package:sixam_mart/data/repository/auth_repo.dart';
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/view/base/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as Http;

import '../data/model/body/news_submit_body.dart';
import '../data/model/response/region_response_model.dart';
import '../data/model/response/regions_response.dart';
import '../data/model/response/survey_list_model.dart';
import '../data/repository/kyc_repo.dart';
import '../helper/network_info.dart';
import '../util/app_constants.dart';
import '../view/base/custom_loader.dart';

class KycController extends GetxController implements GetxService {
  final KycRepo kycRepo;

  KycController({@required this.kycRepo}) {
    _notification = kycRepo.isNotificationActive();
  }

  SharedPreferences sharedPreferences;
  bool _notification = true;
  bool _acceptTerms = true;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  bool _isButtonLoading = false;

  bool get isButtonLoading => _isButtonLoading;

  bool get notification => _notification;

  bool get acceptTerms => _acceptTerms;

  bool _forUser = true;

  bool get forUser => _forUser;
  File _file;

  File get file => _file;

  XFile _idFrontPickedFile;
  Uint8List _idFrontRawFile;

  XFile get idFrontPickedFile => _idFrontPickedFile;

  Uint8List get idFrontRawFile => _idFrontRawFile;

  XFile _idBackPickedFile;
  Uint8List _idBackRawFile;

  XFile get idBackPickedFile => _idBackPickedFile;
  Uint8List get idBackRawFile => _idBackRawFile;

  XFile _idSSNPickedFile;
  Uint8List _idSSNRawFile;

  XFile get idSSNPickedFile => _idSSNPickedFile;
  Uint8List get idSSNRawFile => _idSSNRawFile;

  String _uploadedURL = "";

  String get uploadedURL => _uploadedURL;
  SurveyListModel _surveyListModel;

  SurveyListModel get surveyListModel => _surveyListModel;

  RegionsResponse _regionsListModel;

  RegionsResponse get regionsListModel => _regionsListModel;

  List<RegionResponseModel> _regionsResponseListMode = AppConstants.region;

  List<RegionResponseModel> get regionsResponseListModel =>
      _regionsResponseListMode;

  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  int _selectedQuestionIndex = 0;

  int get selectedQuestionIndex => _selectedQuestionIndex;

  String _getDeviceID = "";

  String get getDeviceID => _getDeviceID;

  int _selectedTeamMemberIndex = 0;

  int get selectedTeamMemberIndex => _selectedTeamMemberIndex;

  void changeSelectIndex(int index) {
    _selectedIndex = index;
    update();
  }

  void changeTeamMemberSelectIndex(int index) {
    _selectedTeamMemberIndex = index;
    update();
  }

  void changeDeviceID(String number) {
    try {
      _getDeviceID = number;
      update();
    } catch (e) {}
  }

  void changeLogin(bool check) {
    try {
      _forUser = check;
      print("obje_forUserct ${_forUser}");

      kycRepo.saveUserRole(check);

      update();
    } catch (e) {}
  }

  void clearData() {
    try {
      _uploadedURL = "";
      _idFrontRawFile = null;
      _idFrontPickedFile = null;
      _isLoading = false;
      update();
    } catch (e) {}
  }

  void clearVerificationCode() {
    try {
      _verificationCode = null;
      // update();
    } catch (e) {}
  }

  void showLoader() {
    try {
      _isButtonLoading = true;
      update();
    } catch (e) {}
  }

  String _verificationCode = '';

  String get verificationCode => _verificationCode;

  void updateVerificationCode(String query) {
    _verificationCode = query;
    update();
  }

  bool _isActiveRememberMe = false;

  bool get isActiveRememberMe => _isActiveRememberMe;

  void toggleTerms() {
    _acceptTerms = !_acceptTerms;
    update();
  }

  void toggleRememberMe() {
    _isActiveRememberMe = !_isActiveRememberMe;
    update();
  }

  bool isLoggedIn() {
    return kycRepo.isLoggedIn();
  }

  bool clearSharedData() {
    Get.find<SplashController>().setModule(null);
    AppConstants.StoreID = AppConstants.ParantStoreID;
    return kycRepo.clearSharedData();
  }

  bool clearSharedAddress() {
    return kycRepo.clearSharedAddress();
  }

  void saveUserNumberAndPassword(
      String number, String password, String countryCode) {
    kycRepo.saveUserNumberAndPassword(number, password, countryCode);
  }

  String getUserNumber() {
    return kycRepo.getUserNumber() ?? "";
  }

  String getUserCountryCode() {
    return kycRepo.getUserCountryCode() ?? "";
  }

  String getUserPassword() {
    return kycRepo.getUserPassword() ?? "";
  }

  Future<bool> clearUserNumberAndPassword() async {
    return kycRepo.clearUserNumberAndPassword();
  }

  /* String getUserToken() {
    return kycRepo.getUserToken();
  }*/

  String getLANGUAGE_CODE() {
    return kycRepo.getLANGUAGE_CODE();
  }

  bool setNotificationActive(bool isActive) {
    _notification = isActive;
    kycRepo.setNotificationActive(isActive);
    update();
    return _notification;
  }

  void pickImage(String check) async {
    if (check == "id_front") {
      _idFrontPickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (_idFrontPickedFile != null) {
        _idFrontPickedFile = await NetworkInfo.compressImage(_idFrontPickedFile)
            .then((value) async {
          _idFrontRawFile = await _idFrontPickedFile.readAsBytes();
          print("pickImage" + _idFrontPickedFile.path);
          print("pickImage" + _idFrontRawFile.toString());
          _file = new File(_idFrontPickedFile.path);
        });
      }
    }else if (check == "id_back") {
      _idBackPickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (_idBackPickedFile != null) {
        _idBackPickedFile = await NetworkInfo.compressImage(_idBackPickedFile)
            .then((value) async {
          _idBackRawFile = await _idBackPickedFile.readAsBytes();
          print("pickImage" + _idBackPickedFile.path);
          print("pickImage" + _idBackRawFile.toString());
          _file = new File(_idBackPickedFile.path);
        });
      }
    }else if (check == "ssn_front") {
      _idSSNPickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (_idSSNPickedFile != null) {
        _idSSNPickedFile = await NetworkInfo.compressImage(_idSSNPickedFile)
            .then((value) async {
          _idSSNRawFile = await _idSSNPickedFile.readAsBytes();
          print("pickImage" + _idSSNPickedFile.path);
          print("pickImage" + _idSSNRawFile.toString());
          _file = new File(_idSSNPickedFile.path);
        });
      }
    }
    update();
  }

  void pickCameraImage(String check) async {
    if (check == "id_front") {
      _idFrontPickedFile =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (_idFrontPickedFile != null) {
        _idFrontPickedFile = await NetworkInfo.compressImage(_idFrontPickedFile)
            .then((value) async {
          _idFrontRawFile = await _idFrontPickedFile.readAsBytes();
          print("pickImage>>>>" + _idFrontPickedFile.path.toString());
          print("pickImage" + _idFrontRawFile.toString());
          _file = new File(_idFrontPickedFile.path);
        });
      }
      //print("dlfjdljfdjfkdjf>>${response.statusCode}");
    }else if (check == "id_back") {
      _idBackPickedFile =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (_idBackPickedFile != null) {
        _idBackPickedFile = await NetworkInfo.compressImage(_idBackPickedFile)
            .then((value) async {
          _idBackRawFile = await _idBackPickedFile.readAsBytes();
          print("pickImage>>>>" + _idBackPickedFile.path.toString());
          print("pickImage" + _idBackRawFile.toString());
          _file = new File(_idBackPickedFile.path);
        });
      }
      //print("dlfjdljfdjfkdjf>>${response.statusCode}");
    }else if (check == "ssn_front") {
      _idSSNPickedFile =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (_idSSNPickedFile != null) {
        _idSSNPickedFile = await NetworkInfo.compressImage(_idSSNPickedFile)
            .then((value) async {
          _idSSNRawFile = await _idSSNPickedFile.readAsBytes();
          print("pickImage>>>>" + _idSSNPickedFile.path.toString());
          print("pickImage" + _idSSNRawFile.toString());
          _file = new File(_idSSNPickedFile.path);
        });
      }
      //print("dlfjdljfdjfkdjf>>${response.statusCode}");
    }
    update();
  }

  Future<String> _uploadImage(File file, int number, String filename,
      {String extension = 'jpg'}) async {
    String result;
    print("file>>>>>>${file.path}");
    print("number>>>>>>${number}");
    if (result == null) {
      try {
        print("fileName>>>>>>${file.path}");
        result = await AwsS3.uploadFile(
          accessKey: AppConstants.ACCESS_KEY,
          secretKey: AppConstants.SECRET_KEY,
          file: file,
          bucket: AppConstants.BUCKET,
          region: AppConstants.REGION,
          metadata: {"test": "test"},
          filename: filename,
        ).then((uri) {
          print("inner >>>>> >${uri.toString()}");
          _uploadedURL = (uri);
          print("object>>>>>>${_uploadedURL.length.toString()}");
        });
        print("object>>>>>>${result.toString()}");
      } on PlatformException catch (e) {
        print("Failed <><><>:'${e.message}'.");
      }
    }

    return result;
  }

  List<Answers> _selectedOptionIdList = [];

  List<Answers> get selectedOptionIdList => _selectedOptionIdList;

  void changeOptionSelectIndex(
      String QuestionsID, String OptionsID, int index) {
    print("QuestionsID>>>${QuestionsID}");
    print("OptionsID>>>${OptionsID}");
    Answers answers = Answers(question: QuestionsID, options: OptionsID);
    bool check = true;
    if (_selectedOptionIdList.length > 0) {
      for (int i = 0; i < _selectedOptionIdList.length; i++) {
        if (_selectedOptionIdList[i].question == QuestionsID) {
          _selectedOptionIdList[i] = answers;
          check = false;
          break;
        }
      }
    }
    if (check) {
      _selectedOptionIdList.add(answers);
    }
    update();
  }

  void changeQuestionTabSelectIndex(int index) {
    _selectedQuestionIndex = index;
    update();
  }

  void removeIdFrontImage() {
    try {
      _idFrontPickedFile = null;
      _idFrontRawFile = null;

      update();
    } catch (e) {
      print(">>>>>>>${e.toString()}");
    }
  }
}
