import 'package:flutter_svg/svg.dart';
import 'package:sixam_mart/controller/onboarding_controller.dart';
import 'package:sixam_mart/controller/splash_controller.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/view/base/custom_button.dart';
import 'package:sixam_mart/view/base/web_menu_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../util/images.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();

    Get.find<OnBoardingController>().getOnBoardingList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: ResponsiveHelper.isDesktop(context) ? WebMenuBar() : null,
      body: GetBuilder<OnBoardingController>(
        builder: (onBoardingController) => onBoardingController
                    .onBoardingList.length >
                0
            ? SafeArea(
                child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Theme.of(context).backgroundColor,
                child: Center(
                    child: SizedBox(
                        width: Dimensions.WEB_MAX_WIDTH,
                        child: Column(children: [
                          Stack(
                            children: [
                              Center(
                                  child: Padding(
                                      padding: EdgeInsets.only(top: 20),
                                      child: SvgPicture.asset(Images.logo_white,
                                          width: 50))),
                              Positioned(
                                  right: 0,
                                  top: 10,
                                  child: CustomButton(
                                    width: 100,
                                    transparent: true,
                                    onPressed: () {
                                      Get.find<SplashController>()
                                          .disableIntro();
                                      Get.offNamed(RouteHelper.getSignInRoute(
                                          RouteHelper.onBoarding));
                                    },
                                    buttonText: 'skip'.tr,
                                  )),
                            ],
                          ),
                          Expanded(
                              child:
                              PageView.builder(
                            itemCount:
                                onBoardingController.onBoardingList.length,
                            controller: _pageController,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.all(context.height * 0.05),
                                      child: Image.asset(
                                          onBoardingController
                                              .onBoardingList[index].imageUrl,
                                          height: context.height * 0.3),
                                    ),
                                    Text(
                                      onBoardingController
                                          .onBoardingList[index].title,
                                      style: robotoBold.copyWith(
                                          fontSize: Dimensions
                                              .fontSizeOverLarge /*context.height*0.022*/,
                                          color: Theme.of(context).cardColor),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(height: context.height * 0.025),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              Dimensions.PADDING_SIZE_LARGE),
                                      child: Text(
                                        onBoardingController
                                            .onBoardingList[index].description,
                                        style: robotoMedium.copyWith(
                                            fontSize: Dimensions
                                                .fontSizeDefault /*context.height*0.015*/,
                                            color: Theme.of(context)
                                                .cardColor
                                                .withOpacity(0.5)),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ]);
                            },
                            onPageChanged: (index) {
                              onBoardingController.changeSelectIndex(index);
                            },
                          )
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:
                                _pageIndicators(onBoardingController, context),
                          ),
                          SizedBox(height: context.height * 0.05),
                          Padding(
                            padding:
                                EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                            child: Row(children: [
                              onBoardingController.selectedIndex == 4
                                  ? SizedBox()
                                  :
                                  /*Expanded(
                  child: CustomButton(
                    transparent: true,
                    onPressed: () {
                      Get.find<SplashController>().disableIntro();
                      Get.offNamed(RouteHelper.getSignInRoute(RouteHelper.onBoarding));
                    },
                    buttonText: 'skip'.tr,
                  ),
                ),*/
                                  Expanded(
                                      child: CustomButton(
                                        buttonText: onBoardingController
                                                    .selectedIndex !=
                                                3
                                            ? 'next'.tr
                                            : 'get_started'.tr,
                                        onPressed: () {
                                          if (onBoardingController
                                                  .selectedIndex !=
                                              2) {
                                            _pageController.nextPage(
                                                duration: Duration(seconds: 1),
                                                curve: Curves.ease);
                                          } else {
                                            Get.find<SplashController>()
                                                .disableIntro();
                                            Get.offNamed(
                                                RouteHelper.getSignInRoute(
                                                    RouteHelper.onBoarding));
                                          }
                                        },
                                      ),
                                    ),
                            ]),
                          ),
                        ]))),
              ))
            : SizedBox(),
      ),
    );
  }

  List<Widget> _pageIndicators(
      OnBoardingController onBoardingController, BuildContext context) {
    List<Container> _indicators = [];

    for (int i = 0; i < onBoardingController.onBoardingList.length; i++) {
      _indicators.add(
        Container(
          width: 10,
          height: 10,
          margin: EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            color: i == onBoardingController.selectedIndex
                ? Theme.of(context).primaryColor
                : Theme.of(context).disabledColor,
            borderRadius: i == onBoardingController.selectedIndex
                ? BorderRadius.circular(50)
                : BorderRadius.circular(25),
          ),
        ),
      );
    }
    return _indicators;
  }
}
