import 'dart:convert';

import 'package:sixam_mart/controller/location_controller.dart';
import 'package:sixam_mart/controller/splash_controller.dart';
import 'package:sixam_mart/data/model/body/social_log_in_body.dart';
import 'package:sixam_mart/data/model/response/address_model.dart';
import 'package:sixam_mart/data/model/response/basic_campaign_model.dart';
import 'package:sixam_mart/data/model/response/order_model.dart';
import 'package:sixam_mart/data/model/response/item_model.dart';
import 'package:sixam_mart/data/model/response/parcel_category_model.dart';
import 'package:sixam_mart/data/model/response/store_model.dart';
import 'package:sixam_mart/view/screens/forget/forget_pass_screen.dart';

import 'package:sixam_mart/util/app_constants.dart';
import 'package:sixam_mart/util/html_type.dart';
import 'package:sixam_mart/view/base/image_viewer_screen.dart';
import 'package:sixam_mart/view/base/not_found.dart';

import 'package:sixam_mart/view/screens/auth/sign_in_screen.dart';
import 'package:sixam_mart/view/screens/auth/sign_up_screen.dart';

import 'package:sixam_mart/view/screens/dashboard/dashboard_screen.dart';
import 'package:sixam_mart/view/screens/forget/forget_pass_screen.dart';
import 'package:sixam_mart/view/screens/forget/new_pass_screen.dart';
import 'package:sixam_mart/view/screens/forget/verification_screen.dart';
import 'package:sixam_mart/view/screens/html/html_viewer_screen.dart';
/*import 'package:sixam_mart/view/screens/latestnews/news_detail_screen.dart';
import 'package:sixam_mart/view/screens/myprofile/myprofile_screen.dart';*/
import 'package:sixam_mart/view/screens/notification/notification_screen.dart';
import 'package:sixam_mart/view/screens/onboard/onboarding_screen.dart';
import 'package:sixam_mart/view/screens/profile/profile_screen.dart';
import 'package:sixam_mart/view/screens/profile/update_profile_screen.dart';
import 'package:sixam_mart/view/screens/refer_and_earn/refer_and_earn_screen.dart';
import 'package:sixam_mart/view/screens/splash/splash_screen.dart';
import 'package:sixam_mart/view/screens/support/support_screen.dart';
/*
import 'package:sixam_mart/view/screens/update/update_screen.dart';
*/
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/model/response/featured_matches.dart';
import '../view/screens/complaint/add_complaint_screen.dart';
import '../view/screens/complaint/list_complaint_screen.dart';
import '../view/screens/contact_center/contact_center_screen.dart';

import '../view/screens/create_team/choose_captain_screen.dart';
import '../view/screens/create_team/create_league_screen.dart';
import '../view/screens/create_team/create_team_screen.dart';
import '../view/screens/create_team/final_create_team_preview.dart';
import '../view/screens/create_team/join_team_page.dart';
import '../view/screens/kyc/kyc_screen.dart';
import '../view/screens/kyc/kyc_success_screen.dart';
import '../view/screens/language/language_screen.dart';
import '../view/screens/leader_board/leaderboard_screen.dart';
import '../view/screens/location/location_screen.dart';
import '../view/screens/my_matches/my_matches_detail_page.dart';
import '../view/screens/wallet/add_bank_screen.dart';
import '../view/screens/wallet/add_card_screen.dart';
import '../view/screens/wallet/add_payment_option_screen.dart';
import '../view/screens/wallet/withdraw.dart';
import '../view/screens/webview/webview_screen.dart';
import '../../../../data/model/response/league_list.dart';

