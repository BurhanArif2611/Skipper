import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sixam_mart/data/model/response/choose_us_model.dart';
import 'package:sixam_mart/data/model/response/language_model.dart';
import 'package:sixam_mart/data/model/response/region_response_model.dart';
import 'package:sixam_mart/util/images.dart';

import '../controller/banner_controller.dart';

class AppConstants {
  static const String APP_NAME = 'Parti Politique Les Patriotes';
  static const double ANDROID_APP_VERSION = 1.0;
  static const double IOS_APP_VERSION = 1.0;

  //dev url

  // static const String BASE_URL = 'http://192.168.1.42:5400';
   // staging url
   static const String BASE_URL = 'https://admin-dashboard.partilespatriotes.org';

  //local url
   //static const String BASE_URL = 'http://192.168.1.164:8000';
   // static const String BASE_URL = 'https://portal-dev.shapshap.com';
  //live url
  // static const String BASE_URL = 'https://portal.shapshap.com';
  static const String CATEGORY_URI = '/api/v1/categories';
  static const String BANNER_URI = '/api/v1/banners';
  static const String BRANCG_URI = '/api/v1/stores';
  static const String Accept_ERRAND_COUNTER_URI =
      '/api/v1/customer/errands/orders/accept/';
  static const String STORE_ITEM_URI = '/api/v1/items/latest';
  static const String POPULAR_ITEM_URI = '/api/v1/items/popular';
  static const String REVIEWED_ITEM_URI = '/api/v1/items/most-reviewed';
  static const String SEARCH_ITEM_URI = '/api/v1/items/details/';
  static const String SUB_CATEGORY_URI = '/api/v1/categories/childes/';
  static const String CATEGORY_ITEM_URI = '/api/v1/categories/items/';
  static const String CATEGORY_STORE_URI = '/api/v1/categories/stores/';
  static const String CONFIG_URI = '/api/v1/config';
  static const String TRACK_URI = '/api/v1/customer/order/track?order_id=';
  static const String MESSAGE_URI = '/api/v1/customer/message/get';
  static const String SEND_MESSAGE_URI = '/api/v1/customer/message/send';
  static const String FORGET_PASSWORD_URI = '/forget-password/';
  static const String VERIFY_TOKEN_URI = '/api/v1/auth/verify-token';
  static const String PollingSurvey_URI = '/api/survey';
  static const String Regions_URI = '/api/regions';
  static const String PollingSurveyStore_URI = '/api/survey/store';
  static const String RESET_PASSWORD_URI = '/api/v1/auth/reset-password';
  static const String VERIFY_PHONE_URI = '/api/v1/auth/verify-phone';
  static const String CHECK_EMAIL_URI = '/api/v1/auth/check-email';
  static const String VERIFY_EMAIL_URI = '/api/v1/auth/verify-email';
  static const String REGISTER_URI = '/signup';
  static const String LOGIN_URI = '/login';
  static const String Incidents_URI = '/incidents';
  static const String SubmitSurveys_URI = '/api/survey/answer';
  static const String IncidentComment_URI = '/incident/comment';
  static const String SecurityComment_URI = '/incident/comment/security/';
  static const String ADD_SOS_CONTACT_URI = '/user/sos';
  static const String Resource_Centers_URI = '/resource-centers';
  static const String Contact_Centers_URI = '/contact-centers';
  static const String CHECK_PHONE_URI = '/api/v1/auth/check_phone';
  static const String TOKEN_URI = '/api/v1/customer/cm-firebase-token';
  static const String PLACE_ORDER_URI = '/api/v1/customer/order/place';
  static const String ADDRESS_LIST_URI = '/api/v1/customer/address/list';
  static const String ZONE_URI = '/api/v1/config/get-zone-id';
  static const String REMOVE_ADDRESS_URI =
      '/api/v1/customer/address/delete?address_id=';
  static const String ADD_ADDRESS_URI = '/api/v1/customer/address/add';
  static const String UPDATE_ADDRESS_URI = '/api/v1/customer/address/update/';
  static const String SET_MENU_URI = '/api/v1/items/set-menu';
  static const String CUSTOMER_INFO_URI = '/user/profile';
  static const String CHANGE_PASSWORD_URI = '/user/changePassword';
  static const String COUPON_URI = '/api/v1/coupon/list';
  static const String COUPON_APPLY_URI = '/api/v1/coupon/apply?code=';
  static const String RUNNING_ORDER_LIST_URI =
      '/api/v1/customer/order/running-orders';
  static const String HISTORY_ORDER_LIST_URI = '/api/v1/customer/order/list';
  static const String ORDER_CANCEL_URI = '/api/v1/customer/order/cancel';
  static const String COD_SWITCH_URL = '/api/v1/customer/order/payment-method';
  static const String ORDER_DETAILS_URI =
      '/api/v1/customer/order/details?order_id=';
  static const String WISH_LIST_GET_URI = '/api/v1/customer/wish-list';
  static const String ADD_WISH_LIST_URI = '/api/v1/customer/wish-list/add?';
  static const String REMOVE_WISH_LIST_URI =
      '/api/v1/customer/wish-list/remove?';
  static const String NOTIFICATION_URI = '/api/v1/customer/notifications';
  static const String UPDATE_PROFILE_URI = '/api/v1/customer/update-profile';
  static const String SEARCH_URI = '/api/v1/';
  static const String REVIEW_URI = '/api/v1/items/reviews/submit';
  static const String ITEM_DETAILS_URI = '/api/v1/items/details/';
  static const String LAST_LOCATION_URI =
      '/api/v1/delivery-man/last-location?order_id=';
  static const String DELIVER_MAN_REVIEW_URI =
      '/api/v1/delivery-man/reviews/submit';
  static const String STORE_URI = '/api/v1/stores/get-stores';
  static const String POPULAR_STORE_URI = '/api/v1/stores/popular';
  static const String LATEST_STORE_URI = '/api/v1/stores/latest';
  static const String STORE_DETAILS_URI = '/api/v1/stores/details/';
  static const String BASIC_CAMPAIGN_URI = '/api/v1/campaigns/basic';
  static const String ITEM_CAMPAIGN_URI = '/api/v1/campaigns/item';
  static const String BASIC_CAMPAIGN_DETAILS_URI =
      '/api/v1/campaigns/basic-campaign-details?basic_campaign_id=';
  static const String INTEREST_URI = '/api/v1/customer/update-interest';
  static const String SUGGESTED_ITEM_URI = '/api/v1/customer/suggested-items';
  static const String STORE_REVIEW_URI = '/api/v1/stores/reviews';
  static const String DISTANCE_MATRIX_URI = '/api/v1/config/distance-api';
  static const String SEARCH_LOCATION_URI =
      '/api/v1/config/place-api-autocomplete';
  static const String PLACE_DETAILS_URI = '/api/v1/config/place-api-details';
  static const String GEOCODE_URI = '/api/v1/config/geocode-api';
  static const String SOCIAL_LOGIN_URL = '/api/v1/auth/social-login';
  static const String SOCIAL_REGISTER_URL = '/api/v1/auth/social-register';
  static const String UPDATE_ZONE_URL = '/api/v1/customer/update-zone';
  static const String Incidents_URL = '/incidents';
  static const String LatestNews_URL = '/latest/news';
  static const String News_URL = '/news';
  static const String Categories_URL = '/categories';
  static const String Surveys_URL = '/surveys';
  static const String StateList_URL = '/admin/states';
  static const String LgaList_URL = '/admin/lgas';
  static const String WardList_URL = '/admin/wards';
  static const String IncidentTypes_URL = '/incident-types';
  static const String Complaint_URL = '/complaint';
  static const String SENDSOSALERT_URL = '/send-sos-msg';
  static const String ComplaintDelete_URL = '/user/complaint';
  static const String Comment_URL = '/comment';
  static const String SAVE_TOKEN_URL = '/api/save-device-token';


