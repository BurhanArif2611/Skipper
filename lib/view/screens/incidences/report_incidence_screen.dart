import 'package:flutter_svg/svg.dart';
import 'package:sixam_mart/controller/auth_controller.dart';
import 'package:sixam_mart/controller/home_controller.dart';
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

import '../../../data/model/body/report_incidence_body.dart';
import '../../../helper/responsive_helper.dart';
import '../../../helper/route_helper.dart';
import '../../../util/images.dart';
import '../../base/confirmation_dialog.dart';
import '../../base/custom_button.dart';
import '../../base/custom_snackbar.dart';
import '../../base/custom_text_field.dart';
import '../../base/inner_custom_app_bar.dart';
import '../../base/paginated_list_view.dart';

class ReportIncidenceScreen extends StatefulWidget {
  @override
  State<ReportIncidenceScreen> createState() => _ReportIncidenceScreenState();
}

class _ReportIncidenceScreenState extends State<ReportIncidenceScreen> {
  // FlutterSound flutterSound = new FlutterSound();
  final TextEditingController _shortController = TextEditingController();
  final TextEditingController _longController = TextEditingController();
 bool isAnonymous=false;

  List<String> items = <String>[
    'Thugs',
    'Flight',
    'Ballot Snatching',
    'Others'
  ];
  String selectedItem = 'Thugs';

