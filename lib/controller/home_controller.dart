import 'dart:io';
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
import '../data/model/body/news_submit_body.dart';
import '../data/model/body/report_incidence_body.dart';
import '../data/model/response/commentlist_model.dart';
import '../data/model/response/contact_center_model.dart';
import '../data/model/response/country_list_model.dart';
import '../data/model/response/incidence_category_model.dart';
import '../data/model/response/incidence_detail_response.dart';
import '../data/model/response/latetsnews_model.dart';
import '../data/model/response/news_category_model.dart';
import '../data/model/response/news_list_model.dart';
import '../data/model/response/resource_center_model.dart';
import '../data/model/response/response_model.dart';
import '../data/model/response/sos_contact_model.dart';
import '../data/model/response/survey_detail_model.dart';
import '../data/model/response/survey_list_model.dart';
import '../data/repository/auth_repo.dart';
import '../data/repository/home_repo.dart';
import '../view/base/custom_loader.dart';
import 'package:sixam_mart/helper/network_info.dart';

/*import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:file_picker/file_picker.dart';*/

class HomeController extends GetxController implements GetxService {
  final HomeRepo homeRepo;

  HomeController({@required this.homeRepo}) {
    _notification = homeRepo.isNotificationActive();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _checkAudioRecording = false;
  bool get checkAudioRecording => _checkAudioRecording;

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

  bool _notification = true;

  IncidenceListModel _incidenceListModel;

  IncidenceListModel get incidenceListModel => _incidenceListModel;

  LatestNewsModel _latestNewsModel;

  LatestNewsModel get latestNewsModel => _latestNewsModel;

  NewsListModel _newsListModel;

  NewsListModel get newsListModel => _newsListModel;

  SurveyDetailModel _surveyDetailModel;

  SurveyDetailModel get surveyDetailModel => _surveyDetailModel;

  NewsCategoryModel _newsCategoryListModel;

  NewsCategoryModel get newsCategoryListModel => _newsCategoryListModel;

  SurveyListModel _surveyListModel;

  SurveyListModel get surveyListModel => _surveyListModel;

  IncidenceDetailResponse _incidenceDetailResponse;

  IncidenceDetailResponse get incidenceDetailResponse =>
      _incidenceDetailResponse;

  SOSContactModel _sosContactListModel;

  SOSContactModel get sosContactListModel => _sosContactListModel;

  ResourceCenterModel _resourceCenterListModel;

  ResourceCenterModel get resourceCenterListModel => _resourceCenterListModel;

  ContactCenterModel _contactCenterListModel;

  ContactCenterModel get contactCenterListModel => _contactCenterListModel;

  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  int _selectedCategoryIndex = 0;

  int get selectedCategoryIndex => _selectedCategoryIndex;



  XFile _pickedFile;
  Uint8List _rawFile;

  XFile get pickedFile => _pickedFile;

  Uint8List get rawFile => _rawFile;

  List<Uint8List> _raw_arrayList = [];

  List get raw_arrayList => _raw_arrayList;

  List<CountryListModel> _countryList;

  List<CountryListModel> get countryList => _countryList;

  List<IncidenceCategoryModel> _incidencecategorylist;

  List<IncidenceCategoryModel> get incidencecategorylist =>
      _incidencecategorylist;

  List<String> _uploadedURL = [];
  List<String> get uploadedURL => _uploadedURL;

  List<String> _uploadedAudioURL = [];
  List<String> get uploadedAudioURL => _uploadedAudioURL;

  CommentListModel _commentList;

  CommentListModel get commentList => _commentList;

  CommentListModel _securitycommentList;

  CommentListModel get securitycommentList => _securitycommentList;

  void changeSelectIndex(int index) {
    _selectedIndex = index;
    update();
  }
  void changeAudioRecording(bool check) {
    _checkAudioRecording = check;
    update();
  }

  void changeCategorySelectIndex(int index,String cat_id) {
    _selectedCategoryIndex = index;
    getNewsWithCategoryIDList(cat_id);
    update();
  }



  void clearAllData() {
    try {
      _incidenceDetailResponse = null;
      _commentList = null;
      _securitycommentList = null;
      _raw_arrayList = [];
      _rawFile = null;
      _uploadedURL = [];
      _state_name = "";
      _lga_name = "";
      _ward_name = "";
      update();
    } catch (e) {}
  }

  Future<void> getIncidenceList() async {
    _isLoading = true;

    Response response = await homeRepo.getIncidents();
    if (response.statusCode == 200) {
      _incidenceListModel = IncidenceListModel.fromJson(response.body);

      update();
    } else {
      ApiChecker.checkApi(response);
    }

    _isLoading = false;
  }
  Future<void> getLatestNewsList() async {
    _isLoading = true;

    Response response = await homeRepo.getLatestNews();
    if (response.statusCode == 200) {
      _latestNewsModel = LatestNewsModel.fromJson(response.body);

      update();
    } else {
      ApiChecker.checkApi(response);
    }

    _isLoading = false;
  }

  Future<void> getNewsList() async {
    _isLoading = true;

    Response response = await homeRepo.getNewsList();
    if (response.statusCode == 200) {
      _newsListModel = NewsListModel.fromJson(response.body);

      update();
    } else {
      ApiChecker.checkApi(response);
    }

    _isLoading = false;
  } Future<void> getNewsWithCategoryIDList(String id) async {
    _isLoading = true;

    Response response = await homeRepo.getNewsWithCategoryList(id);
    if (response.statusCode == 200) {
      _newsListModel = NewsListModel.fromJson(response.body);

      update();
    } else {
      ApiChecker.checkApi(response);
    }

    _isLoading = false;
  }

  Future<void> getCategoryList() async {
    Response response = await homeRepo.getCategoryList();
    if (response.statusCode == 200) {
      _newsCategoryListModel = NewsCategoryModel.fromJson(response.body);

      update();
    } else {
      ApiChecker.checkApi(response);
    }
  }

  Future<void> getStateList() async {
    Response response = await homeRepo.getStateList();
    _countryList = [];
    if (response.statusCode == 200) {
      response.body.forEach((notification) =>
          _countryList.add(CountryListModel.fromJson(notification)));

      print("_countryList>>>${_countryList.length}");
      update();
    } else {
      ApiChecker.checkApi(response);
    }
  }

  Future<void> getIncidenceCategoryList() async {
    Response response = await homeRepo.getIncidentTypesList();
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

  Future<void> getLgaList(String state_id) async {
    Response response = await homeRepo.getLgaList(state_id);
    _countryList = [];
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
    Response response = await homeRepo.getWardList(lag_id);
    _countryList = [];
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
    Response response = await homeRepo.getSurveyList();
    if (response.statusCode == 200) {
      _surveyListModel = SurveyListModel.fromJson(response.body);

      update();
    } else {
      ApiChecker.checkApi(response);
    }
  }

  Future<void> getIncidenceDetail(String incidence_id) async {
    Response response = await homeRepo.getIncidenceDetail(incidence_id);

    if (response.statusCode == 200) {
      _incidenceDetailResponse =
          IncidenceDetailResponse.fromJson(response.body);
      update();
    } else {
      ApiChecker.checkApi(response);
    }
  }

  Future<void> getCommentList(String incidence_id) async {
    Response response = await homeRepo.getCommentList(incidence_id);
    // _commentList=[];
    if (response.statusCode == 200) {
      _commentList = (CommentListModel.fromJson(response.body));
      // print("CommentListModel size>>${_commentList.length}");
      update();
    } else {
      ApiChecker.checkApi(response);
    }
  }

  Future<void> getSecurityOfficerCommentList(String incidence_id) async {
    Response response =
        await homeRepo.getSecurityOfficerCommentList(incidence_id);
    // _commentList=[];
    if (response.statusCode == 200) {
      _securitycommentList = (CommentListModel.fromJson(response.body));
      // print("CommentListModel size>>${_commentList.length}");
      update();
    } else {
      ApiChecker.checkApi(response);
    }
  }

  Future<Response> addIncidenceComment(
      String incidence_id, String comment_text) async {
    Response response = await homeRepo.addComments(incidence_id, comment_text);
    if (response.statusCode == 200) {
      getCommentList(incidence_id);
      update();
    } else {
      ApiChecker.checkApi(response);
    }
    return response;
  }

  Future<void> getSurveysDetail(String id) async {
    _isLoading = true;

    Response response =
        await homeRepo.getSurveyDetail(id /*"64afb5cbdc66ae6bcda502a3"*/);
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

    Response response = await homeRepo.getSOSContactList();
    if (response.statusCode == 200) {
      _sosContactListModel = SOSContactModel.fromJson(response.body);

      update();
    } else {
      ApiChecker.checkApi(response);
    }

    _isLoading = false;
  }

  Future<void> getResourceCenterList() async {
    _isLoading = true;

    Response response = await homeRepo.getResourceCenterList();
    if (response.statusCode == 200) {
      _resourceCenterListModel = ResourceCenterModel.fromJson(response.body);

      update();
    } else {
      ApiChecker.checkApi(response);
    }
    _isLoading = false;
    update();
  }

  Future<void> getContactCenterList() async {
    _isLoading = true;

    Response response = await homeRepo.getContactCenterList();
    if (response.statusCode == 200) {
      _contactCenterListModel = ContactCenterModel.fromJson(response.body);

      update();
    } else {
      ApiChecker.checkApi(response);
    }
    _isLoading = false;
    update();
  }

  Future<Response> addSOSContact(
      String name, String relation, String phone) async {
    _isLoading = true;
    update();
    // Get.dialog(CustomLoader(), barrierDismissible: false);
    Response response = await homeRepo.addSOSContact(
        name: name, relation: relation, phone: phone);
    // ResponseModel responseModel;

    if (response.statusCode == 200) {
      getSOSContactList();
      /*  homeRepo.saveUserToken(response.body['data']['token']['accessToken']);
      await homeRepo.updateToken();

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

  Future<Response> deleteSOSContact(String id) async {
    _isLoading = true;
    update();
    // Get.dialog(CustomLoader(), barrierDismissible: false);
    Response response = await homeRepo.deleteSOSContact(id: id);
    // ResponseModel responseModel;

    if (response.statusCode == 200) {
      getSOSContactList();
      /*  homeRepo.saveUserToken(response.body['data']['token']['accessToken']);
      await homeRepo.updateToken();

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
      //_pickedFile = await NetworkInfo.compressImage(_pickedFile);
      _rawFile = await _pickedFile.readAsBytes();
      print("pickImage" + _pickedFile.path);
      print("pickImage" + _rawFile.toString());
      _raw_arrayList.add(_rawFile);
      File file1 = new File(_pickedFile.path);
      uploadImage(file1, 101,"1692276470974.png");
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
    _pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
    if (_pickedFile != null) {
      //_pickedFile = await NetworkInfo.compressImage(_pickedFile);
      _rawFile = await _pickedFile.readAsBytes();
      print("pickImage>>>>" + _pickedFile.path.toString());
      print("pickImage" + _rawFile.toString());
      _raw_arrayList.add(_rawFile);
      File file1 = new File(_pickedFile.path);
      // homeRepo.sendFile(file1);
      uploadImage(file1, 101,"1692276470974.png");
      //print("dlfjdljfdjfkdjf>>${response.statusCode}");
    }
    update();
  }

  void removeSelectedImage(int Index) {
    try {
      _raw_arrayList.removeAt(Index);
      print(">>>>>>>${_raw_arrayList.length.toString()}");
      update();
    } catch (e) {
      print(">>>>>>>${e.toString()}");
    }
  }void removeSelectedAudioURL(int Index) {
    try {
      _uploadedAudioURL.removeAt(Index);
      print(">>>>>>>${_uploadedAudioURL.length.toString()}");
      update();
    } catch (e) {
      print(">>>>>>>${e.toString()}");
    }
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

  Future<Response> addReport(ReportIncidenceBody signUpBody) async {
    _isLoading = true;

    Response response = await homeRepo.addReport(signUpBody);
    ResponseModel responseModel;
    print("response>>>${response.statusCode}");
    if (response.statusCode == 200) {
      /* if (!Get.find<SplashController>().configModel.customerVerification) {
        homeRepo.saveUserToken(response.body["token"]);
        await homeRepo.updateToken();
      }*/
      // responseModel = ResponseModel(true, response.body);
    } else {
      /*  responseModel = ResponseModel(false, response.body["message"] != null
              ? response.body["message"].toString()
              : response.statusText);*/
    }
    _isLoading = false;
    update();
    return response;
  }

  Future<String> uploadImage(File file, int number,String file_name,
      {String extension = 'jpg'}) async {
    String result;
    print("file>>>>>>${file.path}");
    print("number>>>>>>${number}");
    if (result == null) {
      try {
        /*try {
          result = await awsS3.uploadFile;
        print("Result <> :'$result'.");
        } on PlatformException {
          print("Result <><> :'$result'.");
        }*/
        print("fileName>>>>>>${file.path}");
        result = await AwsS3.uploadFile(
          accessKey: "AKIAR6SRPD5YRLVOTAN4",
          secretKey: "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",
          file: file,
          bucket: "abujaeyemedia",
          region: "eu-west-1",
          metadata: {"test": "test"},
          filename:file_name ,
        ).then((uri) {
          print("inner >>>>> >${uri.toString()}");
          if(uri.toLowerCase().contains(".aac".toLowerCase())){
            _uploadedAudioURL.add(uri);
            print("object>>>_uploadedAudioURL>>>${_uploadedAudioURL.length.toString()}");
          }else {
            _uploadedURL.add(uri);
            print("object>>>>>>${_uploadedURL.length.toString()}");
          }
        });

        print("object>>>>>>${result.toString()}");
      } on PlatformException catch (e) {
        print("Failed <><><>:'${e.message}'.");
      }
      update();
    }

    return result;
  }

  List<Answers> _selectedOptionIdList = [];

  List<Answers> get selectedOptionIdList => _selectedOptionIdList;

  void changeOptionSelectIndex(
      String QuestionsID, String OptionsID, int index) {
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
    NewsSubmitBody newsSubmitBody=NewsSubmitBody(surveyId:surveyID,answers:selectedOptionIdList);


    Response response = await homeRepo.submitSurveyResultu(newsSubmitBody);
    ResponseModel responseModel;
    print("response>>>${response.statusCode}");
    if (response.statusCode == 200) {

    }
    _isLoading = false;
    update();
    return response;
  }
}
