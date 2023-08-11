import 'package:flutter_svg/svg.dart';
import 'package:sixam_mart/controller/auth_controller.dart';
import 'package:sixam_mart/controller/notification_controller.dart';
import 'package:sixam_mart/controller/splash_controller.dart';
import 'package:sixam_mart/helper/date_converter.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/styles.dart';

import 'package:sixam_mart/view/base/menu_drawer.dart';
import 'package:sixam_mart/view/base/no_data_screen.dart';
import 'package:sixam_mart/view/base/not_logged_in_screen.dart';
import 'package:sixam_mart/view/screens/notification/widget/notification_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../helper/responsive_helper.dart';
import '../../../util/images.dart';
import '../../base/confirmation_dialog.dart';
import '../../base/custom_button.dart';
import '../../base/custom_text_field.dart';
import '../../base/inner_custom_app_bar.dart';
import '../../base/paginated_list_view.dart';

class ReportIncidenceScreen extends StatefulWidget {
  @override
  State<ReportIncidenceScreen> createState() => _ReportIncidenceScreenState();
}

class _ReportIncidenceScreenState extends State<ReportIncidenceScreen> {
  final List<String> items = ['Thugs', 'Flight', 'Ballot Snatching', 'Others'];
  String selectedItem = 'Item 1';

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
    return GetBuilder<SplashController>(builder: (splashController) {
      return Scaffold(
        appBar: InnerCustomAppBar(
          title: 'Report Incidence'.tr,
          leadingIcon: Images.circle_arrow_back,
          backButton: !ResponsiveHelper.isDesktop(context),
        ),
        endDrawer: MenuDrawer(),
        body: SingleChildScrollView(
            controller: scrollController,
            physics: AlwaysScrollableScrollPhysics(),
            child: Container(
              margin: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding:
                        EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(35)),
                        border: Border.all(
                            width: 0.4, color: Theme.of(context).hintColor),
                        color: Theme.of(context).cardColor),
                    child: DropdownButton<String>(
                      value: selectedItem,
                      items: items.map((item) {
                        return DropdownMenuItem<String>(
                          value: item,
                          child: Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              margin: EdgeInsets.only(right: 5),
                              padding: EdgeInsets.all(
                                  Dimensions.PADDING_SIZE_EXTRA_SMALL),
                              child: Text(
                                item,
                                style: robotoMedium.copyWith(
                                    color: Theme.of(context).hintColor),
                              )),
                        );
                      }).toList(),
                      dropdownColor: Theme.of(context).cardColor,
                      icon: Icon(Icons.keyboard_arrow_down),
                      elevation: 0,
                      iconSize: 30,
                      underline: SizedBox(),
                      onChanged: (index) {
                        print("selected length>>>${index}");
                        selectedItem = index;
                        // localizationController.setLanguage(Locale(AppConstants.languages[index].languageCode, AppConstants.languages[index].countryCode));
                      },
                    ),
                  ),
                  SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Upload Images or Videos",
                      style: robotoRegular.copyWith(
                          color: Theme.of(context).hintColor,
                          fontSize: Dimensions.fontSizeLarge),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
              InkWell(
                onTap: () {

                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        height: 320,
                          padding: EdgeInsets.all(
                             Dimensions.RADIUS_SMALL,
                              ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20)),
                              border: Border.all(
                                  width: 1,
                                  color: Theme.of(context).cardColor),
                              color: Theme.of(context).cardColor),
                         // Set the desired height of the bottom sheet
                        child: Column(children: [
                          SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                         Center(child: SvgPicture.asset(Images.bottom_sheet_line),),
                          SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                          Align(alignment: Alignment.topLeft,
                            child:
                          Text('Choose For Attach File '.tr,
                              textAlign: TextAlign.center,
                              style: robotoBold.copyWith(
                                color:  Theme.of(context).hintColor,
                                fontSize: Dimensions.fontSizeExtraLarge,
                              )),),
                          SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.only(
                                left: Dimensions.RADIUS_SMALL,
                                right: Dimensions.RADIUS_SMALL),
                            margin: EdgeInsets.all(
                               Dimensions.RADIUS_SMALL,
                                ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                  width: 1,
                                  color: Theme.of(context).disabledColor),
                              color: Colors.transparent,
                            ),
                            child: Row(children: [
                              SizedBox(width: 10),
                              SvgPicture.asset(Images.gallery_image),
                              Expanded(
                                  child: TextButton(
                                    onPressed: () => {
                                     // authController.changeLogin(),
                                    },
                                    child: Text('Choose picture of gallery'.tr,
                                        textAlign: TextAlign.center,
                                        style: robotoBold.copyWith(
                                          color:  Theme.of(context).hintColor,
                                          fontSize: Dimensions.fontSizeLarge,
                                        )),
                                  )),
                              Image.asset(Images.arrow_right_normal,
                                  height: 10, fit: BoxFit.contain),
                              SizedBox(width: 10),
                            ]),
                          ),
                          SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT), Container(
                            width: double.infinity,
                            padding: EdgeInsets.only(
                                left: Dimensions.RADIUS_SMALL,
                                right: Dimensions.RADIUS_SMALL),
                            margin: EdgeInsets.all(
                               Dimensions.RADIUS_SMALL,
                                ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                  width: 1,
                                  color: Theme.of(context).disabledColor),
                              color: Colors.transparent,
                            ),
                            child: Row(children: [
                              SizedBox(width: 10),
                              SvgPicture.asset(Images.take_photo),
                              Expanded(
                                  child: TextButton(
                                    onPressed: () => {
                                     // authController.changeLogin(),
                                    },
                                    child: Text('Take a photo'.tr,
                                        textAlign: TextAlign.center,
                                        style: robotoBold.copyWith(
                                          color:  Theme.of(context).hintColor,
                                          fontSize: Dimensions.fontSizeLarge,
                                        )),
                                  )),
                              Image.asset(Images.arrow_right_normal,
                                  height: 10, fit: BoxFit.contain),
                              SizedBox(width: 10),
                            ]),
                          ),
                          SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.only(
                                left: Dimensions.RADIUS_SMALL,
                                right: Dimensions.RADIUS_SMALL),
                            margin: EdgeInsets.all(
                               Dimensions.RADIUS_SMALL,
                                ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                  width: 1,
                                  color: Theme.of(context).disabledColor),
                              color: Colors.transparent,
                            ),
                            child: Row(children: [
                              SizedBox(width: 10),
                              SvgPicture.asset(Images.voice_record),
                              Expanded(
                                  child: TextButton(
                                    onPressed: () => {
                                     // authController.changeLogin(),
                                    },
                                    child: Text('Voice Record'.tr,
                                        textAlign: TextAlign.center,
                                        style: robotoBold.copyWith(
                                          color:  Theme.of(context).hintColor,
                                          fontSize: Dimensions.fontSizeLarge,
                                        )),
                                  )),
                              Image.asset(Images.arrow_right_normal,
                                  height: 10, fit: BoxFit.contain),
                              SizedBox(width: 10),
                            ]),
                          ),
                          SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                        ],)
                      );
                    },
                    backgroundColor: Colors.transparent
                  );
                  },
                child:
                  Image.asset(
                    Images.add_photo,
                    fit: BoxFit.fill,
                    width: MediaQuery.of(context).size.width,
                  )),
                  SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "About Incidence",
                      style: robotoRegular.copyWith(
                          color: Theme.of(context).hintColor,
                          fontSize: Dimensions.fontSizeLarge),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder:  OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide:  BorderSide(color: Theme.of(context).hintColor, width: 0.4),
                      ),
                      counterText: "",
                      isDense: true,
                      hintText: "Enter description",
                      fillColor: Theme.of(context).cardColor,
                      hintStyle: robotoRegular.copyWith(fontSize: Dimensions.fontSizeLarge, color: Color(0xFFA1A8B0)),
                      filled: true,
                    ),
                    maxLines: 5,

                  ),
                  SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
              Row(mainAxisSize: MainAxisSize.max,
                  children: [
                Checkbox(
                  activeColor: Theme.of(context).primaryColor,
                  value: true,
                  onChanged: (bool isChecked) =>(){} /*authController.toggleTerms()*/,
                ),
                Text('Post as anonymous'.tr, style: robotoRegular),

              ]),
                  SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                  CustomButton(
                    buttonText: 'Submit Report'.tr,
                    onPressed: () =>(){} /*_login(
                        authController, _countryDialCode)*/
                    ,
                  )
                ],
              ),
            )),
      );
    });
  }
}
