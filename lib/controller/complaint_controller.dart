import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:aws_s3_upload/aws_s3_upload.dart';
import 'package:aws_s3_upload/enum/acl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_compression_flutter/image_compression_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sixam_mart/data/model/response/incidence_list_model.dart';

import '../data/api/api_checker.dart';
import '../data/model/body/report_incidence_body.dart';
import '../data/model/response/complaint_list_model.dart';
import '../data/model/response/country_list_model.dart';
import '../data/model/response/incidence_category_model.dart';
import '../data/model/response/news_category_model.dart';
import '../data/model/response/news_list_model.dart';
import '../data/model/response/response_model.dart';
import '../data/model/response/sos_contact_model.dart';
import '../data/model/response/survey_detail_model.dart';
import '../data/model/response/survey_list_model.dart';
import '../data/repository/auth_repo.dart';
import '../data/repository/complaint_repo.dart';
import '../data/repository/store_repo.dart';
import '../util/app_constants.dart';
import '../view/base/custom_loader.dart';
import 'package:sixam_mart/helper/network_info.dart';

import '../view/base/custom_snackbar.dart';

/*import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:file_picker/file_picker.dart';*/

class ComplaintController extends GetxController implements GetxService {
/*  final AuthRepo authRepo;*/
  final ComplaintRepo storeRepo;

  ComplaintController({@required this.storeRepo});

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  String _state_id = "";

  String get state_id => _state_id;

  String _state_name = "";

  String get state_name => _state_name;

  String _lga_id = "";

  String get lga_id => _lga_id;

  String _lga_name = "";

  String get lga_name => _lga_name;

  String _ward_id = "";

  String get ward_id => _ward_id;

  String _ward_name = "";

  String get ward_name => _ward_name;

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

  List<CountryListModel> _countryList;

  List<CountryListModel> get countryList => _countryList;

  List<IncidenceCategoryModel> _incidencecategorylist;

  List<IncidenceCategoryModel> get incidencecategorylist =>
      _incidencecategorylist;

  ComplaintListModel _complaintlistarray;

  ComplaintListModel get complaintlistarray => _complaintlistarray;

  String _uploadedURL = "";

  String get uploadedURL => _uploadedURL;

  void clearAllData() {
    try {

      _rawFile = null;
      _uploadedURL = "";
      _state_name="";
      _lga_name="";
      _ward_name="";
      update();
    } catch (e) {}
  }

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

  Future<void> getIncidenceCategoryList() async {
    Response response = await storeRepo.getIncidentTypesList();
    _incidencecategorylist = [];
    if (response.statusCode == 200) {
      response.body.forEach((notification) => _incidencecategorylist
          .add(IncidenceCategoryModel.fromJson(notification)));

      print("_countryList>>>${_incidencecategorylist.length}");
      update();
    } else {
      ApiChecker.checkApi(response);
    }
  }

  Future<Response> deleteSOSContact(String id) async {
    _isLoading = true;
    update();
    Response response = await storeRepo.deleteComplaint(id: id);
    // ResponseModel responseModel;
    if (response.statusCode == 200) {
      showCustomSnackBar(response.body['message'].toString(), isError: false);
      getComplaintList();
    }
    _isLoading = false;
    update();
    return response;
  }

  Future<void> getComplaintList() async {
    Response response = await storeRepo.getComplaintList();

    if (response.statusCode == 200) {
      _complaintlistarray = ComplaintListModel.fromJson(response.body);

      update();
    } else {
      ApiChecker.checkApi(response);
    }
  }

  Future<Response> addCompliant(String complain, String category_id) async {
    _isLoading = true;

    Response response =
        await storeRepo.addComplain(complain, category_id, _uploadedURL);
    if (response.statusCode == 200) {
      getComplaintList();

      update();
    } else {
      ApiChecker.checkApi(response);
    }

    _isLoading = false;
    return response;
  }

/*
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

  Future<void> getStateList() async {
    Response response = await authRepo.getStateList();
    _countryList=[];
    if (response.statusCode == 200) {

      response.body.forEach((notification) =>
          _countryList.add(CountryListModel.fromJson(notification)));

      print("_countryList>>>${_countryList.length}");
      update();
    } else {
      ApiChecker.checkApi(response);
    }
  }




  Future<void> getLgaList(String state_id) async {
    Response response = await authRepo.getLgaList(state_id);
    _countryList=[];
    if (response.statusCode == 200) {

      response.body.forEach((notification) =>
          _countryList.add(CountryListModel.fromJson(notification)));

      print("_countryList>>>${_countryList.length}");
      update();
    } else {
      ApiChecker.checkApi(response);
    }
  }

  Future<void> getWardList(String lag_id) async {
    Response response = await authRepo.getWardList(lag_id);
    _countryList=[];
    if (response.statusCode == 200) {

      response.body.forEach((notification) =>
          _countryList.add(CountryListModel.fromJson(notification)));

      print("_countryList>>>${_countryList.length}");
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

    Response response = await authRepo.getSurveyDetail(*/ /*id*/ /*
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
      getSOSContactList();
      */ /*  authRepo.saveUserToken(response.body['data']['token']['accessToken']);
      await authRepo.updateToken();

      responseModel = ResponseModel(true,response.body['data']['token']['accessToken']);
     */ /*
      //  Get.back();
    } else {
      //   Get.back();
      //  responseModel = ResponseModel(false, response.statusText);
    }
    _isLoading = false;
    update();
    return response;
  }

  Future<Response> deleteSOSContact(String id) async {
    _isLoading = true;
    update();
    // Get.dialog(CustomLoader(), barrierDismissible: false);
    Response response = await authRepo.deleteSOSContact(id:id);
    // ResponseModel responseModel;

    if (response.statusCode == 200) {
      getSOSContactList();
      */ /*  authRepo.saveUserToken(response.body['data']['token']['accessToken']);
      await authRepo.updateToken();

      responseModel = ResponseModel(true,response.body['data']['token']['accessToken']);
     */ /*
      //  Get.back();
    } else {
      //   Get.back();
      //  responseModel = ResponseModel(false, response.statusText);
    }
    _isLoading = false;
    update();
    return response;
  }*/