  static const String MODULES_URI = '/api/v1/module';
  static const String PARCEL_CATEGORY_URI = '/api/v1/parcel-category';
  static const String ABOUT_US_URI = '/about-us';
  static const String PRIVACY_POLICY_URI = '/privacy-policy';
  static const String TERMS_AND_CONDITIONS_URI = '/terms-and-conditions';
  static const String SUBSCRIPTION_URI = '/api/v1/newsletter/subscribe';
  static const String CUSTOMER_REMOVE = '/api/v1/customer/remove-account';
  static const String WALLET_TRANSACTION_URL =
      '/api/v1/customer/wallet/transactions';
  static const String WALLET_REQUEST_WITHDRAW_URL =
      '/api/v1/customer/withdraw/request/list';
  static const String BANK_LIST_URL = '/api/v1/banks/list';
  static const String LOYALTY_TRANSACTION_URL =
      '/api/v1/customer/loyalty-point/transactions';
  static const String LOYALTY_POINT_TRANSFER_URL =
      '/api/v1/customer/loyalty-point/point-transfer';
  static const String ADD_BANK_ACCOUNT_URL =
      '/api/v1/customer/banks/account/create';
  /*static const String WITHDRAW_FUND_URL =
      '/api/v1/customer/banks/account/withdraw';*/
  static const String WITHDRAW_FUND_URL =
      '/api/v1/customer/withdraw/request';
  static const String ADD_FUND_URL = '/api/v1/customer/banks/account/add_fund';
  static const String WITHRAW_REQUEST_URL = '/api/v1/customer/withdraw/request/cancel';
  static const String GET_BANK_ACCOUNT_LIST_URL =
      '/api/v1/customer/beneficiaries';
  static const String DELETE_BANK_ACCOUNT_URL =
      '/api/v1/customer/banks/account/delete?';
 /* static int ParantStoreID = 1;
  static int StoreID = 1;*/
  static int ParantStoreID = 55;
  static int StoreID = 55;
  static int ModelID = 1;