class RouteHelper {
  static const String initial = '/';
  static const String splash = '/splash';
  static const String language = '/language';
  static const String onBoarding = '/on-boarding';
  static const String signIn = '/sign-in';
  static const String signUp = '/sign-up';
  static const String verification = '/verification';
  static const String accessLocation = '/access-location';
  static const String pickMap = '/pick-map';
  static const String interest = '/interest';
  static const String main = '/main';
  static const String dashboard = '/dashboard';
  static const String forgotPassword = '/forgot-password';
  static const String resetPassword = '/reset-password';
  static const String search = '/search';
  static const String store = '/store';
  static const String orderDetails = '/order-details';
  static const String profile = '/profile';
  static const String updateProfile = '/update-profile';
  static const String coupon = '/coupon';
  static const String notification = '/notification';
  static const String map = '/map';
  static const String address = '/address';
  static const String orderSuccess = '/order-successful';
  static const String payment = '/payment';
  static const String checkout = '/checkout';
  static const String orderTracking = '/track-order';
  static const String basicCampaign = '/basic-campaign';
  static const String html = '/html';
  static const String categories = '/categories';
  static const String categoryItem = '/category-item';
  static const String popularItems = '/popular-items';
  static const String itemCampaign = '/item-campaign';
  static const String support = '/help-and-support';
  static const String rateReview = '/rate-and-review';
  static const String update = '/update';
  static const String cart = '/cart';
  static const String addAddress = '/add-address';
  static const String editAddress = '/edit-address';
  static const String storeReview = '/store-review';
  static const String allStores = '/stores';
  static const String itemImages = '/item-images';
  static const String parcelCategory = '/parcel-category';
  static const String parcelLocation = '/parcel-location';
  static const String errandmainscreen = '/errand_main_screen';
  static const String parcelRequest = '/parcel-request';
  static const String searchStoreItem = '/search-store-item';
  static const String order = '/order';
  static const String itemDetails = '/item-details';
  static const String wallet = '/wallet';
  static const String referAndEarn = '/refer-and-earn';
  static const String favouritescreen = '/favourite_screen';
  static const String personalprofilescreen = '/personal_profile_screen';
  static const String changepasswordscreen = '/change_password_screen';
  static const String changeemailscreen = '/change_email_screen';
  static const String soscontactscreen = '/sos_contact_screen';
  static const String addcontactscreen = '/add_contact_screen';
  static const String myprofilescreen = '/myprofile_screen';
  static const String topnewsscreen = '/top_news_screen';
  static const String surveyscreen = '/survey_screen';
  static const String newsdetailscreen = '/news_detail_screen';
  static const String incidencedetailscreen = '/incidence_detail_screen';
  static const String reportincidencescreen = '/report_incidence_screen';
  static const String surveystartscreen = '/survey_start_screen';
  static const String surveyquestionscreen = '/survey_question_screen';
  static const String selectcountryscreen = '/select_country_screen';
  static const String selectcategoryscreen = '/select_category_screen';
  static const String addcomplaintscreen = '/add_complaint_screen';
  static const String listcomplaintscreen = '/list_complaint_screen';
  static const String contactcenterscreen = '/contact_center_screen';
  static const String resourcecenterscreen = '/resource_center_screen';
  static const String securityofficerchatscreen =
      '/security_officer_chat_screen';
  static const String webviewscreen = '/webviewscreen';
  static const String kycscreen = '/kycscreen';
  static const String kycsuccessscreen = '/kyc_success_screen';
  static const String withdrawscreen = '/withdraw_screen';
  static const String addcardscreen = '/addcard_screen';
  static const String addbankscreen = '/addbank_screen';
  static const String addpaymentoption = '/addpaymentoption_screen';
  static const String createteamscreen = '/create_team_screen';
  static const String joinTeamScreen = '/joinTeamScreen';
  static const String choose_captain_screen = '/choose_captain_team_screen';
  static const String final_team_screen = '/final_team_screen';
  static const String leaderboard = '/leaderboard';
  static const String createleague = '/createleague';
  static const String myMatchesDetail = '/my_matches_detail';

  static String getInitialRoute() => '$initial';

  static String getPersonalProfileRoute() => '$personalprofilescreen';

  static String getChangePasswordRoute() => '$changepasswordscreen';

  static String getChangeEmailRoute() => '$changeemailscreen';

  static String getSOSCOntactRoute() => '$soscontactscreen';

  static String getAddContactRoute() => '$addcontactscreen';

