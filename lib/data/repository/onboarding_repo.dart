import 'package:sixam_mart/data/model/response/onboarding_model.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:get/get.dart';

class OnBoardingRepo {

  Future<Response> getOnBoardingList() async {
    try {
      List<OnBoardingModel> onBoardingList = [
        OnBoardingModel(Images.onboard_1, 'Explore Best Games'.tr, 'Welcome to our Skipper11 app! Our app provides a seamless and user-friendly experience for sports betting.'.tr),
        OnBoardingModel(Images.onboard_1, 'Explore Best Games'.tr, 'Welcome to our Skipper11 app! Our app provides a seamless and user-friendly experience for sports betting.'.tr),
        OnBoardingModel(Images.onboard_2, 'Pick Your Team WIN CASH PRIZES'.tr, 'Gather a winning team, compete in contests, and secure cash prizes through skillful collaboration.'.tr),
       /* OnBoardingModel(Images.onboard_4, 'Connected Security'.tr, 'Collaborate with your community and security agencies for a safer city.'.tr),
      */];

      Response response = Response(body: onBoardingList, statusCode: 200);
      return response;
    } catch (e) {
      return Response(statusCode: 404, statusText: 'Onboarding data not found');
    }
  }
}
