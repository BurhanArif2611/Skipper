import 'dart:async';

import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sixam_mart/controller/kyc_controller.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/view/base/custom_snackbar.dart';
import 'package:sixam_mart/view/screens/kyc/widget/steppage.dart';

import 'package:timeago/timeago.dart' as timeago;

import '../../../controller/auth_controller.dart';
import '../../../helper/route_helper.dart';
import '../../base/custom_app_bar.dart';
import '../../base/custom_button.dart';
import '../../base/custom_text_field.dart';
import '../home/widget/team_card.dart';

class KYCScreen extends StatefulWidget {
  static Future<void> loadData(bool reload) async {}

  @override
  State<KYCScreen> createState() => _KYCScreenState();
}

class _KYCScreenState extends State<KYCScreen> {
  int _index = 0;
  int activeStep = 0;
  final FocusNode _idNumberFocus = FocusNode();
  final FocusNode _beneficiaryNameFocus = FocusNode();
  final FocusNode _beneficiaryBankNameFocus = FocusNode();
  final FocusNode _accountNumberFocus = FocusNode();
  final FocusNode _swiftCodeFocus = FocusNode();
  final FocusNode _addressFocus = FocusNode();
  final TextEditingController _idNumberController = TextEditingController();
  final TextEditingController _beneficiaryNameController = TextEditingController();
  final TextEditingController _beneficiaryBankNameController = TextEditingController();
  final TextEditingController _accountNumberController = TextEditingController();
  final TextEditingController _swiftCodeController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // _loadData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
            title: 'Document KYC', onBackPressed: () => {Get.back()}),
        body: GetBuilder<KycController>(builder: (kycController) {
          return
            Container(
                color: Theme
                    .of(context)
                    .backgroundColor,
                height: MediaQuery
                    .of(context)
                    .size
                    .height,
                child: Column(
                  children: [
                    Expanded(
                        flex: 1,
                        child: Padding(
                          padding:
                          EdgeInsets.only(top: Dimensions.RADIUS_EXTRA_LARGE),
                          child: EasyStepper(
                              activeStep: activeStep,
                              lineLength:
                              MediaQuery
                                  .of(context)
                                  .size
                                  .width / 4 - 50,
                              lineSpace: 0,
                              stepShape: StepShape.circle,
                              stepBorderRadius: 5,
                              borderThickness: 1,
                              stepRadius: 15,
                              lineType: LineType.normal,
                              defaultLineColor: Colors.white,
                              finishedLineColor: Colors.green,
                              activeStepTextColor: Colors.green,
                              finishedStepTextColor: Colors.green,
                              finishedStepBackgroundColor: Colors.green,
                              unreachedStepBackgroundColor: Colors.white,
                              unreachedStepTextColor: Colors.white,
                              activeStepBackgroundColor: Colors.green,
                              internalPadding: 10,
                              showLoadingAnimation: false,
                              showStepBorder: false,
                              steps: [
                                EasyStep(
                                  customStep: Container(
                                    child: activeStep > 0
                                        ? Icon(
                                      Icons.check,
                                      color: Colors.white,
                                    )
                                        : Text("1"),
                                  ),
                                  customTitle: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        'ID Front',
                                        style: robotoMedium.copyWith(
                                            fontSize: Dimensions
                                                .fontSizeExtraSmall,
                                            color: activeStep > 0
                                                ? Colors.green
                                                : Colors.grey),
                                      )),
                                ),
                                EasyStep(
                                  customStep: Container(
                                    child: activeStep > 1
                                        ? Icon(
                                      Icons.check,
                                      color: Colors.white,
                                    )
                                        : Text("2"),
                                  ),
                                  /*  title: 'ID Back',*/
                                  customTitle: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        'ID Back',
                                        style: robotoMedium.copyWith(
                                            fontSize: Dimensions
                                                .fontSizeExtraSmall,
                                            color: activeStep > 1
                                                ? Colors.green
                                                : Colors.grey),
                                      )),
                                ),
                                EasyStep(
                                  customStep: Container(
                                    child: activeStep > 2
                                        ? Icon(
                                      Icons.check,
                                      color: Colors.white,
                                    )
                                        : Text("3"),
                                  ),
                                  /* title: 'SSN',*/
                                  customTitle: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        'SSN',
                                        style: robotoMedium.copyWith(
                                            fontSize: Dimensions
                                                .fontSizeExtraSmall,
                                            color: activeStep > 2
                                                ? Colors.green
                                                : Colors.grey),
                                      )),
                                ),
                                EasyStep(
                                  customStep: Container(
                                    child: activeStep > 3
                                        ? Icon(
                                      Icons.check,
                                      color: Colors.white,
                                    )
                                        : Text("4"),
                                  ),
                                  /* title: 'Bank A/c Details',*/
                                  customTitle: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Bank A/c Details',
                                        style: robotoMedium.copyWith(
                                            fontSize: Dimensions
                                                .fontSizeExtraSmall,
                                            color: activeStep > 3
                                                ? Colors.green
                                                : Colors.grey),
                                      )),
                                ),
                              ],
                              onStepReached: (index) => _moveToPage(index)
                            /*  setState(() => activeStep = index)*/
                          ),
                        )),

                    Expanded(
                        flex: 8,
                        child:
                        Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            child: Scrollbar(
                                child: SingleChildScrollView(
                                  physics: BouncingScrollPhysics(),
                                  child: Container(
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width,
                                      padding:
                                      EdgeInsets.all(
                                          Dimensions.PADDING_SIZE_LARGE),
                                      child: activeStep == 0
                                          ? stepOne(kycController)
                                          : activeStep == 1
                                          ? stepTwo(kycController)
                                          : activeStep == 2
                                          ? stepThree(kycController)
                                          : activeStep == 4
                                          ? stepFourth(kycController)
                                          : SizedBox()),
                                )))

                    )
                  ],
                ));
        })

    );
  }

  void _moveToPage(int page) {
    setState(() {
      if (page == 3) {
        activeStep = page + 1;
      } else {
        activeStep = page;
      }
    });
    print("activeStep>>>${activeStep}");
  }

  Widget stepOne(KycController kycController) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "ID (Front)",
          style: robotoBold.copyWith(
              fontSize: Dimensions.fontSizeExtraLarge,
              color: Theme
                  .of(context)
                  .cardColor),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "Please enter your ID Number and Upload Your ID Front Photo below for completing your first step of KYC.",
          style: robotoRegular.copyWith(
              fontSize: Dimensions.fontSizeSmall,
              color: Theme
                  .of(context)
                  .cardColor),
        ),
        SizedBox(
          height: 40,
        ),
        Text(
          "ID Number",
          style: robotoMedium.copyWith(
              fontSize: Dimensions.fontSizeDefault,
              color: Theme
                  .of(context)
                  .cardColor),
        ),
        SizedBox(
          height: 5,
        ),
        CustomTextField(
          hintText: 'ID Number'.tr,
          controller: _idNumberController,
          focusNode: _idNumberFocus,
          inputType: TextInputType.name,
          capitalization: TextCapitalization.words,
          divider: false,
        ),
        SizedBox(
          height: 50,
        ),
        InkWell(
            onTap: () {
              openSelectImage(kycController,"id_front");
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.RADIUS_LARGE),
                border: Border.all(
                  color: Colors.grey,
                  width: 1,
                ),
              ),
              height: 100,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Upload ID front photo",
                    style: robotoMedium.copyWith(
                        fontSize: Dimensions.fontSizeDefault,
                        color: Theme
                            .of(context)
                            .cardColor),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.circular(Dimensions.RADIUS_LARGE),
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                    padding:
                    EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
                    child: Text(
                      "Upload +",
                      style: robotoMedium.copyWith(
                          fontSize: Dimensions.fontSizeDefault,
                          color: Theme
                              .of(context)
                              .cardColor),
                    ),
                  ),
                ],
              ),
            )),
        if (kycController.idFrontRawFile != null)
          SizedBox(
            height: 10,
          ),
        if (kycController.idFrontRawFile != null)
          Container(
            margin:
            EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
            child: Stack(
              children: [
                Container(
                    margin: EdgeInsets.all(
                        Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(Dimensions
                            .RADIUS_DEFAULT), // Set your desired radius
                        child: Image.memory(
                          kycController.idFrontRawFile,
                          fit: BoxFit.fitWidth,
                          height: 100,
                        ))),
                Positioned(
                    top: 0,
                    right: 0,
                    child: InkWell(
                      onTap: () {
                        kycController.removeIdFrontImage();
                      },
                      child: SvgPicture.asset(
                        Images.circle_cancel,
                        height: 20,
                        width: 20,
                        color: Theme.of(context).primaryColor,
                      ),
                    ))
              ],
            ),
          ),

        SizedBox(
          height: 10,
        ),
        CustomButton(
          transparent:kycController.idFrontRawFile != null?false:true,
          height: 50,
          buttonText: 'Continue'.tr,
          onPressed: kycController.idFrontRawFile != null?() {

            _moveToPage(1);
          }:(){
            showCustomSnackBar("Select ID front photo",isError: true);
          },
        ),
        SizedBox(
          height: 20,
        ),
        Align(
          alignment: Alignment.center,
          child: Text(
            'If you are facing any difficulties, please get ',
            textAlign: TextAlign.center,
            style: robotoBold.copyWith(
              color: Theme
                  .of(context)
                  .cardColor
                  .withOpacity(0.50),
              fontSize: Dimensions.fontSizeDefault,
            ),
          ),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            ' in touch with us on ',
            textAlign: TextAlign.center,
            style: robotoBold.copyWith(
              color: Theme
                  .of(context)
                  .cardColor
                  .withOpacity(0.50),
              fontSize: Dimensions.fontSizeDefault,
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              ' Whatsapp'.tr,
              textAlign: TextAlign.center,
              style: robotoBold.copyWith(
                color: Theme
                    .of(context)
                    .primaryColor,
                fontSize: Dimensions.fontSizeDefault,
              ),
            ),
          ),
        ]),
      ],
    );
  }

  void openSelectImage(KycController authController, String check) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
              height: 310,
              padding: EdgeInsets.all(
                Dimensions.RADIUS_SMALL,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  border:
                  Border.all(width: 1, color: Theme
                      .of(context)
                      .cardColor),
                  color: Theme
                      .of(context)
                      .cardColor),
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
                        style: robotoMedium.copyWith(
                          color: Theme
                              .of(context)
                              .hintColor,
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
                          width: 1, color: Theme
                          .of(context)
                          .disabledColor),
                      color: Colors.transparent,
                    ),
                    child:

                    InkWell(
                        onTap: () {
                          authController.pickImage(check);
                          Get.back();
                        },
                        child: Row(children: [
                          SizedBox(width: 10),
                          SvgPicture.asset(Images.gallery_image,color: Theme.of(context).primaryColor,),
                          Expanded(
                            child: Text('Choose picture of gallery'.tr,
                                textAlign: TextAlign.center,
                                style: robotoRegular.copyWith(
                                  color: Theme
                                      .of(context)
                                      .hintColor,
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
                          width: 1, color: Theme
                          .of(context)
                          .disabledColor),
                      color: Colors.transparent,
                    ),
                    child: InkWell(
                        onTap: () {
                          authController.pickCameraImage(check);
                          Get.back();
                        },
                        child: Row(children: [
                          SizedBox(width: 10),
                          SvgPicture.asset(Images.take_photo,color: Theme.of(context).primaryColor,),
                          Expanded(
                            child: Text('Take a photo'.tr,
                                textAlign: TextAlign.center,
                                style: robotoRegular.copyWith(
                                  color: Theme
                                      .of(context)
                                      .hintColor,
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

  Widget stepTwo(KycController kycController) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "ID (Back)",
          style: robotoBold.copyWith(
              fontSize: Dimensions.fontSizeExtraLarge,
              color: Theme
                  .of(context)
                  .cardColor),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "Please enter your ID Number and Upload Your ID Front Photo below for completing your first step of KYC.",
          style: robotoRegular.copyWith(
              fontSize: Dimensions.fontSizeSmall,
              color: Theme
                  .of(context)
                  .cardColor),
        ),
        SizedBox(
          height: 40,
        ),
        Text(
          "ID Number",
          style: robotoMedium.copyWith(
              fontSize: Dimensions.fontSizeDefault,
              color: Theme
                  .of(context)
                  .cardColor),
        ),
        SizedBox(
          height: 5,
        ),
        CustomTextField(
          hintText: 'ID Number'.tr,
          /* controller: _firstNameController,
          focusNode: _firstNameFocus,
          nextFocus: _lastNameFocus,*/
          inputType: TextInputType.name,
          capitalization: TextCapitalization.words,
          divider: false,
        ),
        SizedBox(
          height: 50,
        ),
      InkWell(onTap: (){
        openSelectImage(kycController,"id_back");
      },
      child:
      Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.RADIUS_LARGE),
            border: Border.all(
              color: Colors.grey,
              width: 1,
            ),
          ),
          height: 100,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Upload ID back photo",
                style: robotoMedium.copyWith(
                    fontSize: Dimensions.fontSizeDefault,
                    color: Theme
                        .of(context)
                        .cardColor),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.RADIUS_LARGE),
                  border: Border.all(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
                padding:
                EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
                child: Text(
                  "Upload +",
                  style: robotoMedium.copyWith(
                      fontSize: Dimensions.fontSizeDefault,
                      color: Theme
                          .of(context)
                          .cardColor),
                ),
              ),
            ],
          ),
        )),

        if (kycController.idBackRawFile != null)
          SizedBox(
            height: 10,
          ),
        if (kycController.idBackRawFile != null)
          Container(
            margin:
            EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
            child: Stack(
              children: [
                Container(
                    margin: EdgeInsets.all(
                        Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(Dimensions
                            .RADIUS_DEFAULT), // Set your desired radius
                        child: Image.memory(
                          kycController.idBackRawFile,
                          fit: BoxFit.fitWidth,
                          height: 100,
                        ))),
                Positioned(
                    top: 0,
                    right: 0,
                    child: InkWell(
                      onTap: () {
                        kycController.removeIdFrontImage();
                      },
                      child: SvgPicture.asset(
                        Images.circle_cancel,
                        height: 20,
                        width: 20,
                        color: Theme.of(context).primaryColor,
                      ),
                    ))
              ],
            ),
          ),
        SizedBox(
          height: 20,
        ),
        CustomButton(
          transparent:kycController.idBackRawFile != null?false:true ,
          height: 50,
          buttonText: 'Continue'.tr,
          onPressed: () {
            if(kycController.idBackRawFile != null){
            _moveToPage(2);}
            else {
              showCustomSnackBar("Select ID back photo",isError: true);
            }
          },
        ),
        SizedBox(
          height: 20,
        ),
        Align(
          alignment: Alignment.center,
          child: Text(
            'If you are facing any difficulties, please get ',
            textAlign: TextAlign.center,
            style: robotoBold.copyWith(
              color: Theme
                  .of(context)
                  .cardColor
                  .withOpacity(0.50),
              fontSize: Dimensions.fontSizeDefault,
            ),
          ),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            ' in touch with us on ',
            textAlign: TextAlign.center,
            style: robotoBold.copyWith(
              color: Theme
                  .of(context)
                  .cardColor
                  .withOpacity(0.50),
              fontSize: Dimensions.fontSizeDefault,
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              ' Whatsapp'.tr,
              textAlign: TextAlign.center,
              style: robotoBold.copyWith(
                color: Theme
                    .of(context)
                    .primaryColor,
                fontSize: Dimensions.fontSizeDefault,
              ),
            ),
          ),
        ]),
      ],
    );
  }

  Widget stepThree(KycController kycController) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "SSN (Front)",
          style: robotoBold.copyWith(
              fontSize: Dimensions.fontSizeExtraLarge,
              color: Theme
                  .of(context)
                  .cardColor),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "Please enter your ID Number and Upload Your ID Front Photo below for completing your first step of KYC.",
          style: robotoRegular.copyWith(
              fontSize: Dimensions.fontSizeSmall,
              color: Theme
                  .of(context)
                  .cardColor),
        ),
        SizedBox(
          height: 40,
        ),
        Text(
          "ID Number",
          style: robotoMedium.copyWith(
              fontSize: Dimensions.fontSizeDefault,
              color: Theme
                  .of(context)
                  .cardColor),
        ),
        SizedBox(
          height: 5,
        ),
        CustomTextField(
          hintText: 'ID Number'.tr,
          /* controller: _firstNameController,
          focusNode: _firstNameFocus,
          nextFocus: _lastNameFocus,*/
          inputType: TextInputType.name,
          capitalization: TextCapitalization.words,
          divider: false,
        ),
        SizedBox(
          height: 50,
        ),
        InkWell(onTap: (){
          openSelectImage(kycController,"ssn_front");
        },
        child:
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.RADIUS_LARGE),
            border: Border.all(
              color: Colors.grey,
              width: 1,
            ),
          ),
          height: 100,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Upload ID SSN photo",
                style: robotoMedium.copyWith(
                    fontSize: Dimensions.fontSizeDefault,
                    color: Theme
                        .of(context)
                        .cardColor),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.RADIUS_LARGE),
                  border: Border.all(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
                padding:
                EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
                child: Text(
                  "Upload +",
                  style: robotoMedium.copyWith(
                      fontSize: Dimensions.fontSizeDefault,
                      color: Theme
                          .of(context)
                          .cardColor),
                ),
              ),
            ],
          ),
        )),

        if (kycController.idSSNRawFile != null)
          SizedBox(
            height: 10,
          ),
        if (kycController.idSSNRawFile != null)
          Container(
            margin:
            EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
            child: Stack(
              children: [
                Container(
                    margin: EdgeInsets.all(
                        Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(Dimensions
                            .RADIUS_DEFAULT), // Set your desired radius
                        child: Image.memory(
                          kycController.idSSNRawFile,
                          fit: BoxFit.fitWidth,
                          height: 100,
                        ))),
                Positioned(
                    top: 0,
                    right: 0,
                    child: InkWell(
                      onTap: () {
                        kycController.removeIdFrontImage();
                      },
                      child: SvgPicture.asset(
                        Images.circle_cancel,
                        height: 20,
                        width: 20,
                        color: Theme.of(context).primaryColor,
                      ),
                    ))
              ],
            ),
          ),
        SizedBox(
          height: 20,
        ),
        CustomButton(
          transparent: kycController.idSSNRawFile != null?false:true,
          height: 50,
          buttonText: 'Continue'.tr,
          onPressed: () {
            if(kycController.idSSNRawFile != null) {
              _moveToPage(3);
            }else {
              showCustomSnackBar("Select ID SSN photo",isError: true);
            }
          },
        ),
        SizedBox(
          height: 20,
        ),
        Align(
          alignment: Alignment.center,
          child: Text(
            'If you are facing any difficulties, please get ',
            textAlign: TextAlign.center,
            style: robotoBold.copyWith(
              color: Theme
                  .of(context)
                  .cardColor
                  .withOpacity(0.50),
              fontSize: Dimensions.fontSizeDefault,
            ),
          ),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            ' in touch with us on ',
            textAlign: TextAlign.center,
            style: robotoBold.copyWith(
              color: Theme
                  .of(context)
                  .cardColor
                  .withOpacity(0.50),
              fontSize: Dimensions.fontSizeDefault,
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              ' Whatsapp'.tr,
              textAlign: TextAlign.center,
              style: robotoBold.copyWith(
                color: Theme
                    .of(context)
                    .primaryColor,
                fontSize: Dimensions.fontSizeDefault,
              ),
            ),
          ),
        ]),
      ],
    );
  }

  Widget stepFourth(KycController kycController) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "Bank Account",
          style: robotoBold.copyWith(
              fontSize: Dimensions.fontSizeExtraLarge,
              color: Theme
                  .of(context)
                  .cardColor),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "Please enter your bank account details with which you are going to make add money or withdrawal.",
          style: robotoRegular.copyWith(
              fontSize: Dimensions.fontSizeSmall,
              color: Theme
                  .of(context)
                  .cardColor),
        ),
        SizedBox(
          height: 40,
        ),
        Text(
          "Beneficiary Name",
          style: robotoMedium.copyWith(
              fontSize: Dimensions.fontSizeDefault,
              color: Theme
                  .of(context)
                  .cardColor),
        ),
        SizedBox(
          height: 5,
        ),
        CustomTextField(
          hintText: 'Beneficiary Name'.tr,
           controller: _beneficiaryNameController,
          focusNode: _beneficiaryNameFocus,
          nextFocus: _beneficiaryBankNameFocus,
          inputType: TextInputType.name,
          capitalization: TextCapitalization.words,
          divider: false,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "Beneficiary Bank Name",
          style: robotoMedium.copyWith(
              fontSize: Dimensions.fontSizeDefault,
              color: Theme
                  .of(context)
                  .cardColor),
        ),
        SizedBox(
          height: 5,
        ),
        CustomTextField(
          hintText: 'Beneficiary Bank Name'.tr,
           controller: _beneficiaryBankNameController,
          focusNode: _beneficiaryBankNameFocus,
          nextFocus: _accountNumberFocus,
          inputType: TextInputType.name,
          capitalization: TextCapitalization.words,
          divider: false,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "Routing number & Correspondent Account No.",
          style: robotoMedium.copyWith(
              fontSize: Dimensions.fontSizeDefault,
              color: Theme
                  .of(context)
                  .cardColor),
        ),
        SizedBox(
          height: 5,
        ),
        CustomTextField(
          hintText: 'Routing number & Correspondent Account No.'.tr,
           controller: _accountNumberController,
          focusNode: _accountNumberFocus,
          nextFocus: _swiftCodeFocus,
          inputType: TextInputType.name,
          capitalization: TextCapitalization.words,
          divider: false,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "Swift Code",
          style: robotoMedium.copyWith(
              fontSize: Dimensions.fontSizeDefault,
              color: Theme
                  .of(context)
                  .cardColor),
        ),
        SizedBox(
          height: 5,
        ),
        CustomTextField(
          hintText: 'Swift Code'.tr,
           controller: _swiftCodeController,
          focusNode: _swiftCodeFocus,
          nextFocus: _addressFocus,
          inputType: TextInputType.name,
          capitalization: TextCapitalization.words,
          divider: false,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "Address",
          style: robotoMedium.copyWith(
              fontSize: Dimensions.fontSizeDefault,
              color: Theme
                  .of(context)
                  .cardColor),
        ),
        SizedBox(
          height: 5,
        ),
        CustomTextField(
          hintText: 'Address'.tr,
           controller: _addressController,
          focusNode: _addressFocus,
       /*   nextFocus: _addressFocus,*/
          inputType: TextInputType.name,
          capitalization: TextCapitalization.words,
          divider: false,
        ),
        SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 20,
        ),
        CustomButton(
          height: 50,
          buttonText: 'Continue'.tr,
          onPressed: () {
            Get.toNamed(RouteHelper.getKYCSuccessScreenRoute());
          },
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