  static String getDashboardRoute() => '$dashboard';

  static String getFavoriteScreen() => '$favouritescreen';

  static String getMyprofileScreen() => '$myprofilescreen';

  static String getSurveyScreen() => '$surveyscreen';

  static String getWebViewScreen(String url) => '$webviewscreen?url=$url';

  static String getReportIncidenceScreen() => '$reportincidencescreen';

  static String getIncidenceDetailScreen(String incidence_id) =>
      '$incidencedetailscreen?incidence_id=$incidence_id';

  static String getTopNewsScreen() => '$topnewsscreen';

  static String getSplashRoute(int orderID) => '$splash?id=$orderID';

  static String getLanguageRoute(String page) => '$language?page=$page';

  static String getOnBoardingRoute() => '$onBoarding';

  static String getSignInRoute(String page) => '$signIn?page=$page';

  static String getSignUpRoute(String number) => '$signUp?number=$number';

  static String getSelectCountryRoute(String number) =>
      '$selectcountryscreen?state_id=$number';

  static String getSelectCategoryRoute(String number) =>
      '$selectcategoryscreen?state_id=$number';

  static String getSecurityOfficerCHatScreenRoute(String incidence_id) =>
      '$securityofficerchatscreen?incidence_id=$incidence_id';

  static String getAddComplaintRoute() => '$addcomplaintscreen';

  static String getListComplaintRoute() => '$listcomplaintscreen';

  static String getContactCenterRoute() => '$contactcenterscreen';

  static String getResourceCenterRoute() => '$resourcecenterscreen';

  static String getKYCScreenRoute() => '$kycscreen';

  static String getKYCSuccessScreenRoute() => '$kycsuccessscreen';

  static String getLeaderBoardScreenRoute() => '$leaderboard';

  static String getFinalTeamScreenRoute() => '$final_team_screen';

  static String getVerificationRoute(
      String number, String token, String page, String pass) {
    return '$verification?page=$page&number=$number&token=$token&pass=$pass';
  }

  static String getAccessLocationRoute(String page) => '$accessLocation';

  static String getPickMapRoute(String page, bool canRoute) =>
      '$pickMap?page=$page&route=${canRoute.toString()}';

  static String getInterestRoute() => '$interest';

  static String getMainRoute(String page) => '$main?page=$page';

  static String getForgotPassRoute(
      bool fromSocialLogin, SocialLogInBody socialLogInBody, String number) {
    String _data;
    if (fromSocialLogin) {
      _data = base64Encode(utf8.encode(jsonEncode(socialLogInBody.toJson())));
    }
    return '$forgotPassword?page=${fromSocialLogin ? 'social-login' : 'forgot-password'}&data=${fromSocialLogin ? _data : 'null'}&number=$number';
  }

  static String getResetPasswordRoute(
          String phone, String token, String page) =>
      '$resetPassword?phone=$phone&token=$token&page=$page';

  static String getSearchRoute({String queryText}) =>
      '$search?query=${queryText ?? ''}';

  static String getStoreRoute(int id, String page) =>
      '$store?id=$id&page=$page';

  static String getOrderDetailsRoute(int orderID) {
    return '$orderDetails?id=$orderID';
  }

  static String getProfileRoute() => '$profile';

  static String getWithdrawRoute() => '$withdrawscreen';

  static String getAddCardRoute() => '$addcardscreen';

  static String getAddBankRoute() => '$addbankscreen';

  static String getAddPaymentOptionRoute() => '$addpaymentoption';

  static String getUpdateProfileRoute() => '$updateProfile';

  static String getCouponRoute() => '$coupon';

  static String getNotificationRoute() => '$notification';

  static String getMyMatchesDetailRoute() => '$myMatchesDetail';

  static String getMapRoute(AddressModel addressModel, String page) {
    List<int> _encoded = utf8.encode(jsonEncode(addressModel.toJson()));
    String _data = base64Encode(_encoded);
    return '$map?address=$_data&page=$page';
  }

