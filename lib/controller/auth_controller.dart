import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:aws_s3_upload/aws_s3_upload.dart';
import 'package:flutter/services.dart';
import 'package:get/get_connect/http/src/_http/_html/_file_decoder_html.dart';
import 'package:image_compression_flutter/image_compression_flutter.dart';
import 'package:image_picker/image_picker.dart';
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
import '../data/model/response/regions_response.dart';
import '../data/model/response/survey_list_model.dart';
import '../helper/network_info.dart';
import '../util/app_constants.dart';
import '../view/base/custom_loader.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;

  AuthController({@required this.authRepo}) {
    _notification = authRepo.isNotificationActive();
  }

  bool _isLoading = false;
  bool _notification = true;
  bool _acceptTerms = true;

  bool get isLoading => _isLoading;

  bool get notification => _notification;

  bool get acceptTerms => _acceptTerms;

  bool _forUser = true;

  bool get forUser => _forUser;
  File _file;

  File get file => _file;


  XFile _pickedFile;
  Uint8List _rawFile;

  XFile get pickedFile => _pickedFile;

  Uint8List get rawFile => _rawFile;

  String _uploadedURL = "";

  String get uploadedURL => _uploadedURL;
  SurveyListModel _surveyListModel;
  SurveyListModel get surveyListModel => _surveyListModel;

  RegionsResponse _regionsListModel;
  RegionsResponse get regionsListModel => _regionsListModel;


  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  int _selectedQuestionIndex = 0;

  int get selectedQuestionIndex => _selectedQuestionIndex;

  void changeSelectIndex(int index) {
    _selectedIndex = index;
    update();
  }
  void changeLogin(bool check) {
    try {
      _forUser = check;
      print("obje_forUserct ${_forUser}");

      authRepo.saveUserRole(check);

      update();
    } catch (e) {}
  }

  void clearData() {
    try {
      _uploadedURL = "";
      _rawFile = null;
      _pickedFile = null;
      _isLoading=false;
      update();
    } catch (e) {}
  }

  Future<Response> registration(SignUpBody signUpBody) async {
    _isLoading = true;
    update();
    Get.dialog(CustomLoader(), barrierDismissible: false);
    clearUserNumberAndPassword();
    Response response = await authRepo.registration(signUpBody);
    ResponseModel responseModel;
    if (response.statusCode == 200) {
      /* if (!Get.find<SplashController>().configModel.customerVerification) {
        authRepo.saveUserToken(response.body["token"]);
        await authRepo.updateToken();
      }*/
      // responseModel = ResponseModel(true, response.body);
      clearData();
      Get.back();
    } else {
      Get.back();
      responseModel = ResponseModel(
          false,
          response.body["message"] != null
              ? response.body["message"].toString()
              : response.statusText);
    }
    _isLoading = false;

    update();

    return response;
  }

  void clearVerificationCode() {
    try {
      _verificationCode = null;
      // update();
    } catch (e) {}
  }

  Future<ResponseModel> login(String phone, String password) async {
    _isLoading = true;
    update();
    Get.dialog(CustomLoader(), barrierDismissible: false);
    Response response = await authRepo.login(phone: phone, password: password);
    ResponseModel responseModel;
    if (response.statusCode == 200) {
      if (Get.find<SplashController>().configModel.customerVerification &&
          response.body['is_phone_verified'] == 0) {
      } else {
        authRepo.saveUserToken(response.body['token']);
        await authRepo.updateToken();
      }
      responseModel = ResponseModel(true,
          '${response.body['is_phone_verified']}${response.body['token']}');
      Get.back();
    } else {
      Get.back();
      responseModel = ResponseModel(false, response.statusText);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<bool> asyncTestFileUpload(File file, String name, String email,
      String phone, String region, String address) async {
    _isLoading=true;

    bool responseCheck = false;
    Map<String, String> headers = {"Accept": "Accept application/json","content-type": "multipart/form-data"};

    // Uint8List bytes = await fileToBytes(file);
    var postUri = Uri.parse(
        "https://admin-dashboard.partilespatriotes.org/api/members/store");

    Http.MultipartRequest request = new Http.MultipartRequest("POST", postUri);
    request.fields["name"] = name;
    request.fields["email"] = email;
    request.fields["phone"] = phone;
    request.fields["region"] = region;
    request.fields["address"] = address;
    request.headers.addAll(headers);
    Http.MultipartFile multipartFile = await Http.MultipartFile.fromPath(
        'profile', file.path /*,contentType: new MediaType('image', 'jpeg')*/);

    request.files.add(multipartFile);
    request.send().then((response) async {
      _isLoading=false;
      print("responseString>>>>>>><<>>>>>${response.statusCode.toString()}");
      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      Map map = jsonDecode(responseString) as Map<String, dynamic>;
      print("responseString>>>>>>>>>>>${responseString.toString()}");
      if (response.statusCode == 200){
        print("Uploaded!");
        responseCheck=true;
        showCustomSnackBar(map["message"].toString(),isError: false);
        Get.offNamed(RouteHelper.getPaymentRoute());
      }
      else {
        _isLoading=false;
        showCustomSnackBar(map["message"].toString(),isError: true);
      }
    });
    _isLoading=false;
    update();
    return responseCheck;
  }

  Future<Response> checkUserMobileNumber(String phone) async {
    _isLoading = true;
    update();
    Get.dialog(CustomLoader(), barrierDismissible: false);
    Response response = await authRepo.checkMobileNumber(phone: phone);
    //   ResponseModel responseModel;
    // print("responseModel>>"+response.toString());
    if (response.statusCode == 200) {
      Get.back();
    } else {
      Get.back();
    }
    _isLoading = false;
    update();
    return response;
  }

  Future<void> loginWithSocialMedia(SocialLogInBody socialLogInBody) async {
    _isLoading = true;
    update();
    Response response =
        await authRepo.loginWithSocialMedia(socialLogInBody.email);
    if (response.statusCode == 200) {
      String _token = response.body['token'];
      if (_token != null && _token.isNotEmpty) {
        if (Get.find<SplashController>().configModel.customerVerification &&
            response.body['is_phone_verified'] == 0) {
          Get.toNamed(RouteHelper.getVerificationRoute(
              socialLogInBody.email, _token, RouteHelper.signUp, ''));
        } else {
          authRepo.saveUserToken(response.body['token']);
          await authRepo.updateToken();
          Get.toNamed(RouteHelper.getAccessLocationRoute('sign-in'));
        }
      } else {
        Get.toNamed(RouteHelper.getForgotPassRoute(true, socialLogInBody, ""));
      }
    } else {
      showCustomSnackBar(response.statusText);
    }
    _isLoading = false;
    update();
  }

  Future<void> registerWithSocialMedia(SocialLogInBody socialLogInBody) async {
    _isLoading = true;
    update();
    Response response = await authRepo.registerWithSocialMedia(socialLogInBody);
    if (response.statusCode == 200) {
      String _token = response.body['token'];
      if (Get.find<SplashController>().configModel.customerVerification &&
          response.body['is_phone_verified'] == 0) {
        Get.toNamed(RouteHelper.getVerificationRoute(
            socialLogInBody.phone, _token, RouteHelper.signUp, ''));
      } else {
        authRepo.saveUserToken(response.body['token']);
        await authRepo.updateToken();
        Get.toNamed(RouteHelper.getAccessLocationRoute('sign-in'));
      }
    } else {
      showCustomSnackBar(response.statusText);
    }
    _isLoading = false;
    update();
  }

  Future<Response> forgetPassword(String email) async {
    _isLoading = true;
    update();
    Response response = await authRepo.forgetPassword(email);

    /* ResponseModel responseModel;
    if (response.statusCode == 200) {
      responseModel = ResponseModel(true, response.body["message"]);
    } else {
      responseModel = ResponseModel(false, response.statusText);
    }*/
    _isLoading = false;
    update();
    return response;
  }

  Future<void> updateToken() async {
    await authRepo.updateToken();
  }

  Future<ResponseModel> verifyToken(String email) async {
    _isLoading = true;
    update();
    Response response = await authRepo.verifyToken(email, _verificationCode);
    ResponseModel responseModel;
    if (response.statusCode == 200) {
      responseModel = ResponseModel(true, response.body["message"]);
    } else {
      responseModel = ResponseModel(false, response.statusText);
    }
    _isLoading = false;
    update();
    return responseModel;
  }
  Future<ResponseModel> getPollingSurveyToken() async {
    _isLoading = true;
    update();
    Response response = await authRepo.pollingSurvey();
    ResponseModel responseModel;
    if (response.statusCode == 200) {
      _surveyListModel = SurveyListModel.fromJson(response.body);
      responseModel = ResponseModel(true, response.body["message"]);
    } else {
      responseModel = ResponseModel(false, response.statusText);
    }
    _isLoading = false;
    update();
    return responseModel;
  }
  Future<ResponseModel> getRegions() async {
    _isLoading = true;
    update();
    Response response = await authRepo.regions();
    ResponseModel responseModel;
    if (response.statusCode == 200) {
      _regionsListModel = RegionsResponse.fromJson(response.body);
      responseModel = ResponseModel(true, response.body["message"]);
    } else {
      responseModel = ResponseModel(false, response.statusText);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<Response> pollingSurveyResultStore(String serveyId,String answer, int Index) async {
    _isLoading = true;
    update();
    Response response = await authRepo.pollingSurveyResultStore(serveyId,answer);

    if (response.statusCode == 200) {
      if(_surveyListModel!=null && _surveyListModel.data!=null && _surveyListModel.data.length>0 ){
        Data data=new Data(id:_surveyListModel.data[Index].id,question:_surveyListModel.data[Index].question,options:_surveyListModel.data[Index].options,status:_surveyListModel.data[Index].status,createdAt:_surveyListModel.data[Index].createdAt,updatedAt:_surveyListModel.data[Index].updatedAt,attempt:true);
        _surveyListModel.data[Index]=data;
      }
    }
    _isLoading = false;
    update();
    return response;
  }

  Future<ResponseModel> resetPassword(String resetToken, String number,
      String password, String confirmPassword) async {
    _isLoading = true;
    update();
    Response response = await authRepo.resetPassword(
        resetToken, number, password, confirmPassword);
    ResponseModel responseModel;
    if (response.statusCode == 200) {
      responseModel = ResponseModel(true, response.body["message"]);
    } else {
      responseModel = ResponseModel(false, response.statusText);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> checkEmail(String email) async {
    _isLoading = true;
    update();
    Response response = await authRepo.checkEmail(email);
    ResponseModel responseModel;
    if (response.statusCode == 200) {
      responseModel = ResponseModel(true, response.body["token"]);
    } else {
      responseModel = ResponseModel(false, response.statusText);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> verifyEmail(String email, String token) async {
    _isLoading = true;
    update();
    Response response = await authRepo.verifyEmail(email, _verificationCode);
    ResponseModel responseModel;
    if (response.statusCode == 200) {
      authRepo.saveUserToken(token);
      await authRepo.updateToken();
      responseModel = ResponseModel(true, response.body["message"]);
    } else {
      responseModel = ResponseModel(false, response.statusText);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> verifyPhone(String phone, String token) async {
    _isLoading = true;
    update();
    Response response = await authRepo.verifyPhone(phone, _verificationCode);
    ResponseModel responseModel;
    if (response.statusCode == 200) {
      try {
        if (token != '') {
          authRepo.saveUserToken(token);
        } else {
          if (response.body["token"] != null) {
            authRepo.saveUserToken(response.body["token"]);
          }
        }
      } catch (e) {}
      await authRepo.updateToken();
      responseModel = ResponseModel(true, response.body["message"]);
    } else {
      responseModel = ResponseModel(false, response.statusText);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<void> updateZone() async {
    Response response = await authRepo.updateZone();
    if (response.statusCode == 200) {
      // Nothing to do
    } else {
      ApiChecker.checkApi(response);
    }
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
    return authRepo.isLoggedIn();
  }

  bool clearSharedData() {
    Get.find<SplashController>().setModule(null);
    AppConstants.StoreID = AppConstants.ParantStoreID;
    return authRepo.clearSharedData();
  }

  bool clearSharedAddress() {
    return authRepo.clearSharedAddress();
  }

  void saveUserNumberAndPassword(
      String number, String password, String countryCode) {
    authRepo.saveUserNumberAndPassword(number, password, countryCode);
  }

  String getUserNumber() {
    return authRepo.getUserNumber() ?? "";
  }

  String getUserCountryCode() {
    return authRepo.getUserCountryCode() ?? "";
  }

  String getUserPassword() {
    return authRepo.getUserPassword() ?? "";
  }

  Future<bool> clearUserNumberAndPassword() async {
    return authRepo.clearUserNumberAndPassword();
  }

  String getUserToken() {
    return authRepo.getUserToken();
  }

  bool setNotificationActive(bool isActive) {
    _notification = isActive;
    authRepo.setNotificationActive(isActive);
    update();
    return _notification;
  }

  void pickImage() async {
    Random random = Random();
    _pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (_pickedFile != null) {
      _pickedFile =
          await NetworkInfo.compressImage(_pickedFile).then((value) async {
        _rawFile = await _pickedFile.readAsBytes();
        print("pickImage" + _pickedFile.path);
        print("pickImage" + _rawFile.toString());
        _file = new File(_pickedFile.path);
      });
    }
    update();
  }

  void pickCameraImage() async {
    Random random = Random();
    _pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
    if (_pickedFile != null) {
      _pickedFile =
          await NetworkInfo.compressImage(_pickedFile).then((value) async {
        _rawFile = await _pickedFile.readAsBytes();
        print("pickImage>>>>" + _pickedFile.path.toString());
        print("pickImage" + _rawFile.toString());
        _file = new File(_pickedFile.path);
      });

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

  Future<Response> submitSurveyResult(String surveyID) async {
    _isLoading = true;
    Answers newsSubmitBody =
    Answers(question: surveyID, options: selectedOptionIdList[0].options);

    Response response = await authRepo.submitSurveyResultu(newsSubmitBody);
    ResponseModel responseModel;
    print("response>>>${response.statusCode}");
    if (response.statusCode == 200) {

    }
    _isLoading = false;
    update();
    return response;
  }
  void changeQuestionTabSelectIndex(int index) {
    _selectedQuestionIndex = index;
    update();
  }
}
