import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:sixam_mart/controller/auth_controller.dart';
import 'package:sixam_mart/controller/user_controller.dart';
import 'package:sixam_mart/controller/wallet_controller.dart';
import 'package:sixam_mart/data/model/response/bank_list.dart';
import 'package:sixam_mart/helper/price_converter.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/view/base/custom_app_bar.dart';
import 'package:sixam_mart/view/base/menu_drawer.dart';
import 'package:sixam_mart/view/base/no_data_screen.dart';
import 'package:sixam_mart/view/base/not_logged_in_screen.dart';
import 'package:sixam_mart/view/base/title_widget.dart';
import 'package:sixam_mart/view/screens/wallet/widget/history_item.dart';
import 'package:sixam_mart/view/screens/wallet/widget/wallet_bottom_sheet.dart';

import '../../base/confirmation_dialog.dart';
import '../../base/custom_button.dart';
import '../../base/custom_snackbar.dart';
import '../../base/my_text_field.dart';

class WalletScreen extends StatefulWidget {
  final bool fromWallet;

  WalletScreen({Key key, @required this.fromWallet}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  final ScrollController scrollController = ScrollController();
  final bool _isLoggedIn = Get.find<AuthController>().isLoggedIn();

  @override
  void initState() {
    super.initState();
    if (_isLoggedIn) {
      Get.find<UserController>().getUserInfo();
      Get.find<WalletController>()
          .getWalletTransactionList('1', false, widget.fromWallet);

      Get.find<WalletController>().setOffset(1);
      Get.find<WalletController>().bankList();
      Get.find<WalletController>().bankAccountListDetail();

      scrollController?.addListener(() {
        if (scrollController.position.pixels ==
                scrollController.position.maxScrollExtent &&
            Get.find<WalletController>().transactionList != null &&
            !Get.find<WalletController>().isLoading) {
          int pageSize =
              (Get.find<WalletController>().popularPageSize / 10).ceil();
          if (Get.find<WalletController>().offset < pageSize) {
            Get.find<WalletController>()
                .setOffset(Get.find<WalletController>().offset + 1);
            print('end of the page');
            Get.find<WalletController>().showBottomLoader();
            Get.find<WalletController>().getWalletTransactionList(
                Get.find<WalletController>().offset.toString(),
                false,
                widget.fromWallet);
          }
        }
      });
    }
  }

  @override
  void dispose() {
    super.dispose();

    scrollController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      endDrawer: MenuDrawer(),
      appBar: CustomAppBar(
          title: widget.fromWallet ? 'wallet'.tr : 'loyalty_points'.tr,
          backButton: true),
      body: GetBuilder<UserController>(builder: (userController) {
        return _isLoggedIn
            ? userController.userInfoModel != null
                ? SafeArea(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        Get.find<WalletController>().getWalletTransactionList(
                            '1', true, widget.fromWallet);
                        Get.find<UserController>().getUserInfo();
                      },
                      child: SingleChildScrollView(
                        controller: scrollController,
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                        child: Center(
                          child: SizedBox(
                            width: Dimensions.WEB_MAX_WIDTH,
                            child: GetBuilder<WalletController>(
                                builder: (walletController) {
                              return Column(children: [
                                Stack(
                                  children: [
                                    Container(
                                      padding: widget.fromWallet
                                          ? EdgeInsets.all(Dimensions
                                              .PADDING_SIZE_EXTRA_LARGE)
                                          : EdgeInsets.only(
                                              top: 40,
                                              left: Dimensions
                                                  .PADDING_SIZE_EXTRA_LARGE,
                                              right: Dimensions
                                                  .PADDING_SIZE_EXTRA_LARGE),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.RADIUS_DEFAULT),
                                        color: widget.fromWallet
                                            ? Theme.of(context).primaryColor
                                            : Theme.of(context).cardColor,
                                      ),
                                      child: Row(
                                          mainAxisAlignment: widget.fromWallet
                                              ? MainAxisAlignment.start
                                              : MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                                widget.fromWallet
                                                    ? Images.wallet
                                                    : Images.loyal,
                                                height: 60,
                                                width: 60,
                                                color: widget.fromWallet
                                                    ? Theme.of(context)
                                                        .cardColor
                                                    : null),
                                            SizedBox(
                                                width: Dimensions
                                                    .PADDING_SIZE_EXTRA_LARGE),
                                            widget.fromWallet
                                                ? Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                        Text('wallet_amount'.tr,
                                                            style: robotoRegular.copyWith(
                                                                fontSize: Dimensions
                                                                    .fontSizeSmall,
                                                                color: Theme.of(
                                                                        context)
                                                                    .cardColor)),
                                                        SizedBox(
                                                            height: Dimensions
                                                                .PADDING_SIZE_SMALL),
                                                        Text(
                                                          PriceConverter.convertPrice(
                                                              userController
                                                                  .userInfoModel
                                                                  .walletBalance),
                                                          style: robotoBold.copyWith(
                                                              fontSize: Dimensions
                                                                  .fontSizeOverLarge,
                                                              color: Theme.of(
                                                                      context)
                                                                  .cardColor),
                                                        ),
                                                      ])
                                                : Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                        Text(
                                                          userController
                                                                      .userInfoModel
                                                                      .loyaltyPoint ==
                                                                  null
                                                              ? '0'
                                                              : userController
                                                                  .userInfoModel
                                                                  .loyaltyPoint
                                                                  .toString(),
                                                          style: robotoBold.copyWith(
                                                              fontSize: Dimensions
                                                                  .fontSizeOverLarge,
                                                              color: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyText1
                                                                  .color),
                                                        ),
                                                        Text(
                                                          'loyalty_points'.tr +
                                                              ' !',
                                                          style: robotoRegular.copyWith(
                                                              fontSize: Dimensions
                                                                  .fontSizeSmall,
                                                              color: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyText1
                                                                  .color),
                                                        ),
                                                        SizedBox(
                                                            height: Dimensions
                                                                .PADDING_SIZE_SMALL),
                                                      ])
                                          ]),
                                    ),
                                    widget.fromWallet
                                        ? SizedBox.shrink()
                                        : Positioned(
                                            top: 10,
                                            right: 10,
                                            child: InkWell(
                                              onTap: () {
                                                ResponsiveHelper.isMobile(
                                                        context)
                                                    ? Get.bottomSheet(
                                                        WalletBottomSheet(
                                                            fromWallet: widget
                                                                .fromWallet))
                                                    : Get.dialog(
                                                        Dialog(
                                                            child: WalletBottomSheet(
                                                                fromWallet: widget
                                                                    .fromWallet)),
                                                      );
                                              },
                                              child: Row(
                                                children: [
                                                  Text(
                                                    'convert_to_currency'.tr,
                                                    style:
                                                        robotoRegular.copyWith(
                                                            fontSize: Dimensions
                                                                .fontSizeSmall,
                                                            color: widget
                                                                    .fromWallet
                                                                ? Theme.of(
                                                                        context)
                                                                    .cardColor
                                                                : Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyText1
                                                                    .color),
                                                  ),
                                                  Icon(
                                                      Icons
                                                          .keyboard_arrow_down_outlined,
                                                      size: 16,
                                                      color: widget
                                                              .fromWallet
                                                          ? Theme.of(context)
                                                              .cardColor
                                                          : Theme.of(context)
                                                              .textTheme
                                                              .bodyText1
                                                              .color)
                                                ],
                                              ),
                                            ),
                                          )
                                  ],
                                ),
                                widget.fromWallet
                                    ? Row(children: [
                                        Expanded(
                                            child: CustomButton(
                                          height: 40,
                                          buttonText:
                                              Get.find<WalletController>()
                                                          .bankAccountList
                                                          .length >
                                                      0
                                                  ? 'View Bank AC'.tr
                                                  : 'Add Bank AC'.tr,
                                          fontSize: 12,
                                          onPressed: () => {
                                            Get.find<WalletController>()
                                                .filterList
                                                .clear(),
                                            if (Get.find<WalletController>()
                                                    .bankAccountList
                                                    .length >
                                                0)
                                              {
                                                showAddAccountDetailsDialog(
                                                    context)
                                              }
                                            else
                                              {
                                                showAddAccountCustomDialog(
                                                    context)
                                              }
                                          },
                                        )),
                                        SizedBox(
                                            width:
                                                Dimensions.PADDING_SIZE_SMALL),
                                        Expanded(
                                            child: CustomButton(
                                                height: 40,
                                                fontSize: 12,
                                                buttonText: 'Add Fund'.tr,
                                                onPressed: () => {
                                                      /*if (Get.find<WalletController>()
                                                        .bankAccountList
                                                        .length >
                                                    0)
                                                  {*/
                                                      showAddFundCustomDialog(
                                                          context)
                                                      /* }
                                                else
                                                  {
                                                    showCustomSnackBar(
                                                        'No account added please add bank account first',
                                                        isError: false)
                                                  }*/
                                                      ,
                                                    })),
                                        SizedBox(
                                            width:
                                                Dimensions.PADDING_SIZE_SMALL),
                                        Expanded(
                                            child: CustomButton(
                                                height: 40,
                                                fontSize: 12,
                                                buttonText: 'Withdraw Fund',
                                                onPressed: () => {
                                                      if (Get.find<
                                                                  WalletController>()
                                                              .bankAccountList
                                                              .length >
                                                          0)
                                                        {
                                                          showWithdrawFundCustomDialog(
                                                              context)
                                                        }
                                                      else
                                                        {
                                                          showCustomSnackBar(
                                                              'No account added please add bank account first',
                                                              isError: false)
                                                        }
                                                    })),
                                      ])
                                    : SizedBox(
                                        height: Dimensions.PADDING_SIZE_SMALL),
                                Column(children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: Dimensions
                                            .PADDING_SIZE_EXTRA_LARGE),
                                    child: TitleWidget(
                                        title: 'transaction_history'.tr),
                                  ),
                                  walletController.transactionList != null
                                      ? walletController
                                                  .transactionList.length >
                                              0
                                          ?
                                  GridView.builder(
                                              key: UniqueKey(),
                                              gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisSpacing: 50,
                                                mainAxisSpacing:
                                                    ResponsiveHelper.isDesktop(
                                                            context)
                                                        ? Dimensions
                                                            .PADDING_SIZE_LARGE
                                                        : 0.01,
                                                childAspectRatio:
                                                    ResponsiveHelper.isDesktop(
                                                            context)
                                                        ? 5
                                                        : 4.45,
                                                crossAxisCount:
                                                    ResponsiveHelper.isMobile(
                                                            context)
                                                        ? 1
                                                        : 2,
                                              ),
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount: walletController
                                                  .transactionList.length,
                                              padding: EdgeInsets.only(
                                                  top: ResponsiveHelper
                                                          .isDesktop(context)
                                                      ? 28
                                                      : 25),
                                              itemBuilder: (context, index) {
                                                return
                                                  HistoryItem(
                                                    index: index,
                                                    fromWallet:
                                                        widget.fromWallet,
                                                    data: walletController
                                                        .transactionList);
                                              },
                                            )
                                          : NoDataScreen(
                                              text: 'no_data_found'.tr)
                                      : WalletShimmer(
                                          walletController: walletController),
                                  walletController.isLoading
                                      ? Center(
                                          child: Padding(
                                          padding: EdgeInsets.all(
                                              Dimensions.PADDING_SIZE_SMALL),
                                          child: CircularProgressIndicator(),
                                        ))
                                      : SizedBox(),
                                ])
                              ]);
                            }),
                          ),
                        ),
                      ),
                    ),
                  )
                : Center(child: CircularProgressIndicator())
            : NotLoggedInScreen();
      }),
    );
  }

  void showAddAccountCustomDialog(BuildContext context) {
    TextEditingController bankNameController = TextEditingController();
    TextEditingController bankCodeController = TextEditingController();
    TextEditingController accountnumberController = TextEditingController();
    TextEditingController holder_nameController = TextEditingController();

    showGeneralDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 700),
      pageBuilder: (_, __, ___) {
        /*GetBuilder<LocationController>(builder: (locationController)
        {*/
        return Center(
          child: Container(
            height: 400,
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(children: [
                      Align(
                          alignment: Alignment.center,
                          child: Text("Add Account Details",
                              style: robotoMedium.copyWith(
                                  fontSize: Dimensions.fontSizeLarge))),
                      /*  Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Take the picture of the home front',
                              style: robotoMedium.copyWith(
                                  color: Theme.of(context).disabledColor,
                                  fontSize: Dimensions.fontSizeLarge))),*/
                      SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Bank Name',
                          style: robotoRegular.copyWith(
                              fontSize: Dimensions.fontSizeSmall,
                              color: Theme.of(context).disabledColor),
                        ),
                      ),
                      SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                      SizedBox(
                          width: Dimensions.WEB_MAX_WIDTH,
                          child: Container(
                              height: 40,
                              child: DottedBorder(
                                  color: Colors.black,
                                  strokeWidth: 0.2,
                                  child: TypeAheadField(
                                    textFieldConfiguration:
                                        TextFieldConfiguration(
                                      controller: bankNameController,
                                      textInputAction: TextInputAction.search,
                                      autofocus: true,
                                      textCapitalization:
                                          TextCapitalization.words,
                                      keyboardType: TextInputType.streetAddress,
                                      decoration: InputDecoration(
                                        hintText: 'Search Bank Name'.tr,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              style: BorderStyle.none,
                                              width: 0),
                                        ),
                                        hintStyle: Theme.of(context)
                                            .textTheme
                                            .headline2
                                            .copyWith(
                                              fontSize:
                                                  Dimensions.fontSizeDefault,
                                              color: Theme.of(context)
                                                  .disabledColor,
                                            ),
                                        filled: true,
                                        fillColor: Theme.of(context).cardColor,
                                      ),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline2
                                          .copyWith(
                                            color: Theme.of(context)
                                                .textTheme
                                                .bodyText1
                                                .color,
                                            fontSize: Dimensions.fontSizeLarge,
                                          ),
                                    ),
                                    suggestionsCallback: (pattern) async {
                                      print("suggestionsCallback>>" +
                                          pattern.toString());
                                      return await Get.find<WalletController>()
                                          .filter(pattern);
                                    },
                                    itemBuilder:
                                        (context, BankList suggestion) {
                                      return Padding(
                                        padding: EdgeInsets.all(
                                            Dimensions.PADDING_SIZE_SMALL),
                                        child: Row(children: [
                                          /* Icon(Icons.food_bank),*/
                                          Expanded(
                                            child: Text(suggestion.name,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline2
                                                    .copyWith(
                                                      color: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1
                                                          .color,
                                                      fontSize: Dimensions
                                                          .fontSizeLarge,
                                                    )),
                                          ),
                                        ]),
                                      );
                                    },
                                    onSuggestionSelected:
                                        (BankList suggestion) {
                                      bankNameController.text = suggestion.name;
                                      bankCodeController.text = suggestion.code;
                                    },
                                  )))),

                      /*SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Branch Name',
                          style: robotoRegular.copyWith(
                              fontSize: Dimensions.fontSizeSmall,
                              color: Theme.of(context).disabledColor),
                        ),
                      ),
                      SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                            height: 40,
                            child:
                            DottedBorder(
                                color: Colors.black,
                                strokeWidth: 0.2,
                                child: MyTextField(
                                  hintText: 'Enter Branch Name',
                                  inputType: TextInputType.name,
                                  controller: titleController,
                                  capitalization: TextCapitalization.words,
                                )

                            )),
                      ),*/
                      SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Holder Name',
                          style: robotoRegular.copyWith(
                              fontSize: Dimensions.fontSizeSmall,
                              color: Theme.of(context).disabledColor),
                        ),
                      ),
                      SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                            height: 40,
                            child: DottedBorder(
                                color: Colors.black,
                                strokeWidth: 0.2,
                                child: MyTextField(
                                  hintText: 'Enter Holder Name',
                                  inputType: TextInputType.name,
                                  controller: holder_nameController,
                                  capitalization: TextCapitalization.words,
                                ))),
                      ),
                      SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Account no.',
                          style: robotoRegular.copyWith(
                              fontSize: Dimensions.fontSizeSmall,
                              color: Theme.of(context).disabledColor),
                        ),
                      ),
                      SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                            height: 40,
                            child: DottedBorder(
                                color: Colors.black,
                                strokeWidth: 0.2,
                                child: MyTextField(
                                  hintText: 'Enter Account no.',
                                  inputType: TextInputType.number,
                                  controller: accountnumberController,
                                  capitalization: TextCapitalization.words,
                                ))),
                      ),
                      SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                      SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                      GetBuilder<WalletController>(builder: (orderController) {
                        return !orderController.isLoading
                            ? CustomButton(
                                // margin: ResponsiveHelper.isDesktop(context) ? null : EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                                buttonText: 'submit'.tr,
                                onPressed: () {
                                  if (bankCodeController.text.isEmpty) {
                                    showCustomSnackBar('Select Bank');
                                  } else if (holder_nameController
                                      .text.isEmpty) {
                                    showCustomSnackBar('Enter holder name !');
                                  } else if (accountnumberController
                                      .text.isEmpty) {
                                    showCustomSnackBar(
                                        'Enter Account number !');
                                  } else {
                                    Get.find<WalletController>()
                                        .addAcountToWallet(
                                            bankCodeController.text.toString(),
                                            accountnumberController.text
                                                .toString(),
                                            holder_nameController.text
                                                .toString());
                                  }
                                },
                              )
                            : Center(child: CircularProgressIndicator());
                      }),
                    ])),
              ),
              color: Colors.white,
            ),
          ),
        );
        /*});*/
      },
    );
  }

  void showAddFundCustomDialog(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController commentController = TextEditingController();
    showGeneralDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 700),
      pageBuilder: (_, __, ___) {
        /*GetBuilder<LocationController>(builder: (locationController)
        {*/
        return Center(
          child: Container(
            height: 250,
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(children: [
                      Align(
                          alignment: Alignment.center,
                          child: Text("Add Fund",
                              style: robotoMedium.copyWith(
                                  fontSize: Dimensions.fontSizeLarge))),
                      /*  Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Take the picture of the home front',
                              style: robotoMedium.copyWith(
                                  color: Theme.of(context).disabledColor,
                                  fontSize: Dimensions.fontSizeLarge))),*/

                      SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                      /*Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Added Account',
                          style: robotoRegular.copyWith(
                              fontSize: Dimensions.fontSizeSmall,
                              color: Theme.of(context).disabledColor),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                            height: 55,
                            width: double.infinity,
                            child: DottedBorder(
                                color: Colors.black,
                                strokeWidth: 0.2,
                                child: Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child:
                                    Column(children: [
                                      SizedBox(
                                          height:
                                          Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                      Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            Get.find<WalletController>()
                                                .bankAccountList[0]
                                                .bank_name,
                                            style: robotoRegular.copyWith(
                                                fontSize: Dimensions.fontSizeSmall,
                                                color: Colors.black),
                                          )),
                                      SizedBox(
                                          height:
                                          Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                      Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            Get.find<WalletController>()
                                                .bankAccountList[0]
                                                .account_no_mask,
                                            style: robotoRegular.copyWith(
                                                fontSize: Dimensions.fontSizeSmall,
                                                color: Colors.black),
                                          ))
                                    ])))),
                      ),*/
                      SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Amount',
                          style: robotoRegular.copyWith(
                              fontSize: Dimensions.fontSizeSmall,
                              color: Theme.of(context).disabledColor),
                        ),
                      ),
                      SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                            height: 40,
                            child: DottedBorder(
                                color: Colors.black,
                                strokeWidth: 0.2,
                                child: MyTextField(
                                  hintText: 'Enter Amount',
                                  inputType: TextInputType.number,
                                  controller: titleController,
                                  capitalization: TextCapitalization.words,
                                ))),
                      ),
                      SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                      GetBuilder<WalletController>(builder: (orderController) {
                        return !orderController.isLoading
                            ? CustomButton(
                                // margin: ResponsiveHelper.isDesktop(context) ? null : EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                                buttonText: 'submit'.tr,
                                onPressed: () {
                                  if (titleController.text.isEmpty) {
                                    showCustomSnackBar('Enter Amount !');
                                  } else {
                                    Get.find<WalletController>()
                                        .addFundToWallet(
                                            titleController.text.toString());
                                  }
                                },
                              )
                            : Center(child: CircularProgressIndicator());
                      }),
                      /* (!Get.find<WalletController>().isLoading?
                      CustomButton(
                        // margin: ResponsiveHelper.isDesktop(context) ? null : EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                        buttonText: 'submit'.tr,
                        onPressed: () {
                          if (titleController.text.isEmpty) {
                            showCustomSnackBar('Enter Amount !');
                          } else {
                            Get.find<WalletController>().addFundToWallet(
                                titleController.text.toString());
                          }
                        },
                      ):
                      Center(child: CircularProgressIndicator())) ,*/
                    ])),
              ),
              color: Colors.white,
            ),
          ),
        );
        /*});*/
      },
    );
  }

  void showWithdrawFundCustomDialog(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController commentController = TextEditingController();
    showGeneralDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 700),
      pageBuilder: (_, __, ___) {
        /*GetBuilder<LocationController>(builder: (locationController)
        {*/
        return Center(
          child: Container(
            height: 300,
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(children: [
                      Align(
                          alignment: Alignment.center,
                          child: Text("WithDraw Request",
                              style: robotoMedium.copyWith(
                                  fontSize: Dimensions.fontSizeLarge))),
                      /*  Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Take the picture of the home front',
                              style: robotoMedium.copyWith(
                                  color: Theme.of(context).disabledColor,
                                  fontSize: Dimensions.fontSizeLarge))),*/
                      SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Account Details',
                          style: robotoRegular.copyWith(
                              fontSize: Dimensions.fontSizeSmall,
                              color: Theme.of(context).disabledColor),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                            height: 55,
                            width: double.infinity,
                            child: DottedBorder(
                                color: Colors.black,
                                strokeWidth: 0.2,
                                child: Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: Column(children: [
                                      SizedBox(
                                          height: Dimensions
                                              .PADDING_SIZE_EXTRA_SMALL),
                                      Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            Get.find<WalletController>()
                                                .bankAccountList[0]
                                                .bank_name,
                                            style: robotoRegular.copyWith(
                                                fontSize:
                                                    Dimensions.fontSizeSmall,
                                                color: Colors.black),
                                          )),
                                      SizedBox(
                                          height: Dimensions
                                              .PADDING_SIZE_EXTRA_SMALL),
                                      Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "**** **** ****" +
                                                Get.find<WalletController>()
                                                    .bankAccountList[0]
                                                    .account_no_mask,
                                            style: robotoRegular.copyWith(
                                                fontSize:
                                                    Dimensions.fontSizeSmall,
                                                color: Colors.black),
                                          ))
                                    ])))),
                      ),
                      SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Amount',
                          style: robotoRegular.copyWith(
                              fontSize: Dimensions.fontSizeSmall,
                              color: Theme.of(context).disabledColor),
                        ),
                      ),
                      SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                            height: 40,
                            child: DottedBorder(
                                color: Colors.black,
                                strokeWidth: 0.2,
                                child: MyTextField(
                                  hintText: 'Enter Amount',
                                  inputType: TextInputType.number,
                                  controller: titleController,
                                  capitalization: TextCapitalization.words,
                                ))),
                      ),
                      SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                      CustomButton(
                        // margin: ResponsiveHelper.isDesktop(context) ? null : EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                        buttonText: 'submit'.tr,
                        onPressed: () {
                          if (titleController.text.isEmpty) {
                            showCustomSnackBar('Enter Amount !');
                          } else {
                            Get.find<WalletController>().withdrawFundToWallet(
                                titleController.text.toString(), "Withdrawal");
                          }
                        },
                      ),
                    ])),
              ),
              color: Colors.white,
            ),
          ),
        );
        /*});*/
      },
      //transitionBuilder: _buildNewTransition,
    );
  }

  void showAddAccountDetailsDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 700),
      pageBuilder: (_, __, ___) {
        /*GetBuilder<LocationController>(builder: (locationController)
        {*/
        return Center(
          child: Container(
            height: 400,
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(children: [
                      Align(
                          alignment: Alignment.center,
                          child: Text("Account Details",
                              style: robotoMedium.copyWith(
                                  fontSize: Dimensions.fontSizeLarge))),
                      /*  Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Take the picture of the home front',
                              style: robotoMedium.copyWith(
                                  color: Theme.of(context).disabledColor,
                                  fontSize: Dimensions.fontSizeLarge))),*/
                      SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Bank Name',
                          style: robotoRegular.copyWith(
                              fontSize: Dimensions.fontSizeSmall,
                              color: Theme.of(context).disabledColor),
                        ),
                      ),
                      SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                      SizedBox(
                          width: Dimensions.WEB_MAX_WIDTH,
                          child: Container(
                              height: 40,
                              child: DottedBorder(
                                  color: Colors.black,
                                  strokeWidth: 0.2,
                                  child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                          Get.find<WalletController>()
                                              .bankAccountList[0]
                                              .bank_name,
                                          style: robotoRegular.copyWith(
                                              fontSize:
                                                  Dimensions.fontSizeSmall,
                                              color: Colors.black)))))),
                      SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Holder Name',
                          style: robotoRegular.copyWith(
                              fontSize: Dimensions.fontSizeSmall,
                              color: Theme.of(context).disabledColor),
                        ),
                      ),
                      SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                            height: 40,
                            child: DottedBorder(
                                color: Colors.black,
                                strokeWidth: 0.2,
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                        Get.find<WalletController>()
                                            .bankAccountList[0]
                                            .full_name
                                            .toString(),
                                        textAlign: TextAlign.left,
                                        style: robotoRegular.copyWith(
                                            fontSize:
                                                Dimensions.fontSizeDefault,
                                            color: Colors.black))))),
                      ),
                      SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Account no.',
                          style: robotoRegular.copyWith(
                              fontSize: Dimensions.fontSizeDefault,
                              color: Theme.of(context).disabledColor),
                        ),
                      ),
                      SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                            height: 40,
                            child: DottedBorder(
                                color: Colors.black,
                                strokeWidth: 0.2,
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                        "**** **** **** " +
                                            Get.find<WalletController>()
                                                .bankAccountList[0]
                                                .account_no_mask,
                                        style: robotoRegular.copyWith(
                                          fontSize: Dimensions.fontSizeDefault,
                                          color: Colors.black,
                                        ))))),
                      ),
                      SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                      SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                      CustomButton(
                        // margin: ResponsiveHelper.isDesktop(context) ? null : EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                        buttonText: 'Delete'.tr,
                        onPressed: () {
                          Get.dialog(
                              ConfirmationDialog(
                                icon: Images.warning,
                                title: 'Are you sure ?'.tr,
                                description: 'You want to delete account'.tr,
                                onYesPressed: () {
                                  Get.find<WalletController>().deleteAccount(
                                      Get.find<WalletController>()
                                          .bankAccountList[0]
                                          .account_no_mask);
                                  Get.back();
                                },
                              ),
                              barrierDismissible: false);
                        },
                      ),
                    ])),
              ),
              color: Colors.white,
            ),
          ),
        );
        /*});*/
      },
    );
  }
}

