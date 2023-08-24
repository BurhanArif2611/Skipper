import 'package:flutter_svg/svg.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/styles.dart';

import 'package:sixam_mart/view/base/menu_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/complaint_controller.dart';
import '../../../helper/responsive_helper.dart';
import '../../../util/images.dart';
import '../../base/custom_button.dart';
import '../../base/custom_snackbar.dart';
import '../../base/inner_custom_app_bar.dart';

class AddComplaintScreen extends StatefulWidget {
  @override
  State<AddComplaintScreen> createState() => _AddComplaintScreenState();
}

class _AddComplaintScreenState extends State<AddComplaintScreen> {
  // FlutterSound flutterSound = new FlutterSound();
  final TextEditingController _shortController = TextEditingController();
  final TextEditingController _longController = TextEditingController();


  List<String> items = <String>[
    'Thugs',
    'Flight',
    'Ballot Snatching',
    'Others'
  ];
  String selectedItem = 'Thugs';

  void _loadData() async {
    Get.find<ComplaintController>().clearAllData();
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    return GetBuilder<ComplaintController>(builder: (homecroller) {
      return Scaffold(
          appBar: InnerCustomAppBar(
            title: 'Create Complaint'.tr,
            leadingIcon: Images.circle_arrow_back,
            backButton: !ResponsiveHelper.isDesktop(context),
          ),
          endDrawer: MenuDrawer(),
          body: GetBuilder<ComplaintController>(
            builder: (complaintcontroller) => !complaintcontroller.isLoading
                ? SingleChildScrollView(
                    controller: scrollController,
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Container(
                      margin:
                          EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                          InkWell(
                              onTap: () {
                                openSelectImage(complaintcontroller);
                              },
                              child: Container(
                                height: 200,
                                child: complaintcontroller.rawFile != null
                                    ? Image.memory(
                                        complaintcontroller.rawFile,
                                  fit: BoxFit.fitWidth,
                                      )

                                    : Image.asset(
                                        Images.upload_photo_document,
                                        fit: BoxFit.fill,
                                        width:
                                            MediaQuery.of(context).size.width,
                                      ),
                              )),
                          SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                          SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.all(
                                Dimensions.PADDING_SIZE_EXTRA_LARGE_SMALL),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(35)),
                                border: Border.all(
                                    width: 0.4,
                                    color: Theme.of(context).hintColor),
                                color: Theme.of(context).cardColor),
                            child: DropdownButton<String>(
                              value: selectedItem != null ? selectedItem : "",
                              items: items.map((item) {
                                return DropdownMenuItem<String>(
                                  value: item,
                                  child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      margin: EdgeInsets.only(right: 5),
                                      padding: EdgeInsets.all(
                                          Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left:
                                                Dimensions.PADDING_SIZE_SMALL),
                                        child: Text(
                                          item,
                                          style: robotoMedium.copyWith(
                                              color:
                                                  Theme.of(context).hintColor),
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
                                print(
                                    "selected length>>>${complaintcontroller.incidencecategorylist[0].sId.toString()}");

                                setState(() {
                                  selectedItem = index;
                                });
                                // localizationController.setLanguage(Locale(AppConstants.languages[index].languageCode, AppConstants.languages[index].countryCode));
                              },
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
                                    color: Theme.of(context).hintColor,
                                    width: 0.4),
                              ),
                              counterText: "",
                              isDense: true,
                              hintText: "Enter Your Complaint ",
                              fillColor: Theme.of(context).cardColor,
                              hintStyle: robotoMedium.copyWith(
                                  fontSize: Dimensions.fontSizeLarge,
                                  color: Color(0xFFA1A8B0)),
                              filled: true,
                            ),
                            controller: _longController,
                            maxLines: 5,
                          ),
                          SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                          CustomButton(
                            buttonText: 'Submit Complaint'.tr,
                            onPressed: () {
                              _addReport(complaintcontroller);
                            } /*_login(
                        authController, _countryDialCode)*/
                            ,
                          )
                        ],
                      ),
                    ))
                : Center(child: CircularProgressIndicator()),
          ));
    });
  }

  void openSelectImage(ComplaintController homeController) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
              height: 260,
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

  void _addReport( ComplaintController homeController) async {
    String _firstName = _longController.text.trim();

    if (_firstName.isEmpty) {
      showCustomSnackBar('Enter description'.tr);
    }
    /*else if (!_isValid) {
      showCustomSnackBar('invalid_phone_number'.tr);
    }*/
    else {


       homeController.addCompliant(_firstName,"64acfd005476cd3a0d58f5d1").then((status) async {
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