  void pickImage() async {
    Random random = Random();
    _pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (_pickedFile != null) {
      _pickedFile =
          await NetworkInfo.compressImage(_pickedFile).then((value) async {
        _rawFile = await _pickedFile.readAsBytes();
        print("pickImage" + _pickedFile.path);
        print("pickImage" + _rawFile.toString());
        File file1 = new File(_pickedFile.path);
        _uploadImage(file1, 101,random.nextInt(1000).toString()+".png");
      });
    }
    update();
  }

  /*Future<void> uploadImage() async {
    // Select a file from the device
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      withData: false,
      // Ensure to get file stream for better performance
      withReadStream: true,
      allowedExtensions: ['jpg', 'png', 'gif'],
    );

    if (result == null) {
      safePrint('No file selected');
      return;
    }

    // Upload file with its filename as the key
    final platformFile = result.files.single;
    try {
      final result = await Amplify.Storage.uploadFile(
        localFile: AWSFile.fromStream(
          platformFile.readStream!,
          size: platformFile.size,
        ),
        key: platformFile.name,
        onProgress: (progress) {
          safePrint('Fraction completed: ${progress.fractionCompleted}');
        },
      ).result;
      safePrint('Successfully uploaded file: ${result.uploadedItem.key}');
    } on StorageException catch (e) {
      safePrint('Error uploading file: $e');
      rethrow;
    }
  }*/

  void pickCameraImage() async {
    Random random = Random();
    _pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
    if (_pickedFile != null) {
      _pickedFile =
          await NetworkInfo.compressImage(_pickedFile).then((value) async {
        _rawFile = await _pickedFile.readAsBytes();
        print("pickImage>>>>" + _pickedFile.path.toString());
        print("pickImage" + _rawFile.toString());
        File file1 = new File(_pickedFile.path);
        // authRepo.sendFile(file1);
        _uploadImage(file1, 101,random.nextInt(1000).toString()+".png");
      });

      //print("dlfjdljfdjfkdjf>>${response.statusCode}");
    }
    update();
  }

  void selectState(String state_id, String state_name) {
    try {
      _state_id = state_id;
      _state_name = state_name;
      print(">>>>>>>${_state_id}");
      update();
      Get.back();
      _countryList = [];
    } catch (e) {
      print(">>>>>>>${e.toString()}");
    }
  }

  void selectLga(String lga_id, String lga_name) {
    try {
      _lga_id = lga_id;
      _lga_name = lga_name;
      print(">>>>>>>${_lga_id}");
      print(">>>>>>>${_lga_name}");
      update();
      Get.back();
      _countryList = [];
    } catch (e) {
      print(">>>>>>>${e.toString()}");
    }
  }

  void selectWard(String ward_id, String ward_name) {
    try {
      _ward_id = ward_id;
      _ward_name = ward_name;
      print(">>>>>>>${_ward_id}");
      print(">>>>>>>${_ward_name}");
      update();
      Get.back();
      _countryList = [];
    } catch (e) {
      print(">>>>>>>${e.toString()}");
    }
  }

  /*Future<Response> addReport(ReportIncidenceBody signUpBody) async {
    _isLoading = true;

    Response response = await authRepo.addReport(signUpBody);
    ResponseModel responseModel;
    print("response>>>${response.statusCode}");
    if (response.statusCode == 200) {
      */ /* if (!Get.find<SplashController>().configModel.customerVerification) {
        authRepo.saveUserToken(response.body["token"]);
        await authRepo.updateToken();
      }*/ /*
      // responseModel = ResponseModel(true, response.body);

    } else {

      */ /*  responseModel = ResponseModel(false, response.body["message"] != null
              ? response.body["message"].toString()
              : response.statusText);*/ /*
    }
    _isLoading = false;
    update();
    return response;
  }*/

  Future<String> _uploadImage(File file, int number,String filename,
      {String extension = 'jpg'}) async {
    String result;
    print("file>>>>>>${file.path}");
    print("number>>>>>>${number}");
    if (result == null) {
      // generating file name
      /* String fileName =
          "$number$extension\_${DateTime.now().millisecondsSinceEpoch}.$extension";
      print("fileName>>>>>>${fileName}");*/

      /* AwsS3 awsS3 = AwsS3(
          awsFolderPath: "/",
          file: file,
          fileNameWithExt: fileName,
          poolId: "poolId",
          region: Regions.EU_WEST_1,
          bucketName: "abujaeyemedia");*/

      try {
        /*try {
          result = await awsS3.uploadFile;
        print("Result <> :'$result'.");
        } on PlatformException {
          print("Result <><> :'$result'.");
        }*/
        print("fileName>>>>>>${file.path}");
        result = await AwsS3.uploadFile(
          accessKey: AppConstants.ACCESS_KEY,
          secretKey:AppConstants.SECRET_KEY,
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
}
