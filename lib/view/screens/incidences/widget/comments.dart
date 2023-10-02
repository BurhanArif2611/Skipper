import 'package:flutter_svg/flutter_svg.dart';
import 'package:sixam_mart/controller/search_controller.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/view/base/footer_view.dart';
import 'package:sixam_mart/view/base/item_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/home_controller.dart';
import '../../../../controller/splash_controller.dart';
import '../../../base/custom_image.dart';
import '../../../base/custom_snackbar.dart';
import '../../../base/custom_text_field.dart';
import 'package:timeago/timeago.dart' as timeago;

class Comments extends StatelessWidget {
  final bool isItem;
  final HomeController homeController;
  final String incidence_id;
  bool securityOfficer=false;
  ScrollController _scrollController = ScrollController();


  Comments(
      {@required this.isItem,
      @required this.homeController,
      @required this.incidence_id});

  final TextEditingController _firstNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    timeago.setLocaleMessages('en', timeago.EnMessages());
    securityOfficer=Get.find<SplashController>().isSecurityOfficer;
    return Scaffold(
      body: GetBuilder<HomeController>(builder: (homeController) {
        return SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Container(
              height: MediaQuery.of(context).size.height-450,
              width: MediaQuery.of(context).size.width,
            /* *//*Theme.of(context).cardColor*//*,*/
              child:
              Column(
                children: [
                  Expanded(
                      flex: 6,
                      child: ListView.builder(
                        controller: _scrollController,
                        itemCount: homeController.commentList.docs.length,
                        padding:
                            EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                        physics: AlwaysScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return Container(
                              margin: EdgeInsets.only(
                                  top: Dimensions.PADDING_SIZE_LARGE),
                              padding: EdgeInsets.only(
                                  top: Dimensions.PADDING_SIZE_SMALL),
                              child: Column(
                                children: [
                                Align(alignment: Alignment.centerLeft,
                                child:
                                  Wrap(
                                    alignment: WrapAlignment.start,
                                    children: [
                                     /* SvgPicture.asset(Images.circle_user),*/
                                     Container(
                              width: 30, // Set the desired width
                                height: 30, // Set the desired height
                                child:
                                ClipOval(
                                          child: CustomImage(
                                            image:  homeController.commentList.docs[index].user.image,
                                            height: 30,
                                            width: 30,
                                            fit: BoxFit.cover,
                                          ))),
                                      SizedBox(
                                        width: Dimensions.PADDING_SIZE_SMALL,
                                      ),

                                      Text(
                                        homeController.commentList.docs[index].user
                                                .name.first +
                                            " " +
                                            homeController.commentList.docs[index]
                                                .user.name.last,
                                        style: robotoBold.copyWith(
                                            color: Theme.of(context).hintColor),
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(
                                        width: Dimensions.PADDING_SIZE_SMALL,
                                      ),
                                      Text(
                                        timeago.format(
                                            DateTime.parse(homeController
                                                .commentList.docs[index].createdAt),
                                            locale: 'en'),
                                        style: robotoBold.copyWith(
                                            color: Theme.of(context)
                                                .hintColor
                                                .withOpacity(0.3)),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  )),
                                  SizedBox(
                                    height: Dimensions.PADDING_SIZE_SMALL,
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child:
                                    Text(
                                      homeController.commentList.docs[index].text,
                                      style: robotoMedium.copyWith(
                                          color: Theme.of(context).hintColor,
                                          fontSize: Dimensions.fontSizeLarge),
                                    ),
                                  ),
                                ],
                              ));
                        },
                      )),
                  !securityOfficer?Expanded(
                      flex: 2,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.only(
                            top: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                            left: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(35)),
                            border: Border.all(
                                width: 0.5, color: Theme.of(context).hintColor),
                            color: Theme.of(context).cardColor),
                        margin: EdgeInsets.only(
                            top: Dimensions.PADDING_SIZE_SMALL,
                            bottom: Dimensions.PADDING_SIZE_LARGE),
                        child:
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 5,
                              child:
                              Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(top: 5),
                                  child:
                              Align(alignment: Alignment.center,
                                  child: CustomTextField(
                                hintText: 'Text here ……'.tr,
                                controller: _firstNameController,
                                inputType: TextInputType.multiline,
                                prefixIcon: null,
                                inputAction: TextInputAction.done,
                                divider: false,

                              ))),
                            ),
                            Expanded(
                                flex: 1,
                                child: InkWell(
                                    onTap: () {
                                      String _firstName =
                                          _firstNameController.text;
                                      if (_firstName.isEmpty) {
                                        showCustomSnackBar(
                                            'enter_your_first_name'.tr);
                                      } else {
                                        homeController.addIncidenceComment(
                                            incidence_id, _firstName);
                                        _scrollController.animateTo(
                                          _scrollController.position.maxScrollExtent,
                                          duration: Duration(milliseconds: 300), // Adjust the duration as needed
                                          curve: Curves.easeOut,
                                        );
                                      }
                                    },
                                    child: SvgPicture.asset(Images.send_chat)))
                          ],
                        ),
                      )):SizedBox(),
                ],
              )),
        );
      }),
    );
  }
}
