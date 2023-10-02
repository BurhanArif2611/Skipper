import 'package:flutter_svg/svg.dart';
import 'package:sixam_mart/controller/auth_controller.dart';
import 'package:sixam_mart/controller/dashboard_controller.dart';
import 'package:sixam_mart/controller/home_controller.dart';
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
import '../../../controller/store_controller.dart';
import '../../../data/model/response/order_model.dart';
import '../../../helper/responsive_helper.dart';
import '../../../helper/route_helper.dart';
import '../../../util/images.dart';
import '../../base/confirmation_dialog.dart';
import '../../base/custom_button.dart';
import '../../base/custom_text_field.dart';
import '../../base/inner_custom_app_bar.dart';
import '../../base/logout_confirmation.dart';
import '../../base/paginated_list_view.dart';
import '../profile/widget/profile_bg_widget.dart';

class SOSContactScreen extends StatefulWidget {
  @override
  State<SOSContactScreen> createState() => _SOSContactScreenState();
}

class _SOSContactScreenState extends State<SOSContactScreen>
    with WidgetsBindingObserver {
  void _loadData() async {
    Get.find<HomeController>().getSOSContactList();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _loadData();
  }

  @override
  void dispose() {
    // Remove the observer in the dispose method
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('App paused>>>>${state.toString()} ');
    if (state == AppLifecycleState.paused) {
      // Implement your onPause logic here
      print('App paused');
    }
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    return Scaffold(
      appBar: InnerCustomAppBar(
        title: 'SOS Contacts'.tr,
        leadingIcon: Images.circle_arrow_back,
        backButton: !ResponsiveHelper.isDesktop(context),
      ),
      /* endDrawer: MenuDrawer(),*/
      body: Get.find<AuthController>().isLoggedIn()
          ? !Get.find<AuthController>().isLoading
              ? Container(
                  height: MediaQuery.of(context).size.height,
                  padding: EdgeInsets.all(Dimensions.RADIUS_DEFAULT),
                  margin: EdgeInsets.all(Dimensions.RADIUS_DEFAULT),
                  child: Center(
                    child: Column(children: [
                      SizedBox(
                        height: Dimensions.RADIUS_LARGE,
                      ),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Add 3 Mobile Numbers",
                            textAlign: TextAlign.left,
                            style: robotoBold.copyWith(
                                color: Theme.of(context).hintColor,
                                fontSize: Dimensions.fontSizeLarge),
                          )),
                      SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                      /* Spacer(),*/
                      GetBuilder<HomeController>(
                          builder: (onBoardingController) =>
                              onBoardingController.sosContactListModel != null
                                  ? Container(
                                      height: 500,
                                      /*color: Colors.red,*/
                                      child: ListView.builder(
                                        /*controller: _scrollController,*/
                                        itemCount: onBoardingController
                                            .sosContactListModel.data.length,
                                        padding: EdgeInsets.all(Dimensions
                                            .PADDING_SIZE_EXTRA_SMALL),
                                        physics: ScrollPhysics(),
                                        scrollDirection: Axis.vertical,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            margin: EdgeInsets.only(
                                                top: Dimensions
                                                    .PADDING_SIZE_SMALL),
                                            padding: EdgeInsets.all(
                                                Dimensions.PADDING_SIZE_SMALL),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              border: Border.all(
                                                  width: 1,
                                                  color: Theme.of(context)
                                                      .disabledColor),
                                              color: Colors.white,
                                            ),
                                            child:
                                            Row(
                                                children: [
                                                  Expanded(
                                                  flex: 5,
                                                  child:Container(
                                                      child:
                                                  Column(
                                                    children: [
                                                      SizedBox(
                                                          height: Dimensions
                                                              .PADDING_SIZE_EXTRA_SMALL),
                                                      Row( mainAxisSize: MainAxisSize.min,
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                        SvgPicture.asset(
                                                            Images.defult_user),
                                                        SizedBox(
                                                            width: Dimensions
                                                                .PADDING_SIZE_EXTRA_SMALL),
                                                            Flexible(
                                                                flex: 2, // Adjust flex values as needed
                                                                child:Wrap(
                                                            direction:
                                                                Axis.horizontal,
                                                            children: [
                                                              Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .centerLeft,
                                                                  child: Text(
                                                                    onBoardingController
                                                                        .sosContactListModel
                                                                        .data[
                                                                            index]
                                                                        .name,
                                                                    style: robotoBold.copyWith(
                                                                        fontSize:
                                                                            Dimensions
                                                                                .fontSizeLarge /*context.height*0.015*/,
                                                                        color: Theme.of(context)
                                                                            .hintColor),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                  ))
                                                            ])),
                                                      ]),
                                                      SizedBox(
                                                          height: Dimensions
                                                              .PADDING_SIZE_DEFAULT),
                                                      Row(children: [
                                                        SvgPicture.asset(
                                                            Images.phone_call),
                                                        SizedBox(
                                                            width: Dimensions
                                                                .PADDING_SIZE_EXTRA_SMALL),
                                                        Flexible(
                                                            flex: 1,
                                                        child:
                                                        Wrap(
                                                          direction:
                                                              Axis.horizontal,
                                                          children: [
                                                            Align(
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                child: Text(
                                                                  onBoardingController
                                                                      .sosContactListModel
                                                                      .data[
                                                                          index]
                                                                      .number,
                                                                  style: robotoRegular.copyWith(
                                                                      fontSize:
                                                                          Dimensions
                                                                              .fontSizeDefault /*context.height*0.015*/,
                                                                      color: Theme.of(
                                                                              context)
                                                                          .hintColor),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .start,
                                                                ))
                                                          ],
                                                        )),

                                                        SizedBox(
                                                            width: Dimensions
                                                                .PADDING_SIZE_DEFAULT),
                                                        Flexible(
                                                            flex: 2,
                                                        child:Container(
                                                        child:
                                                        Text(
                                                          " (${onBoardingController.sosContactListModel.data[index].relation} )",
                                                          style: robotoRegular.copyWith(
                                                              fontSize:
                                                              Dimensions
                                                                  .fontSizeDefault /*context.height*0.015*/,
                                                              color: Theme.of(
                                                                  context)
                                                                  .hintColor),
                                                          overflow: TextOverflow.ellipsis,
                                                          maxLines: 2,
                                                          textAlign:
                                                          TextAlign
                                                              .start,
                                                        ))),

                                                      ]),
                                                    ],
                                                  ))),

                                              Expanded(
                                                flex: 1,
                                                child: Container(
                                                  child:
                                                InkWell(
                                                    onTap: () {
                                                      onBoardingController
                                                          .deleteSOSContact(
                                                              onBoardingController
                                                                  .sosContactListModel
                                                                  .data[index]
                                                                  .sId);
                                                    },
                                                    child: SvgPicture.asset(
                                                      Images.circle_cancel,
                                                      color: Colors.grey,
                                                    ))),
                                              ),
                                            ]),
                                          );
                                        },
                                      ))
                                  : SizedBox()),
                      GetBuilder<HomeController>(
                          builder: (onBoardingController) =>
                              onBoardingController.sosContactListModel !=
                                          null &&
                                      onBoardingController
                                              .sosContactListModel.data.length <
                                          3
                                  ? Expanded(
                                      child: Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 80,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image:
                                                  AssetImage(Images.button_bg),
                                            ),
                                          ),
                                          child: InkWell(
                                              onTap: () {
                                                Get.toNamed(RouteHelper
                                                    .getAddContactRoute());
                                              },
                                              child: Align(
                                                  alignment: Alignment.center,
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      SvgPicture.asset(
                                                          Images.plus),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        "Add Number",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: robotoMedium
                                                            .copyWith(
                                                                color: Theme.of(
                                                                        context)
                                                                    .hintColor),
                                                      ),
                                                    ],
                                                  ))), // Your other content here, if any
                                        ),
                                      ),
                                    )
                                  : SizedBox()),
                    ]),
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                )) /*)*/ /*)*/
          : NotLoggedInScreen(),
    );
  }
}
