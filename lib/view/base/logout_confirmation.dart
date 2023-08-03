import 'package:flutter_svg/svg.dart';
import 'package:sixam_mart/controller/order_controller.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/view/base/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

import '../../util/images.dart';

class LogoutConfirmationDialog extends StatelessWidget {
  final String icon;
  final String title;
  final String description;
  final Function onYesPressed;
  final bool isLogOut;
  final Function onNoPressed;

  LogoutConfirmationDialog(
      {@required this.icon,
      this.title,
      @required this.description,
      @required this.onYesPressed,
      this.isLogOut = false,
      this.onNoPressed});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL)),
      insetPadding: EdgeInsets.all(30),
      backgroundColor: Colors.transparent,
      clipBehavior: Clip.hardEdge,
      child: PointerInterceptor(
        child: SizedBox(
            width: 500,
            child: Padding(
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
              child: Column(mainAxisSize: MainAxisSize.min, children: [

                Container(
                  padding: EdgeInsets.all(15),
                  child: Stack( children: [

                    Container(
                      padding: EdgeInsets.all(15),
                      margin: EdgeInsets.only(top:75),

                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(Images.logout_popup_background),
                            fit: BoxFit.cover),

                        borderRadius:
                            BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
                      ),
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                        Padding(
                          padding:
                              EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
                          child: Text(""),
                        ),
                        title != null
                            ? Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: Dimensions.PADDING_SIZE_LARGE),
                                child: Text(
                                  title,
                                  textAlign: TextAlign.center,
                                  style: robotoBold.copyWith(
                                      fontSize: Dimensions.fontSizeExtraLarge,
                                      color: Theme.of(context).primaryColor),
                                ),
                              )
                            : SizedBox(),
                        description!=null && description!=''?
                        Padding(
                          padding:
                              EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
                          child: Text(description,
                              style: robotoMedium.copyWith(
                                  fontSize: Dimensions.fontSizeLarge),
                              textAlign: TextAlign.center),
                        ):SizedBox(),
                        SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                        GetBuilder<OrderController>(builder: (orderController) {
                          return !orderController.isLoading
                              ? Row(children: [
                            Expanded(
                                child: CustomButton(
                                  buttonText: isLogOut ? 'no'.tr : 'yes'.tr,
                                  onPressed: () =>
                                  isLogOut ? Get.back() : onYesPressed(),
                                  radius: Dimensions.RADIUS_SMALL,
                                  height: 50,
                                )),

                                  SizedBox(
                                      width: Dimensions.PADDING_SIZE_LARGE),
                            Expanded(
                                child: TextButton(
                                  onPressed: () =>  isLogOut ? Get.back() : onYesPressed(),
                                  style: TextButton.styleFrom(
                                    backgroundColor: Theme.of(context)
                                        .disabledColor
                                        .withOpacity(0.3),
                                    minimumSize:
                                    Size(Dimensions.WEB_MAX_WIDTH, 50),
                                    padding: EdgeInsets.zero,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.RADIUS_SMALL)),
                                  ),
                                  child: Text(
                                    isLogOut ? 'yes'.tr : 'no'.tr,
                                    textAlign: TextAlign.center,
                                    style: robotoBold.copyWith(
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            .color),
                                  ),
                                )),
                                ])
                              : Center(child: CircularProgressIndicator());
                        }),
                      ]),
                    ),

              Positioned(
                  top: 0,
                  right: 0,
                  left: 0,
                  child:  SvgPicture.asset(Images.logout_popup),
              ),
                  ]),
                ),
              ]),
            )),
      ),
    );
  }
}
