import 'package:flutter_svg/svg.dart';
import 'package:sixam_mart/controller/auth_controller.dart';
import 'package:sixam_mart/controller/notification_controller.dart';
import 'package:sixam_mart/controller/splash_controller.dart';
import 'package:sixam_mart/helper/date_converter.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/view/base/custom_app_bar.dart';
import 'package:sixam_mart/view/base/custom_image.dart';
import 'package:sixam_mart/view/base/footer_view.dart';
import 'package:sixam_mart/view/base/menu_drawer.dart';
import 'package:sixam_mart/view/base/no_data_screen.dart';
import 'package:sixam_mart/view/base/not_logged_in_screen.dart';
import 'package:sixam_mart/view/screens/notification/widget/notification_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/banner_controller.dart';
import '../../../controller/dashboard_controller.dart';
import '../../../controller/home_controller.dart';
import '../../../controller/onboarding_controller.dart';
import '../../../controller/store_controller.dart';
import '../../../data/model/response/order_model.dart';
import '../../../helper/responsive_helper.dart';
import '../../../helper/route_helper.dart';
import '../../../util/images.dart';
import '../../base/inner_custom_app_bar.dart';
import '../../base/paginated_list_view.dart';

class TopNewsScreen extends StatefulWidget {
  @override
  State<TopNewsScreen> createState() => _TopNewsScreenState();
}

class _TopNewsScreenState extends State<TopNewsScreen> {
  void _loadData() async {
    Get.find<NotificationController>().clearNotification();
    if (Get.find<SplashController>().configModel == null) {
      await Get.find<SplashController>().getConfigData();
    }
    if (Get.find<AuthController>().isLoggedIn()) {
      Get.find<NotificationController>().getNotificationList(1, true);
    }
  }