  void _loadData() async {
    Get.find<HomeController>().clearAllData();
    Get.find<HomeController>().getIncidenceCategoryList();

  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    return GetBuilder<HomeController>(builder: (homecroller) {
      return Scaffold(
        appBar: InnerCustomAppBar(
          title: 'Report Incidence'.tr,
          leadingIcon: Images.circle_arrow_back,
          backButton: !ResponsiveHelper.isDesktop(context),
        ),
       /* endDrawer: MenuDrawer(),*/
        body: GetBuilder<HomeController>(
      builder: (homeController) =>
      !homeController.isLoading ?
        SingleChildScrollView(
            controller: scrollController,
            physics: AlwaysScrollableScrollPhysics(),
            child: Container(
              margin: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                  (homeController.incidencecategorylist!=null && homeController.incidencecategorylist.length>0?
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding:
                        EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_LARGE_SMALL),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(35)),
                        border: Border.all(
                            width: 0.4, color: Theme.of(context).hintColor),
                        color: Theme.of(context).cardColor),
                    child: DropdownButton<String>(
                      value: selectedItem != null ? selectedItem : "",
                      items: items.map((item) {
                        return DropdownMenuItem<String>(
                          value: item,
                          child: Container(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.8,
                              margin: EdgeInsets.only(right: 5),
                              padding: EdgeInsets.all(
                                  Dimensions.PADDING_SIZE_EXTRA_SMALL),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: Dimensions.PADDING_SIZE_SMALL),
                                child: Text(
                                  item,
                                  style: robotoMedium.copyWith(
                                      color: Theme.of(context).hintColor),
                                ),
                              )),
                        );
                      }).toList(),
                      dropdownColor: Theme.of(context).cardColor,
                      icon: Icon(Icons.keyboard_arrow_down),
                      elevation: 0,
                      iconSize: 30,
                      underline: SizedBox(),
                      onChanged: (index) {
                        print("selected length>>>${homeController.incidencecategorylist[0].sId.toString()}");

                        setState(() {
                          selectedItem = index;
                        });
                        // localizationController.setLanguage(Locale(AppConstants.languages[index].languageCode, AppConstants.languages[index].countryCode));
                      },
                    ),
                  ):
                      SizedBox()),

                  SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Select State",
                      style: robotoRegular.copyWith(
                          color: Theme.of(context).hintColor),
                    ),
                  ),
                  SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
              InkWell(
                onTap: () {
                  Get.toNamed(RouteHelper.getSelectCountryRoute("State"));
                },
                child:
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        border: Border.all(
                            width: 0.3, color: Theme.of(context).hintColor),
                        color: Theme.of(context).cardColor),
                    child: Row(
                      children: [
                        SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),
                        Expanded(flex: 6, child: Text(homeController.state_name!=""?homeController.state_name:"Select State",style: robotoRegular)),
                        Expanded(
                            flex: 1, child: Icon(Icons.keyboard_arrow_right))
                      ],
                    ),
                  )),

                  SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Select Lga",
                      style: robotoRegular.copyWith(
                          color: Theme.of(context).hintColor),
                    ),
                  ),
                  SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
              InkWell(
                onTap: () {
                  Get.toNamed(RouteHelper.getSelectCountryRoute("lga"));
                },
                child:
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        border: Border.all(
                            width: 0.3, color: Theme.of(context).hintColor),
                        color: Theme.of(context).cardColor),
                    child: Row(
                      children: [
                        SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),
                        Expanded(flex: 6, child: Text(homeController.lga_name!=""?homeController.lga_name:"Select Lga",style: robotoRegular)),
                        Expanded(
                            flex: 1, child: Icon(Icons.keyboard_arrow_right))
                      ],
                    ),
                  )),

                  SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Select Ward",
                      style: robotoRegular.copyWith(
                          color: Theme.of(context).hintColor),
                    ),
                  ),
                  SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
              InkWell(
                onTap: () {
                  Get.toNamed(RouteHelper.getSelectCountryRoute("ward"));
                },
                child:

                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        border: Border.all(
                            width: 0.3, color: Theme.of(context).hintColor),
                        color: Theme.of(context).cardColor),
                    child: Row(
                      children: [
                        SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),
                        Expanded(flex: 6, child: Text(homeController.ward_name!=""?homeController.ward_name:"Select State",style: robotoRegular)),
                        Expanded(
                            flex: 1, child: Icon(Icons.keyboard_arrow_right))
                      ],
                    ),
                  )),


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
                        openSelectImage(homecroller);
                      },
                      child: Image.asset(
                        Images.add_photo,
                        fit: BoxFit.fill,
                        width: MediaQuery.of(context).size.width,
                      )),
                  SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                  (homecroller.raw_arrayList != null &&
                          homecroller.raw_arrayList.length > 0
                      ? Container(
                          height: 120,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                            itemCount: homecroller.raw_arrayList.length,
                            padding: EdgeInsets.all(
                                Dimensions.PADDING_SIZE_EXTRA_LARGE_SMALL),
                            physics: ScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.all(
                                    Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                child: Stack(
                                  children: [
                                    Container(
                                        margin: EdgeInsets.all(Dimensions
                                            .PADDING_SIZE_EXTRA_SMALL),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          border: Border.all(
                                              width: 1,
                                              color: Theme.of(context)
                                                  .disabledColor),
                                          color: Colors.white,
                                        ),
                                        child: Image.memory(
                                          homecroller.raw_arrayList[index],
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.cover,
                                        )),
                                    Positioned(
                                        top: 0,
                                        right: 0,
                                        child: InkWell(
                                          onTap: () {
                                            print("ksndksndsdsd");
                                            homecroller
                                                .removeSelectedImage(index);
                                            print(
                                                "ksndksndsdsd${homecroller.raw_arrayList.length}");
                                          },
                                          child: SvgPicture.asset(
                                            Images.circle_cancel,
                                            height: 20,
                                            width: 20,
                                          ),
                                        ))
                                  ],
                                ),
                              );
                            },
                          ))
                      : SizedBox()),
                  SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Short Description",
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
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(
                            color: Theme.of(context).hintColor, width: 0.4),
                      ),
                      counterText: "",
                      isDense: true,
                      hintText: "Enter short description",
                      fillColor: Theme.of(context).cardColor,
                      hintStyle: robotoRegular.copyWith(
                          fontSize: Dimensions.fontSizeLarge,
                          color: Color(0xFFA1A8B0)),
                      filled: true,
                    ),
                    controller: _shortController,
                    maxLines: 1,
                  ),

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
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(
                            color: Theme.of(context).hintColor, width: 0.4),
                      ),
                      counterText: "",
                      isDense: true,
                      hintText: "Enter description",
                      fillColor: Theme.of(context).cardColor,
                      hintStyle: robotoRegular.copyWith(
                          fontSize: Dimensions.fontSizeLarge,
                          color: Color(0xFFA1A8B0)),
                      filled: true,
                    ),
                    controller: _longController,
                    maxLines: 5,
                  ),

                  SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                  Row(mainAxisSize: MainAxisSize.max, children: [
                    Checkbox(
                      activeColor: Theme.of(context).primaryColor,
                      value: isAnonymous,
                      onChanged: (bool isChecked) =>
                          setState(() {
                        isAnonymous=isChecked;
                      }),
                         /* () {
                        print("object>>>>${isChecked}");
                            setState(() {
                              isAnonymous=isChecked;
                            });
                          },*/ /*authController.toggleTerms()*/
                    ),
                    Text('Post as anonymous'.tr, style: robotoRegular),
                  ]),
                  SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                  CustomButton(
                    buttonText: 'Submit Report'.tr,
                    onPressed:
                        () {
                          _addReport(isAnonymous,homeController);
                        } /*_login(
                        authController, _countryDialCode)*/
                    ,
                  )
                ],
              ),
            )):Center(child: CircularProgressIndicator()),
        )
      );
    });
  }

  void openSelectImage(HomeController homeController) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
              height: 340,
              padding: EdgeInsets.all(
                Dimensions.RADIUS_SMALL,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  border:
                      Border.all(width: 1, color: Theme.of(context).cardColor),
                  color: Theme.of(context).cardColor),
              // Set the desired height of the bottom sheet
              child: Column(
                children: [
                  SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                  Center(
                    child: SvgPicture.asset(Images.bottom_sheet_line),
                  ),
                  SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text('Choose For Attach File '.tr,
                        textAlign: TextAlign.center,
                        style: robotoBold.copyWith(
                          color: Theme.of(context).hintColor,
                          fontSize: Dimensions.fontSizeExtraLarge,
                        )),
                  ),
                  SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                    margin: EdgeInsets.all(
                      Dimensions.RADIUS_SMALL,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                          width: 1, color: Theme.of(context).disabledColor),
                      color: Colors.transparent,
                    ),
                    child: InkWell(
                        onTap: () {
                          homeController.pickImage();
                          Get.back();
                        },
                        child: Row(children: [
                          SizedBox(width: 10),
                          SvgPicture.asset(Images.gallery_image),
                          Expanded(
                            child: Text('Choose picture of gallery'.tr,
                                textAlign: TextAlign.center,
                                style: robotoBold.copyWith(
                                  color: Theme.of(context).hintColor,
                                  fontSize: Dimensions.fontSizeLarge,
                                )),
                          ),
                          Image.asset(Images.arrow_right_normal,
                              height: 10, fit: BoxFit.contain),
                          SizedBox(width: 10),
                        ])),
                  ),
                  SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                    margin: EdgeInsets.all(
                      Dimensions.RADIUS_SMALL,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                          width: 1, color: Theme.of(context).disabledColor),
                      color: Colors.transparent,
                    ),
                    child: InkWell(
                        onTap: () {
                          homeController.pickCameraImage();
                          Get.back();
                        },
                        child: Row(children: [
                          SizedBox(width: 10),
                          SvgPicture.asset(Images.take_photo),
                          Expanded(
                            child: Text('Take a photo'.tr,
                                textAlign: TextAlign.center,
                                style: robotoBold.copyWith(
                                  color: Theme.of(context).hintColor,
                                  fontSize: Dimensions.fontSizeLarge,
                                )),
                          ),
                          Image.asset(Images.arrow_right_normal,
                              height: 10, fit: BoxFit.contain),
                          SizedBox(width: 10),
                        ])),
                  ),
                  SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                    margin: EdgeInsets.all(
                      Dimensions.RADIUS_SMALL,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                          width: 1, color: Theme.of(context).disabledColor),
                      color: Colors.transparent,
                    ),
                    child: InkWell(
                        onTap: () {
                          startRecording();
                          Get.back();
                        },
                        child: Row(children: [
                          SizedBox(width: 10),
                          SvgPicture.asset(Images.voice_record),
                          Expanded(
                            child: Text('Voice Record'.tr,
                                textAlign: TextAlign.center,
                                style: robotoBold.copyWith(
                                  color: Theme.of(context).hintColor,
                                  fontSize: Dimensions.fontSizeLarge,
                                )),
                          ),
                          Image.asset(Images.arrow_right_normal,
                              height: 10, fit: BoxFit.contain),
                          SizedBox(width: 10),
                        ])),
                  ),
                  SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                ],
              ));
        },
        backgroundColor: Colors.transparent);
  }

  Future<void> startRecording() async {
    /*String path =  flutterSound.thePlayer.startPlayer() as String ;
    print("path>>>>>>>>>${path}");
    var _playerSubscription = flutterSound.thePlayer.onProgress.listen((e) {
      if (e != null) {
        print("path>>>>ee>>>>>${e.toString()}");
      //  DateTime date = new DateTime.fromMillisecondsSinceEpoch(e.toString());
        //String txt = DateFormat(‘mm:ss:SS’, ‘en_US’).format(date);
      */ /* setState(() {
          this._isPlaying = true;
          this._playerTxt = txt.substring(0, 8);
        });*/ /*
      }
    });*/
  }

  void _addReport(bool isAnonymous,HomeController homeController) async {
    String _firstName = _longController.text.trim();
    String _shortdescription = _shortController.text.trim();

    if (_shortdescription.isEmpty) {
      showCustomSnackBar('Enter short description'.tr);
    }else if (_firstName.isEmpty) {
      showCustomSnackBar('Enter description'.tr);
    } else if (!isAnonymous) {
      showCustomSnackBar('Select Anonymous'.tr);
    }else if (homeController.state_id=="") {
      showCustomSnackBar('Select State First !'.tr);
    }else if (homeController.lga_id=="") {
      showCustomSnackBar('Select LGA First !'.tr);
    }else if (homeController.ward_id=="") {
      showCustomSnackBar('Select Ward First !'.tr);
    }
    /*else if (!_isValid) {
      showCustomSnackBar('invalid_phone_number'.tr);
    }*/
    else {
      ReportIncidenceBody reportIncidenceBody = ReportIncidenceBody(
        incidentType: "64ad1684380c264760b1526f",
        subCategoryId: "64b1045a9e5b8a383bf2d869",
        state: homeController.state_id,
        lga: homeController.lga_id,
        ward: homeController.ward_id,
        image: homeController.uploadedURL,
        video: homeController.uploadedURL,
        audio: homeController.uploadedURL,
        description: _firstName,
        shortDescription: _shortdescription,
        isAnonymous: isAnonymous,
      );
      print("reportIncidenceBody>>>>>${reportIncidenceBody.toJson()}");
      homeController.addReport(reportIncidenceBody).then((status) async {
        print("ldkfjkdljfkdjf");
        if (status.statusCode == 200) {
         print("addReport>>>>>>>${status.body["message"]}");
         showCustomSnackBar(status.body["message"],isError:false);
         Get.back();
        } else {
          showCustomSnackBar(status.body["message"]);
        }
      });
    }
  }
}
