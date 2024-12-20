import 'package:flutter_svg/flutter_svg.dart';
import 'package:sixam_mart/controller/auth_controller.dart';
import 'package:sixam_mart/controller/notification_controller.dart';
import 'package:sixam_mart/controller/splash_controller.dart';
import 'package:sixam_mart/view/base/custom_app_bar.dart';
import 'package:sixam_mart/view/base/no_data_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/view/screens/notification/widget/notification_dialog.dart';

import '../../../helper/date_converter.dart';
import '../../../util/dimensions.dart';
import '../../../util/images.dart';
import '../../../util/styles.dart';
import '../../base/custom_image.dart';
import '../../base/footer_view.dart';
import '../../base/not_logged_in_screen.dart';
import '../../base/paginated_list_view.dart';


class NotificationScreen extends StatefulWidget {
  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  void _loadData() async {
    Get.find<NotificationController>().clearNotification();
   /* if (Get.find<SplashController>().configModel == null) {
      await Get.find<SplashController>().getConfigData();
    }*/
    if (Get.find<AuthController>().isLoggedIn()) {
      Get.find<NotificationController>().getNotificationList(0, true);
    }
  }

  @override
  void initState() {
    super.initState();

    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    return Scaffold(
      appBar: CustomAppBar(
              title: 'notification'.tr,
              )
          ,
        body: Get.find<AuthController>().isLoggedIn()
          ?
      GetBuilder<NotificationController>(
              builder: (notificationController) {
              if (notificationController.notificationList != null) {
                notificationController.saveSeenNotificationCount(
                    notificationController.notificationList.data.length);
              }
              List<DateTime> _dateTimeList = [];
              return notificationController.notificationList != null
                  ? notificationController.notificationList.data.length > 0
                      ? RefreshIndicator(
                          onRefresh: () async {
                            await notificationController.getNotificationList(
                                1, true);
                          },
                          child: NotificationListener<
                                  OverscrollIndicatorNotification>(
                              onNotification:
                                  (OverscrollIndicatorNotification overscroll) {
                                overscroll.disallowGlow();
                                return;
                              },
                              child:
                              Scrollbar(
                                  child: SingleChildScrollView(
                                controller: scrollController,
                                physics: AlwaysScrollableScrollPhysics(),
                                child: FooterView(
                                  child: SizedBox(
                                      width: Dimensions.WEB_MAX_WIDTH,
                                      child: PaginatedListView(
                                          scrollController: scrollController,
                                          onPaginate: (int offset) {
                                            print("offset..." +
                                                offset.toString());
                                            Get.find<NotificationController>()
                                                .getNotificationList(
                                                    offset, true);
                                          },
                                          totalSize: notificationController
                                              .notificationList.data.length,
                                          offset: notificationController.offset,
                                          itemView: ListView.builder(
                                            itemCount: notificationController
                                                .notificationList.data.length,
                                            padding: EdgeInsets.all(
                                                Dimensions.PADDING_SIZE_SMALL),
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {

                                              return Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [


                                                      Padding(
                                                        padding: EdgeInsets.symmetric(
                                                            vertical: Dimensions
                                                                .PADDING_SIZE_EXTRA_SMALL),
                                                        child: Row(children: [
                                                          ClipOval(
                                                              child:
                                                                  Image.asset(Images.defult_user_png,
                                                            height: 40,
                                                            width: 40,
                                                            fit: BoxFit.cover,

                                                          )),
                                                          SizedBox(
                                                              width: Dimensions
                                                                  .PADDING_SIZE_SMALL),
                                                          Expanded(
                                                              child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                Text(
                                                                  notificationController
                                                                          .notificationList.data[
                                                                              index]
                                                                      .title ??
                                                                      '',
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: robotoBold
                                                                      .copyWith(
                                                                          fontSize:
                                                                              Dimensions.fontSizeDefault),
                                                                ),
                                                                SizedBox(height: 5,),
                                                                Text(
                                                                  notificationController
                                                                          .notificationList.data[
                                                                              index]
                                                                          .notification_text ??
                                                                      '',
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: robotoRegular
                                                                      .copyWith(
                                                                          fontSize:
                                                                              Dimensions.fontSizeSmall,color: Theme.of(context).backgroundColor.withOpacity(0.5)),
                                                                ),
                                                              ])),
                                                          Padding(
                                                            padding: EdgeInsets.only(
                                                                bottom: Dimensions
                                                                    .PADDING_SIZE_EXTRA_SMALL),
                                                            child: Text(DateConverter
                                                                .convertToTimeAgo(
                                                                notificationController
                                                                    .notificationList.data[
                                                                index]
                                                                    .createdAt),style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall),),
                                                          )
                                                        ]),
                                                      ),

                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 50),
                                                      child: Divider(
                                                          color: Theme.of(
                                                                  context)
                                                              .disabledColor,
                                                          thickness: 1),
                                                    ),
                                                  ]);
                                            },
                                          ))),
                                ),
                              ))),
                        )
                      : NoDataScreen(
                          text: 'no_notification_found'.tr, showFooter: true)
                  : Center(child: CircularProgressIndicator());
            })
          : NotLoggedInScreen()
     /* NoDataScreen(
          text: 'no_notification_found'.tr, showFooter: true),*/
    );
  }
}
