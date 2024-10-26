
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sixam_mart/util/app_constants.dart';

import '../data/api/api_checker.dart';
import '../data/model/request_body/create_team.dart';
import '../data/model/response/commentlist_model.dart';
import '../data/model/response/featured_matches.dart';
import '../data/model/response/league_list.dart';
import '../data/model/response/matchList/match_team_list_model.dart';
import '../data/model/response/matchList/matches.dart';
import '../data/model/response/matchlist.dart';
import '../data/model/response/my_contest_list/my_contest_list_model.dart';
import '../data/model/response/player.dart';
import '../data/model/response/user_detail_model.dart';
import '../data/repository/home_repo.dart';
import '../view/base/custom_loader.dart';
import '../view/base/custom_snackbar.dart';
import '.././data/model/response/my_contest_list/my_contest_data.dart';


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

  List<Player> _batsMenPlayersList = [];

  List<Player> get batsMenPlayersList => _batsMenPlayersList;

  List<Player> _bowlMenPlayersList = [];

  List<Player> get bowlMenPlayersList => _bowlMenPlayersList;
  List<Player> _keepMenPlayersList = [];

  List<Player> get keepMenPlayersList => _keepMenPlayersList;
  List<Player> _allRoundMenPlayersList = [];

  List<Player> get allRoundMenPlayersList => _allRoundMenPlayersList;

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

  MatchTeamList _matchTeamList;

  MatchTeamList get matchTeamList => _matchTeamList;
  List<MyContestData> _completedList=[];
  List<MyContestData> get completedList => _completedList;

  List<MyContestData> _pendingList=[];
  List<MyContestData> get pendingList => _pendingList;

  List<MyContestData> _liveList=[];
  List<MyContestData> get liveList => _liveList;

  MyContestList _myContestList;

  MyContestList get myContestList => _myContestList;

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

  String _selectedTeamIDForJoinContest;

  String get selectedTeamIDForJoinContest => _selectedTeamIDForJoinContest;

  int _selectedTeamMemberIndex = 0;

  int get selectedTeamMemberIndex => _selectedTeamMemberIndex;

  void changeTeamMemberSelectIndex(int index) {
    _selectedTeamMemberIndex = index;
    update();
  }

  void selectTeam(String id) {
    try {
      _selectedTeamIDForJoinContest = id;
      print("id>>>${id.toString()}");
      update();
    } catch (e) {
      print("selectTeam>>>${e.toString()}");
    }
  }

  Future<void> getMatchesList() async {
    _isLoading = true;
    Response response = await homeRepo.getMatchList();
    if (response.statusCode == 200) {
      _matchlist = Matchlist.fromJson(response.body);
    } else {
      ApiChecker.checkApi(response);
    }
    _isLoading = false;
    update();
  }

  Future<Response> getSquadlList(
      String tournamentkey, String teamkey, String matchKey,Matches matchID) async {
    _playersList = [];
    _isLoading = true;

    Response response =
        await homeRepo.getSquadlList(tournamentkey, teamkey, matchKey);

    if (response.statusCode == 200) {
      if (response.body != null && response.body['data']['matchId'] != null) {
        if (response.body['data']['squad'] != null) {
          /* for (int i = 0;
              i <
                  response
                      .body['data']['tournament_team']['player_keys'].length;
              i++) {
            Player player = Player.fromJson(response.body['data']
                    ['tournament_team']['players']
                [response.body['data']['tournament_team']['player_keys'][i]]);
            _playersList.add(player);
          }*/

          for (int i = 0; i < matchID.squad.a.playingXi.length; i++) {
            if (response.body['data']['squad']
                        [response.body['data']['team'][0]['key']]['players']
                    [matchID.squad.a.playingXi[i]] !=
                null) {
              Player player = Player.fromJson(response.body['data']['squad']
                      [response.body['data']['team'][0]['key']]['players']
                  [matchID.squad.a.playingXi[i]]);
              _playersList.add(player);
            }
          }
          for (int i = 0; i < matchID.squad.b.playingXi.length; i++) {
            if (response.body['data']['squad']
                        [response.body['data']['team'][1]['key']]['players']
                    [matchID.squad.b.playingXi[i]] !=
                null) {
              Player player = Player.fromJson(response.body['data']['squad']
                      [response.body['data']['team'][1]['key']]['players']
                  [matchID.squad.b.playingXi[i]]);
              _playersList.add(player);
            }
          }


          if(_playersList.length>0){
            _batsMenPlayersList= _playersList.where((player) {
              return player.skills.length==1 && player.skills.contains("bat");
            }).toList();

            _bowlMenPlayersList= _playersList.where((player) {
              return player.skills.length==1 && player.skills.contains("bowl");
            }).toList();

            _keepMenPlayersList= _playersList.where((player) {
              return player.skills.length>0 && player.skills.contains("keep");
            }).toList();


            _allRoundMenPlayersList= _playersList.where((player) {
              return player.skills.length>1 && !player.skills.contains("keep");
            }).toList();
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
    _leagueList = null;

    Response response = await homeRepo.getleagueList();

    if (response.statusCode == 200) {
      _leagueList = LeagueList.fromJson(response.body);

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

  Future<void> getTeamList(String matchId) async {
    _matchTeamList = null;
    _isLoading = true;
    Response response = await homeRepo.getTeamList(
        matchId, _userDetailModel != null ? _userDetailModel.id : "", "");
    if (response.statusCode == 200) {
      _matchTeamList = MatchTeamList.fromJson(response.body);
      update();
    } else {
      ApiChecker.checkApi(response);
    }
    _isLoading = false;
  }

  Future<void> getMyContestList(String matchId) async {
    _myContestList = null;
    _isLoading = true;
    debugPrint("matchId>>>${matchId}");
    debugPrint(
        "_userDetailModel>>>>>${_userDetailModel != null ? _userDetailModel.id : ""}");
    Response response = await homeRepo.getMyContestList(
        matchId, _userDetailModel != null ? _userDetailModel.id : "");
    if (response.statusCode == 200) {
      _myContestList = MyContestList.fromJson(response.body);
      update();
    } else {
      ApiChecker.checkApi(response);
    }
    _isLoading = false;
  }
  Future<void> getMyMatchesList(String matchId) async {

    _isLoading = true;
    Response response = await homeRepo.getMyContestList(
        matchId, _userDetailModel != null ? _userDetailModel.id : "");
    if (response.statusCode == 200) {
      MyContestList _myContestList = MyContestList.fromJson(response.body);
      _completedList = _myContestList.data.where((item) => item.status.contains('complete')).toList();
      _pendingList = _myContestList.data.where((item) => item.status.contains('Pending')).toList();
      _liveList = _myContestList.data.where((item) => item.status.contains('Live')).toList();


    } else {
      ApiChecker.checkApi(response);
    }
    _isLoading = false;
    update();
  }

  Future<void> joinTeam(String matchId, String leageID) async {
    _isLoading = true;
    Response response = await homeRepo.joinContestTeam(
        leageID,
        _userDetailModel != null ? _userDetailModel.id : "",
        _selectedTeamIDForJoinContest != null &&
                _selectedTeamIDForJoinContest != ""
            ? _selectedTeamIDForJoinContest
            : "");
    if (response.statusCode == 200) {
      showCustomSnackBar(
          response.body['metadata']['message'] != null
              ? response.body['metadata']['message']
              : "",
          isError: false);
      Get.back();
      getMyContestList(matchId);
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
      _userName = prefs.getString(AppConstants.EmailID).toString();

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
  int countPlayersWithSkill(String skill) {
    return _selectedPlayersList.where((player) => player.skills.contains(skill)).length;
  }

  Future<void> addPlayersInMyTeam(Player player) async {
    bool check = false;


    if (_selectedPlayersList.length > 0) {
      for (int i = 0; i < _selectedPlayersList.length; i++) {
        if (_selectedPlayersList[i] == player) {
          _selectedPlayersList.removeAt(i);
          check = true;
          break;
        }else  if(player.skills.length==1 && !player.skills.contains("keep") && countPlayersWithSkill("keep")>=2) {
          showCustomSnackBar("2 Keepers is already added in your team.",isError:true);
          check = true;
          break;
        }else if(player.skills.length>=1 && player.skills.contains("bowl") && countPlayersWithSkill("bowl")>=5) {
          showCustomSnackBar("5 Bowler is already added in your team.",isError:true);
          check = true;
          break;
        }else if(player.skills.length>=1 && player.skills.contains("bat") && countPlayersWithSkill("bat")>=6) {
          showCustomSnackBar("5 Bats men is already added in your team.",isError:true);
          check = true;
          break;
        }/*else if(player.skills.length>1 && !player.skills.contains("keep") && countPlayersWithSkill("bat")>=3) {
          showCustomSnackBar("3 All rounders is already added in your team.",isError:true);
          check = true;
          break;
        }*/
      }
    }
    if (!check) {
      _selectedPlayersList.add(player);
    }
    update();
  }

  Future<List<Player>> finalPlayerList() async {
    _finalPlayersList = [];
    if (_selectedPlayersList != null && _selectedPlayersList.length > 0) {
      int Index;
      for (int i = 0; i < _selectedPlayersList.length; i++) {
        if (captainId == _selectedPlayersList[i].key) {
          Index = i;
          _finalPlayersList.add(_selectedPlayersList[i]);
          break;
        }
      }
      for (int j = 0; j < _selectedPlayersList.length; j++) {
        if (j != Index) {
          _finalPlayersList.add(_selectedPlayersList[j]);
        }
      }
    }
    update();
    return _finalPlayersList != null && _finalPlayersList.length >= 11
        ? _finalPlayersList
        : null;
  }

  void clearData() {
    try {
      _playersList = [];
      _selectedPlayersList = [];
      _finalPlayersList = [];
      _captainId = "";
      _vCaptainId = "";
      _batsMenPlayersList = [];
      _bowlMenPlayersList = [];
      _keepMenPlayersList = [];
      _allRoundMenPlayersList = [];
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

  Future<Response> createTeam(CreateTeamRequest teamCreate) async {
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
      getTeamList(teamCreate.request.matchId);
      Get.back();
    } else {
      Get.back();
    }
    _isLoading = false;

    update();

    return response;
  }
}
