import 'package:sixam_mart/data/model/response/onboarding_model.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:get/get.dart';

class OnBoardingRepo {

  Future<Response> getOnBoardingList() async {
    try {
      List<OnBoardingModel> onBoardingList = [
        OnBoardingModel(Images.onboard_1, 'Welcome to AbujaEye'.tr, 'Your safety companion for a safer Abuja.'.tr),
        OnBoardingModel(Images.onboard_2, 'Empower Your Safety'.tr, 'Report incidents, receive alerts, and connect with authorities.'.tr),
        OnBoardingModel(Images.onboard_3, 'Stay Informed'.tr, 'Receive real-time alerts about incidents around you.'.tr),
        OnBoardingModel(Images.onboard_4, 'Connected Security'.tr, 'Collaborate with your community and security agencies for a safer city.'.tr),
      ];

      Response response = Response(body: onBoardingList, statusCode: 200);
      return response;
    } catch (e) {
      return Response(statusCode: 404, statusText: 'Onboarding data not found');
    }
  }
}
