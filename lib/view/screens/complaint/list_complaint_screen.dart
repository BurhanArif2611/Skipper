import 'package:flutter_svg/svg.dart';
import 'package:sixam_mart/controller/auth_controller.dart';
import 'package:sixam_mart/controller/complaint_controller.dart';
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

import '../../../helper/responsive_helper.dart';
import '../../../helper/route_helper.dart';
import '../../../util/images.dart';
import '../../base/confirmation_dialog.dart';
import '../../base/custom_button.dart';
import '../../base/custom_text_field.dart';
import '../../base/inner_custom_app_bar.dart';
import 'package:timeago/timeago.dart' as timeago;

class ListComplaintScreen extends StatefulWidget {
  @override
  State<ListComplaintScreen> createState() => _ListComplaintScreenState();
}

class _ListComplaintScreenState extends State<ListComplaintScreen>
    with WidgetsBindingObserver {
  void _loadData() async {
    Get.find<ComplaintController>().getComplaintList();
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
    timeago.setLocaleMessages('en', timeago.EnMessages());
    final ScrollController scrollController = ScrollController();
    return Scaffold(
      appBar: InnerCustomAppBar(
        title: 'Complaints'.tr,
        leadingIcon: Images.circle_arrow_back,
        backButton: !ResponsiveHelper.isDesktop(context),
      ),
      endDrawer: MenuDrawer(),
      body: Get.find<AuthController>().isLoggedIn()
          ? !Get.find<ComplaintController>().isLoading
              ? Container(
                  height: MediaQuery.of(context).size.height,
                  padding: EdgeInsets.all(Dimensions.RADIUS_SMALL),
                  margin: EdgeInsets.all(Dimensions.RADIUS_SMALL),
                  child: GetBuilder<ComplaintController>(
                      builder: (onBoardingController) => onBoardingController
                                  .complaintlistarray !=
                              null
                          ? Container(
                              height: MediaQuery.of(context).size.height,
                              padding: EdgeInsets.only(
                                  bottom: Dimensions.PADDING_SIZE_EXTRA_LARGE),
                              child: ListView.builder(
                                /*controller: _scrollController,*/
                                itemCount: onBoardingController
                                    .complaintlistarray.docs.length,
                                padding: EdgeInsets.all(
                                    Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                physics: ScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) {
                                  String status = "";
                                  if (onBoardingController.complaintlistarray
                                          .docs[index].status ==
                                      1) {
                                    status = "Un Assign";
                                  } else if (onBoardingController
                                          .complaintlistarray
                                          .docs[index]
                                          .status ==
                                      2) {
                                    status = "Assign";
                                  } else if (onBoardingController
                                          .complaintlistarray
                                          .docs[index]
                                          .status ==
                                      3) {
                                    status = "Resolve";
                                  }
                                  return Container(
                                    margin: EdgeInsets.only(
                                        top: Dimensions.PADDING_SIZE_SMALL),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      border: Border.all(
                                          width: 1,
                                          color:
                                              Theme.of(context).disabledColor),
                                      color: Colors.white,
                                    ),
                                    child: Stack(children: [
                                      Container(
                                        padding: EdgeInsets.all(
                                            Dimensions.PADDING_SIZE_SMALL),
                                        child: Column(
                                          children: [
                                            Container(
                                                height: 150,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: (onBoardingController
                                                                .complaintlistarray
                                                                .docs[index]
                                                                .image !=
                                                            null &&
                                                        onBoardingController
                                                                .complaintlistarray
                                                                .docs[index]
                                                                .image
                                                                .length >
                                                            0
                                                    ? CustomImage(
                                                        fit: BoxFit.fitWidth,
                                                        image: onBoardingController
                                                            .complaintlistarray
                                                            .docs[index]
                                                            .image,
                                                      )
                                                    : Image.asset(
                                                        Images.no_data_found,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.15,
                                                        height: 150,
                                                      ))),
                                            SizedBox(
                                                height: Dimensions
                                                    .PADDING_SIZE_EXTRA_SMALL),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                onBoardingController
                                                            .complaintlistarray
                                                            .docs[index]
                                                            .complaint !=
                                                        null
                                                    ? onBoardingController
                                                        .complaintlistarray
                                                        .docs[index]
                                                        .complaint
                                                    : "",
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
                                                alignment:
                                                    Alignment.bottomRight,
                                                child: Text(
                                                  timeago.format(
                                                      DateTime.parse(
                                                          onBoardingController
                                                              .complaintlistarray
                                                              .docs[index]
                                                              .createdAt),
                                                      locale: 'en'),
                                                  style: robotoRegular.copyWith(
                                                      fontSize: Dimensions
                                                          .fontSizeDefault /*context.height*0.015*/,
                                                      color: Theme.of(context)
                                                          .hintColor),
                                                  textAlign: TextAlign.start,
                                                )),
                                            SizedBox(
                                                height: Dimensions
                                                    .PADDING_SIZE_EXTRA_SMALL),
                                            (status == "Un Assign"
                                                ? Align(
                                                    alignment:
                                                        Alignment.bottomRight,
                                                    child: InkWell(
                                                        onTap: () {
                                                          //  onBoardingController.deleteSOSContact(onBoardingController.sosContactListModel.data[index].sId);
                                                          showConfirmPopup(
                                                              onBoardingController,onBoardingController
                                                              .complaintlistarray
                                                              .docs[index]
                                                              .sId);
                                                        },
                                                        child: Container(
                                                            margin: EdgeInsets.only(
                                                                top: Dimensions
                                                                    .PADDING_SIZE_SMALL),
                                                            padding: EdgeInsets
                                                                .all(Dimensions
                                                                    .PADDING_SIZE_EXTRA_SMALL),
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                              border: Border.all(
                                                                  width: 1,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .disabledColor),
                                                              color: Colors.red,
                                                            ),
                                                            child: Text(
                                                              "Delete Complaint",
                                                              style:
                                                                  robotoMedium
                                                                      .copyWith(
                                                                color: Theme.of(
                                                                        context)
                                                                    .cardColor,
                                                              ),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ))))
                                                : SizedBox()),
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                        top: 0,
                                        right: 0,
                                        child: Stack(
                                          children: [
                                            SvgPicture.asset(
                                              Images.batch,
                                              color: status == "Un Assign"
                                                  ? Colors.red
                                                  : status == "Assign"
                                                      ? Colors.yellow
                                                      : status == "Resolve"
                                                          ? Colors.green
                                                          : Theme.of(context)
                                                              .primaryColor,
                                            ),
                                            Positioned(
                                                right: 0,
                                                left: 0,
                                                child: Align(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      status,
                                                      style:
                                                          robotoMedium.copyWith(
                                                        color: Theme.of(context)
                                                            .cardColor,
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                    )))
                                          ],
                                        ),
                                      ),
                                    ]),
                                  );
                                },
                              ))
                          : SizedBox()),
                )
              : Center(
                  child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                )) /*)*/ /*)*/
          : NotLoggedInScreen(),
      floatingActionButton: Container(
          width: 75, // Set the desired width here
          height: 75, // Set the desired height here
          child: FloatingActionButton(
            onPressed: () {
              // Add the action you want to perform when the FAB is pressed
              // For example, navigate to another page or show a dialog.
              print('Floating Action Button Pressed');
              Get.toNamed(RouteHelper.getAddComplaintRoute());
            },
            child: SvgPicture.asset(
              Images.plus,
              color: Theme.of(context).cardColor,
            ) /*Icon(Icons.add)*/,
            backgroundColor: Theme.of(context).primaryColor,
            // Set the FAB's background color
          )),
    );
  }

  void showConfirmPopup(ComplaintController complaintController,String Id) {
    showDialog(
      context: Get.context,
      builder: (ctx) => AlertDialog(
        title: const Text("Delete Complaint !"),
        content: const Text("Are you sure, you want to delete your complaint."),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Container(
              padding: EdgeInsets.all(14),
              child: Text("Cancel",
                  style: robotoBold.copyWith(
                      color: Theme.of(context).primaryColor)),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              complaintController.deleteSOSContact(Id);
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                border: Border.all(
                    width: 1, color: Theme.of(context).primaryColor),
                color: Theme.of(Get.context).primaryColor,
              ),
              padding: EdgeInsets.all(14),
              child: Text("Confirm", style: robotoBold.copyWith(
                  color: Theme.of(context).cardColor)),
            ),
          ),
        ],
      ),
    );
  }
}