  static String getCreateLeagueRoute(Matches matchID) {
    String _data =
    base64Encode(utf8.encode(jsonEncode(matchID.toJson())));
    return '$createleague?matchID=$_data';
  }

  static String getCreateTeamScreenRoute(Matches matchID) {
    String  _data = base64Encode(utf8.encode(jsonEncode(matchID.toJson())));
    return '$createteamscreen?matchID=$_data';
  }

  static String getJoinTeamScreenRoute(Matches matchID,Data data) {
    String  _data = base64Encode(utf8.encode(jsonEncode(matchID.toJson())));
    String  leagueData = base64Encode(utf8.encode(jsonEncode(data.toJson())));

    return '$joinTeamScreen?matchID=$_data&leagueData=$leagueData';
  }

  static String getChooseCaptainScreenRoute(Matches matchID) {

    String _data = base64Encode(utf8.encode(jsonEncode(matchID.toJson())));

    return '$choose_captain_screen?matchID=$_data';
  }

  static String getAddressRoute() => '$address';

  static String getOrderSuccessRoute(String orderID) {
    return '$orderSuccess?id=$orderID';
  }

  static String getPaymentRoute() => '$payment';

  static String getCheckoutRoute(String page) => '$checkout?page=$page';

  static String getOrderTrackingRoute(int id) => '$orderTracking?id=$id';

  static String getBasicCampaignRoute(BasicCampaignModel basicCampaignModel) {
    String _data =
        base64Encode(utf8.encode(jsonEncode(basicCampaignModel.toJson())));
    return '$basicCampaign?data=$_data';
  }

  /*static String getSurveyStartScreen(PendingSurvey basicCampaignModel) {
    String _data = base64Encode(utf8.encode(jsonEncode(basicCampaignModel.toJson())));
    return '$surveystartscreen?data=$_data';
  }*/

  static String getHtmlRoute(String page) => '$html?page=$page';

  static String getCategoryRoute() => '$categories';

  static String getCategoryItemRoute(int id, String name) {
    List<int> _encoded = utf8.encode(name);
    String _data = base64Encode(_encoded);
    return '$categoryItem?id=$id&name=$_data';
  }

  static String getPopularItemRoute(bool isPopular) =>
      '$popularItems?page=${isPopular ? 'popular' : 'reviewed'}';

  static String getItemCampaignRoute() => '$itemCampaign';

  static String getSupportRoute() => '$support';

  static String getReviewRoute() => '$rateReview';

  static String getUpdateRoute(bool isUpdate) =>
      '$update?update=${isUpdate.toString()}';

  static String getCartRoute() => '$cart';

  static String getAddAddressRoute(bool fromCheckout, int zoneId) =>
      '$addAddress?page=${fromCheckout ? 'checkout' : 'address'}&zone_id=$zoneId';

  static String getEditAddressRoute(AddressModel address) {
    String _data = base64Url.encode(utf8.encode(jsonEncode(address.toJson())));
    return '$editAddress?data=$_data';
  }

  static String getStoreReviewRoute(int storeID) => '$storeReview?id=$storeID';

  static String getAllStoreRoute(String page) => '$allStores?page=$page';

  static String getParcelCategoryRoute() => '$parcelCategory';

  static String getParcelLocationRoute(ParcelCategoryModel category) {
    String _data = base64Url.encode(utf8.encode(jsonEncode(category.toJson())));
    return '$parcelLocation?data=$_data';
  }

  static String getErrandLocationRoute() {
    return '$errandmainscreen';
  }

  static String getParcelRequestRoute(ParcelCategoryModel category,
      AddressModel pickupAddress, AddressModel destinationAddress) {
    String _category =
        base64Url.encode(utf8.encode(jsonEncode(category.toJson())));
    String _pickedUpAddress =
        base64Url.encode(utf8.encode(jsonEncode(pickupAddress.toJson())));
    String _destinationAddress =
        base64Url.encode(utf8.encode(jsonEncode(destinationAddress.toJson())));
    return '$parcelRequest?category=$_category&picked=$_pickedUpAddress&destination=$_destinationAddress';
  }

