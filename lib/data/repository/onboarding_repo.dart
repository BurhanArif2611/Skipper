import 'package:sixam_mart/data/model/response/onboarding_model.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:get/get.dart';

class OnBoardingRepo {

  Future<Response> getOnBoardingList() async {
    try {
      List<OnBoardingModel> onBoardingList = [
        OnBoardingModel(Images.onboard_1, 'Quick and easy monitoring'.tr, 'Detalled and easy accessible information that facilitates quick and easy monitoring.'.tr),
        OnBoardingModel(Images.onboard_2, 'Information on the go'.tr, 'Secured and real time feedback on election process from observers.'.tr),
        OnBoardingModel(Images.onboard_2, 'Information on the go'.tr, 'Secured and real time feedback on election process from observers.'.tr),
        OnBoardingModel(Images.onboard_3, 'Information on the go'.tr, 'Secured and real time feedback on election process from observers.'.tr),
      ];

      Response response = Response(body: onBoardingList, statusCode: 200);
      return response;
    } catch (e) {
      return Response(statusCode: 404, statusText: 'Onboarding data not found');
    }
  }
}
