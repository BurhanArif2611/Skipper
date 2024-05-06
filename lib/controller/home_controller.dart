import 'dart:ffi';
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
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sixam_mart/data/model/response/incidence_list_model.dart';
import 'package:sixam_mart/util/app_constants.dart';

import '../data/api/api_checker.dart';
import '../data/model/body/news_submit_body.dart';
import '../data/model/body/report_incidence_body.dart';
import '../data/model/body/team_create.dart';
import '../data/model/response/commentlist_model.dart';
import '../data/model/response/contact_center_model.dart';
import '../data/model/response/country_list_model.dart';
import '../data/model/response/featured_matches.dart';
import '../data/model/response/incidence_category_model.dart';
import '../data/model/response/incidence_detail_response.dart';
import '../data/model/response/latetsnews_model.dart';
import '../data/model/response/league_list.dart';
import '../data/model/response/matchlist.dart';
import '../data/model/response/news_category_model.dart';
import '../data/model/response/news_list_model.dart';
import '../data/model/response/player.dart';
import '../data/model/response/resource_center_model.dart';
import '../data/model/response/response_model.dart';
import '../data/model/response/sos_contact_model.dart';
import '../data/model/response/survey_detail_model.dart';
import '../data/model/response/survey_list_model.dart';
import '../data/model/response/user_detail_model.dart';
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

  bool _notification = true;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  List<String> _uploadedVideoURL = [];

  List<String> get uploadedVideoURL => _uploadedVideoURL;

  List<Player> _playersList = [];

  List<Player> get playersList => _playersList;

  List<Player> _selectedPlayersList = [];

  List<Player> get selectedPlayersList => _selectedPlayersList;

  CommentListModel _commentList;

  CommentListModel get commentList => _commentList;

  UserDetailModel _userDetailModel;

  UserDetailModel get userDetailModel => _userDetailModel;

  Matchlist _matchlist;

  Matchlist get matchlist => _matchlist;

  featuredMatches _featuredMatchesList;

  featuredMatches get featuredMatchesList => _featuredMatchesList;

  String _userName;

  String get userName => _userName;

  String _captainId;

  String get captainId => _captainId;

  String _vCaptainId;

  String get vCaptainId => _vCaptainId;

  List<Player> _finalPlayersList = [];

  List<Player> get finalPlayersList => _finalPlayersList;

  LeagueList _leagueList;

  LeagueList get leagueList => _leagueList;

  Future<void> getMatchesList() async {
    _isLoading = true;
    Response response = await homeRepo.getMatchList();
    if (response.statusCode == 200) {
      _matchlist = Matchlist.fromJson(response.body);

      update();
    } else {
      ApiChecker.checkApi(response);
    }
    _isLoading = false;
  }

  Future<Response> getSquadlList() async {
    _playersList = [];
    _isLoading = true;

    Response response = await homeRepo.getSquadlList("sadasd", "sdfsdfdsf");

    if (response.statusCode == 200) {
      if (response.body['data']['tournament_team'] != null) {
        if (response.body['data']['tournament_team']['player_keys'] != null) {
          for (int i = 0;
              i <
                  response
                      .body['data']['tournament_team']['player_keys'].length;
              i++) {
            Player player = Player.fromJson(response.body['data']
                    ['tournament_team']['players']
                [response.body['data']['tournament_team']['player_keys'][i]]);
            _playersList.add(player);
          }
        }
      }
      print("_playersList>>>${_playersList.length.toString()}");
    }

    _isLoading = false;
    update();
    return response;
  }

  Future<Response> getLeagueList() async {
    _playersList = [];
    _isLoading = true;

    Response response = await homeRepo.getleagueList();

    if (response.statusCode == 200) {
      _leagueList=LeagueList.fromJson(response.body);

      print("_playersList>>>${_playersList.length.toString()}");
    }

    _isLoading = false;
    update();
    return response;
  }

  Future<void> getFeaturedMatchesList() async {
    _isLoading = true;
    Response response = await homeRepo.getFeaturedMatchList();
    if (response.statusCode == 200) {
      _featuredMatchesList = featuredMatches.fromJson(response.body);

      update();
    } else {
      ApiChecker.checkApi(response);
    }
    _isLoading = false;
  }

  Future<void> getUserData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      print("isLogin>>>>" + prefs.getString(AppConstants.UserName).toString());
      _userName = prefs.getString(AppConstants.UserName).toString();

      if (_userName != null && _userName != "") {
        getUserDetails(_userName);
      }
      update();
    } catch (e) {}
  }

  Future<void> getUserDetails(String userName) async {
    _isLoading = true;
    Response response = await homeRepo.getUserDetails(userName);
    if (response.statusCode == 200) {
      _userDetailModel = UserDetailModel.fromJson(response.body);

      update();
    } else {
      ApiChecker.checkApi(response);
    }
    _isLoading = false;
  }

  Future<void> addPlayersInMyTeam(Player player) async {
    bool check = false;
    if (_selectedPlayersList.length > 0) {
      for (int i = 0; i < _selectedPlayersList.length; i++) {
        if (_selectedPlayersList[i] == player) {
          _selectedPlayersList.removeAt(i);
          check = true;
          break;
        }
      }
    }
    if (!check) {
      _selectedPlayersList.add(player);
    }
    update();
  }

  Future<List<Player>> finalPlayerList() async {
    if (_selectedPlayersList != null && _selectedPlayersList.length > 0) {
      int Index;
      for (int i = 0; i < _selectedPlayersList.length; i++) {
        if (captainId == _selectedPlayersList[i].key) {
          Index = i;
          finalPlayersList.add(_selectedPlayersList[i]);
          break;
        }
      }
      for (int j = 0; j < _selectedPlayersList.length; j++) {
        if (j != Index) {
          finalPlayersList.add(_selectedPlayersList[j]);
        }
      }
    }
    update();
    return finalPlayersList != null && finalPlayersList.length >= 11
        ? finalPlayersList
        : null;
  }

  void clearData() {
    try {
      _playersList = [];
      _selectedPlayersList = [];
      _finalPlayersList = [];
      _captainId = "";
      _vCaptainId = "";
      update();
    } catch (e) {}
  }

  void addCaptain(String id) {
    _captainId = id;
    update();
  }

  void addVCaptain(String id) {
    _vCaptainId = id;
    update();
  }

  Future<Response> createTeam(TeamCreate teamCreate) async {
    _isLoading = true;
    update();
    Get.dialog(CustomLoader(), barrierDismissible: false);

    Response response = await homeRepo.createTeam(teamCreate);

    if (response.statusCode == 200) {
      /* if (!Get.find<SplashController>().configModel.customerVerification) {
        authRepo.saveUserToken(response.body["token"]);
        await authRepo.updateToken();
      }*/
      // responseModel = ResponseModel(true, response.body);

      Get.back();
    } else {
      Get.back();
    }
    _isLoading = false;

    update();

    return response;
  }
}