  static const String Store_ID = "store-id";

  // Shared Key
  static const String THEME = '6ammart_theme';
  static const String TOKEN = '6ammart_token';
  static const String ROLE = 'Role';
  static const String COUNTRY_CODE = '6ammart_country_code';
  static const String LANGUAGE_CODE = '6ammart_language_code';
  static const String CART_LIST = '6ammart_cart_list';
  static const String USER_PASSWORD = '6ammart_user_password';
  static const String USER_ADDRESS = '6ammart_user_address';
  static const String USER_NUMBER = '6ammart_user_number';
  static const String USER_COUNTRY_CODE = '6ammart_user_country_code';
  static const String NOTIFICATION = '6ammart_notification';
  static const String SEARCH_HISTORY = '6ammart_search_history';
  static const String INTRO = '6ammart_intro';
  static const String NOTIFICATION_COUNT = '6ammart_notification_count';
  static const String Canceled = 'canceled';

  static const String TOPIC = 'all_zone_customer';
  static const String ZONE_ID = 'zoneId';
  static const String MODULE_ID = 'moduleId';
  static const String LOCALIZATION_KEY = 'X-localization';

  static const String ACCESS_KEY = 'AKIAR6SRPD5YRLVOTAN4';
  static const String SECRET_KEY = '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';
  static const String BUCKET = 'abujaeyemedia';
  static const String REGION = 'eu-west-1';

  // Delivery Tips
  static List<int> tips = [0, 5, 10, 15, 20, 30, 50];

  static List<ChooseUsModel> whyChooseUsList = [
    ChooseUsModel(
        icon: Images.landing_trusted,
        title: 'trusted_by_customers_and_store_owners'),
    ChooseUsModel(icon: Images.landing_stores, title: 'thousands_of_stores'),
    ChooseUsModel(
        icon: Images.landing_excellent, title: 'excellent_shopping_experience'),
    ChooseUsModel(
        icon: Images.landing_checkout,
        title: 'easy_checkout_and_payment_system'),
  ];

  static List<LanguageModel> languages = [
  /*  LanguageModel(
        imageUrl: Images.english,
        languageName: 'English',
        countryCode: 'US',
        languageCode: 'en'),*/
    LanguageModel(
        imageUrl: Images.arabic,
        languageName: 'French',
        countryCode: 'FRA',
        languageCode: 'fr'),
    LanguageModel(
        imageUrl: Images.arabic,
        languageName: 'عربى',
        countryCode: 'SA',
        languageCode: 'ar'),
    LanguageModel(
        imageUrl: Images.english,
        languageName: 'English',
        countryCode: 'US',
        languageCode: 'en')

  ];