  static String getSearchStoreItemRoute(int storeID) =>
      '$searchStoreItem?id=$storeID';

  static String getOrderRoute() => '$order';

  static String getItemDetailsRoute(int itemID, bool isRestaurant) =>
      '$itemDetails?id=$itemID&page=${isRestaurant ? 'restaurant' : 'item'}';

  static String getWalletRoute(bool fromWallet) =>
      '$wallet?page=${fromWallet ? 'wallet' : 'loyalty_points'}';

  static String getReferAndEarnRoute() => '$referAndEarn';

  static List<GetPage> routes = [
    GetPage(name: initial, page: () => getRoute(DashboardScreen(pageIndex: 0))),

    GetPage(
        name: dashboard, page: () => getRoute(DashboardScreen(pageIndex: 0))),
    //  GetPage(name: favouritescreen, page: () => getRoute(FavouriteScreen())),
/*
    GetPage(name: myprofilescreen, page: () => getRoute(MyProfileScreen())),
*/
    GetPage(
        name: language,
        page: () =>
            ChooseLanguageScreen(fromMenu: Get.parameters['page'] == 'menu')),
    /* GetPage(name: surveyscreen, page: () => getRoute(SurveyScreen())),*/
    GetPage(
        name: webviewscreen,
        page: () => getRoute(WebviewScreen(url: Get.parameters['url']))),

    GetPage(
        name: splash,
        page: () => SplashScreen(
            orderID:
                Get.parameters['id'] == 'null' ? null : Get.parameters['id'])),
    //  GetPage(name: language, page: () => ChooseLanguageScreen(fromMenu: Get.parameters['page'] == 'menu')),
    GetPage(name: onBoarding, page: () => OnBoardingScreen()),
    GetPage(name: accessLocation, page: () => LocationScreen()),
    GetPage(
        name: signIn,
        page: () => SignInScreen(
              exitFromApp: Get.parameters['page'] == signUp ||
                  Get.parameters['page'] == splash ||
                  Get.parameters['page'] == onBoarding,
            )),

    GetPage(
        name: createleague,
        page: () => CreateLeagueScreen(
              matchID: Get.parameters['matchID']!=null? Matches.fromJson(jsonDecode(
                  utf8.decode(base64Url.decode(Get.parameters['matchID'])))):null,
            )),

    GetPage(
        name: choose_captain_screen,
        page: () => getRoute(ChooseCaptainTeamScreen(
          matchID:Get.parameters['matchID']!=null && Get.parameters['matchID']!=""? Matches.fromJson(jsonDecode(
              utf8.decode(base64Url.decode(Get.parameters['matchID'])))):null,

        ))),

    GetPage(
        name: createteamscreen,
        page: () => getRoute(CreateTeamScreen(
          matchID: Get.parameters['matchID'] != null &&
              Get.parameters['matchID'] != ""
              ? Matches.fromJson(jsonDecode(
              utf8.decode(base64Url.decode(Get.parameters['matchID']))))
              : null,

        ))),
 GetPage(
        name: joinTeamScreen,
        page: () => getRoute(JoinTeamScreen(
          matchID: Get.parameters['matchID'] != null &&
              Get.parameters['matchID'] != ""
              ? Matches.fromJson(jsonDecode(
              utf8.decode(base64Url.decode(Get.parameters['matchID']))))
              : null,
          leagueData: Get.parameters['leagueData'] != null &&
              Get.parameters['leagueData'] != ""
              ? Data.fromJson(jsonDecode(
              utf8.decode(base64Url.decode(Get.parameters['leagueData']))))
              : null,

        ))),

    GetPage(
        name: signUp,
        page: () => SignUpScreen(number: Get.parameters['number'])),

    GetPage(
        name: main,
        page: () => getRoute(DashboardScreen(
              pageIndex: Get.parameters['page'] == 'home'
                  ? 0
                  : Get.parameters['page'] == 'favourite'
                      ? 1
                      : Get.parameters['page'] == 'cart'
                          ? 2
                          : Get.parameters['page'] == 'order'
                              ? 3
                              : Get.parameters['page'] == 'menu'
                                  ? 4
                                  : 0,
            ))),

    GetPage(
        name: forgotPassword,
        page: () {
          SocialLogInBody _data;
          if (Get.parameters['page'] == 'social-login') {
            List<int> _decode =
                base64Decode(Get.parameters['data'].replaceAll(' ', '+'));
            _data = SocialLogInBody.fromJson(jsonDecode(utf8.decode(_decode)));
          }
          return ForgetPassScreen(
              fromSocialLogin: Get.parameters['page'] == 'social-login',
              socialLogInBody: _data,
              number: Get.parameters['number']);
        }),
    GetPage(
        name: verification,
        page: () {
          List<int> _decode =
              base64Decode(Get.parameters['pass'].replaceAll(' ', '+'));
          String _data = utf8.decode(_decode);
          return VerificationScreen(
            number: Get.parameters['number'],
            fromSignUp: Get.parameters['page'] == signUp,
            token: Get.parameters['token'],
            password: _data,
          );
        }),
    GetPage(
        name: resetPassword,
        page: () => NewPassScreen(
              resetToken: Get.parameters['token'],
              number: Get.parameters['phone'],
              fromPasswordChange: Get.parameters['page'] == 'password-change',
            )),
    GetPage(name: profile, page: () => getRoute(ProfileScreen())),
    GetPage(name: withdrawscreen, page: () => getRoute(WithdrawScreen())),
    GetPage(name: addcardscreen, page: () => getRoute(AddCardScreen())),
    GetPage(name: addbankscreen, page: () => getRoute(AddBankScreen())),
    GetPage(
        name: addpaymentoption, page: () => getRoute(AddPaymentOptionScreen())),
    GetPage(name: updateProfile, page: () => getRoute(UpdateProfileScreen())),
    /* GetPage(name: coupon, page: () => getRoute(CouponScreen())),
   */
    GetPage(name: notification, page: () => getRoute(NotificationScreen())),
    GetPage(
        name: myMatchesDetail, page: () => getRoute(MyMatchesDetailScreen())),
    GetPage(name: kycscreen, page: () => getRoute(KYCScreen())),
    GetPage(name: kycsuccessscreen, page: () => getRoute(KYCSUCCESSScreen())),
    GetPage(name: leaderboard, page: () => getRoute(LeaderBoardScreen())),
    GetPage(
        name: final_team_screen,
        page: () => getRoute(FinalCreateTeamPreviewScreen())),

    GetPage(
        name: html,
        page: () => HtmlViewerScreen(
              htmlType: Get.parameters['page'] == 'terms-and-condition'
                  ? HtmlType.TERMS_AND_CONDITION
                  : Get.parameters['page'] == 'privacy-policy'
                      ? HtmlType.PRIVACY_POLICY
                      : HtmlType.ABOUT_US,
            )),
    GetPage(name: support, page: () => getRoute(SupportScreen())),

    GetPage(
        name: rateReview,
        page: () =>
            getRoute(Get.arguments != null ? Get.arguments : NotFound())),




    GetPage(name: referAndEarn, page: () => getRoute(ReferAndEarnScreen())),
  ];

  static getRoute(Widget navigateTo) {
    /*int _minimumVersion = 0;
    if(GetPlatform.isAndroid) {
      _minimumVersion = Get.find<SplashController>().configModel.appMinimumVersionAndroid;
    }else if(GetPlatform.isIOS) {
      _minimumVersion = Get.find<SplashController>().configModel.appMinimumVersionIos;
    }
    return AppConstants.ANDROID_APP_VERSION < _minimumVersion ? UpdateScreen(isUpdate: true)
        : Get.find<SplashController>().configModel.maintenanceMode ? UpdateScreen(isUpdate: false)
        : Get.find<LocationController>().getUserAddress() == null
        ? */ /*AccessLocationScreen(fromSignUp: false, fromHome: false, route: Get.currentRoute)*/ /*navigateTo : navigateTo;*/
    return navigateTo;
  }
}