class WalletShimmer extends StatelessWidget {
  final WalletController walletController;

  WalletShimmer({@required this.walletController});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      key: UniqueKey(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisSpacing: 80,
        mainAxisSpacing: ResponsiveHelper.isDesktop(context)
            ? Dimensions.PADDING_SIZE_LARGE
            : 0.01,
        childAspectRatio: ResponsiveHelper.isDesktop(context) ? 5 : 4.45,
        crossAxisCount: ResponsiveHelper.isMobile(context) ? 1 : 2,
      ),
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 10,
      padding: EdgeInsets.only(top: ResponsiveHelper.isDesktop(context) ? 25 : 25),
      itemBuilder: (context, index) {
        return Padding(
          padding:
              EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL),
          child: Shimmer(
            duration: Duration(seconds: 2),
            enabled: walletController.transactionList == null,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              height: 8,
                              width: 50,
                              decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(2))),
                          SizedBox(height: 8),
                          Container(
                              height: 8,
                              width: 70,
                              decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(2))),
                        ]),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                              height: 8,
                              width: 50,
                              decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(2))),
                          SizedBox(height: 8),
                          Container(
                              height: 8,
                              width: 70,
                              decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(2))),
                        ]),
                  ],
                ),
                Padding(
                    padding: const EdgeInsets.only(
                        top: Dimensions.PADDING_SIZE_LARGE),
                    child: Divider(color: Theme.of(context).disabledColor)),
              ],
            ),
          ),
        );
      },
    );
  }
}