  static List<RegionResponseModel> region = [
    RegionResponseModel(id: 1,chief_place: "ATI",chief_place_ar: "",provinces: "BATHA",provinces_ar: "البطحاء"),
    RegionResponseModel(id: 2,chief_place: "FAYA",chief_place_ar: "",provinces: "BORKOU",provinces_ar: "بوركو"),
    RegionResponseModel(id: 3,chief_place: "MASSENYA",chief_place_ar: "",provinces: "CHARI-BAGUIRMI",provinces_ar: "شاري باجورمي"),
    RegionResponseModel(id: 4,chief_place: "MONGO",chief_place_ar: "",provinces: "GUERA",provinces_ar: "غيرا"),
    RegionResponseModel(id: 5,chief_place: "MASSAKORI",chief_place_ar: "",provinces: "HADJER LAMIS",provinces_ar: "هاجر لميس"),
    RegionResponseModel(id: 6,chief_place: "MAO",chief_place_ar: "",provinces: "KANEM",provinces_ar: "كانم"),
    RegionResponseModel(id: 7,chief_place: "BOL",chief_place_ar: "",provinces: "LAC",provinces_ar: "لاك"),
    RegionResponseModel(id: 8,chief_place: "MOUNDOU",chief_place_ar: "",provinces: "LOGONE OCCIDENTALE",provinces_ar: "لوغون أوكسيدنتال"),
    RegionResponseModel(id: 9,chief_place: "DOBA",chief_place_ar: "",provinces: "LOGONE ORIENTALE",provinces_ar: "تسجيل الدخول الشرقي"),
    RegionResponseModel(id: 10,chief_place: "KOUMRA",chief_place_ar: "",provinces: "MANDOUL",provinces_ar: "مندول"),
    RegionResponseModel(id: 11,chief_place: "BONGOR",chief_place_ar: "",provinces: "MAYO-KEBBI EST",provinces_ar: "مؤسسة مايو-كيبي"),
    RegionResponseModel(id: 12,chief_place: "PALA",chief_place_ar: "",provinces: "MAYO-KEBBI OUEST",provinces_ar: "مايو كيبي ويست"),
    RegionResponseModel(id: 13,chief_place: "SARH",chief_place_ar: "",provinces: "MOYEN CHARI",provinces_ar: "موين شاري"),
    RegionResponseModel(id: 14,chief_place: "ABECHE",chief_place_ar: "",provinces: "OUADDAI",provinces_ar: "أوداي"),
    RegionResponseModel(id: 15,chief_place: "AMTIMAN",chief_place_ar: "",provinces: "SALAMAT",provinces_ar: "سلامات"),
    RegionResponseModel(id: 16,chief_place: "LAI",chief_place_ar: "",provinces: "TANDJILE",provinces_ar: "تاندجيلي"),
    RegionResponseModel(id: 17,chief_place: "BILTINE",chief_place_ar: "",provinces: "BILTINE",provinces_ar: "بيلتين"),
    RegionResponseModel(id: 18,chief_place: "N\u2019DJAMENA",chief_place_ar: "",provinces: "N\u2019DJAMENA",provinces_ar: "نجامينا"),
    RegionResponseModel(id: 19,chief_place: "MOUSSOURO",chief_place_ar: "",provinces: "BARH EL-KHAZAL",provinces_ar: "بار الخزعل"),
    RegionResponseModel(id: 20,chief_place: "FADA",chief_place_ar: "",provinces: "ENNEDI OUEST",provinces_ar: "إنيدي الغربية"),
    RegionResponseModel(id: 21,chief_place: "GOZ BEIDA",chief_place_ar: "",provinces: "SILA",provinces_ar: "سيلا"),
    RegionResponseModel(id: 22,chief_place: "BARDAI",chief_place_ar: "",provinces: "TIBESTI",provinces_ar: "تيبستي"),
    RegionResponseModel(id: 23,chief_place: "AMDJARASS",chief_place_ar: "",provinces: "ENNEDI EST",provinces_ar: "إنيدي"),
  ];
}