  @override
  void initState() {
    super.initState();

   //_loadData();
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    final PageController _pageController = PageController();
    final ScrollController _scrollController = ScrollController();
    return GetBuilder<SplashController>(builder: (splashController) {
      return Scaffold(
        appBar: InnerCustomAppBar(
            title: 'Top News'.tr,
            leadingIcon: Images.circle_arrow_back,
            backButton: !ResponsiveHelper.isDesktop(context),
            ),
        endDrawer: MenuDrawer(),
        body: Get.find<AuthController>().isLoggedIn()
            ?
        SingleChildScrollView(
            controller: scrollController,
            physics: AlwaysScrollableScrollPhysics(),
            child: Container(
              margin: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
              /* color: Colors.red,*/
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Text("Todays Top News",
                              style: robotoBold.copyWith(
                                  color: Theme
                                      .of(context)
                                      .hintColor,
                                  fontSize: Dimensions.fontSizeLarge))),
                      Expanded(
                          flex: 1,
                          child: Text(
                            "See More",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.grey,
                              // Optional: Set the color of the underline
                              decorationThickness: 2.0,
                              /*decorationPadding: EdgeInsets.only(bottom: 5.0),*/
                              // Optional: Set the thickness of the underline
                            ),
                          )),
                    ],
                  ),
                  SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
              GetBuilder<HomeController>(
                builder: (onBoardingController) =>
                onBoardingController.newsCategoryListModel!=null &&  onBoardingController.newsCategoryListModel.data.length>0?

                Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 30,
                          child:
                          /*   categoryController.categoryList != null ?*/
                          ListView.builder(
                            controller: _scrollController,
                            itemCount: onBoardingController.newsCategoryListModel.data.length,
                            padding: EdgeInsets.only(
                                left: Dimensions.PADDING_SIZE_SMALL),
                            /* physics: BouncingScrollPhysics(),*/
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.only(
                                    right:
                                    Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(35.0),
                                  border: Border.all(
                                      width: 1,
                                      color: Theme
                                          .of(context)
                                          .disabledColor),
                                  color: index == onBoardingController.selectedCategoryIndex
                                      ? Theme
                                      .of(context)
                                      .primaryColor
                                      : Colors.white,
                                ),
                                child: InkWell(
                              onTap: () {
                              onBoardingController.changeCategorySelectIndex(index);
                              },
                              child:
                                Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: Dimensions.PADDING_SIZE_DEFAULT,
                                        right:
                                        Dimensions.PADDING_SIZE_DEFAULT),
                                    child: Text(
                                      onBoardingController.newsCategoryListModel.data[index].name,
                                      style:
                                      robotoMedium.copyWith(fontSize: 11),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                )),
                              );
                            },
                          ) /*: CategoryShimmer(categoryController: categoryController)*/,
                        ),
                      ),
                    ],
                  ):SizedBox()),

                  SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),

                  /* Expanded(
                        child:*/
              GetBuilder<HomeController>(
                builder: (onBoardingController) =>
                onBoardingController.newsListModel!=null && onBoardingController.newsListModel.data.docs.length>0 ?

                Container(
                      height: MediaQuery.of(context).size.height,
                      child:
                      ListView.builder(
                        /*controller: _scrollController,*/
                        itemCount: onBoardingController.newsListModel.data.docs.length,
                        padding:
                        EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return  InkWell(
                              onTap: () { Get.toNamed(RouteHelper.getNewsDetailScreen());},
                          child:
                            Container(
                            margin: EdgeInsets.only(
                                top: Dimensions.PADDING_SIZE_SMALL),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              border: Border.all(
                                  width: 1,
                                  color: Theme
                                      .of(context)
                                      .disabledColor),
                              color: Colors.white,
                            ),
                            child: Column(children: [
                              Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Container(
                                        padding: EdgeInsets.all(
                                            Dimensions.PADDING_SIZE_SMALL),
                                        child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  onBoardingController.newsListModel.data.docs[index].title,
                                                  style: robotoBold.copyWith(
                                                      fontSize: Dimensions
                                                          .fontSizeDefault /*context.height*0.022*/),
                                                  textAlign: TextAlign.start,
                                                ),
                                              ),
                                              SizedBox(
                                                  height: Dimensions
                                                      .PADDING_SIZE_EXTRA_SMALL),
                                        Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                                onBoardingController.newsListModel.data.docs[index].description,
                                                style: robotoRegular.copyWith(
                                                    fontSize: Dimensions
                                                        .fontSizeDefault /*context.height*0.015*/,
                                                    color: Theme
                                                        .of(context)
                                                        .hintColor),
                                                textAlign: TextAlign.start,
                                              )),
                                              SizedBox(
                                                  height: Dimensions
                                                      .PADDING_SIZE_EXTRA_SMALL),
                                              Row(children: [
                                                Text("By :",
                                                    style: robotoMedium
                                                        .copyWith(
                                                        color: Theme
                                                            .of(context)
                                                            .hintColor,
                                                        fontSize: Dimensions
                                                            .fontSizeDefault)),
                                                Text(onBoardingController.newsListModel.data.docs[index].category.name,
                                                    style: robotoBold.copyWith(
                                                        color: Theme
                                                            .of(context)
                                                            .hintColor,
                                                        fontSize: Dimensions
                                                            .fontSizeDefault))
                                              ]),
                                            ])),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child:
                                   /* Image.asset(
                                      Images.homepagetopslider,
                                      height: 150 *//*context.height * 0.3*//*,
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width,
                                      fit: BoxFit.fill,
                                    ),*/
                                    CustomImage(
                                      fit: BoxFit.cover,
                                      height:
                                      150,
                                      image: onBoardingController.newsListModel.data.docs[index].image,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                  height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                              Container(
                                  padding: EdgeInsets.all(
                                      Dimensions.PADDING_SIZE_SMALL),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(Images.calendar),
                                      SizedBox(
                                          width: Dimensions
                                              .PADDING_SIZE_EXTRA_SMALL),
                                      Text("21 Dec 2021 ",
                                          style: robotoMedium.copyWith(
                                              color: Theme
                                                  .of(context)
                                                  .hintColor,
                                              fontSize:
                                              Dimensions.fontSizeDefault)),
                                      SizedBox(
                                          width: Dimensions
                                              .PADDING_SIZE_EXTRA_SMALL),
                                      SvgPicture.asset(Images.clock),
                                      SizedBox(
                                          width: Dimensions
                                              .PADDING_SIZE_EXTRA_SMALL),
                                      Text(
                                        "3:51 am",
                                        textAlign: TextAlign.right,
                                      ),
                                    ],
                                  )),
                            ]),
                          ));
                        },
                      )):SizedBox()),


                  SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),

                ],
              ),
            ))
            : NotLoggedInScreen(),
      );
    });
  }



}