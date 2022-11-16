import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/controller/auth_controller.dart';
import 'package:sixam_mart/controller/location_controller.dart';
import 'package:sixam_mart/controller/parcel_controller.dart';
import 'package:sixam_mart/controller/user_controller.dart';
import 'package:sixam_mart/data/model/body/errand_order_body.dart';
import 'package:sixam_mart/data/model/response/address_model.dart';
import 'package:sixam_mart/data/model/response/parcel_category_model.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/view/base/custom_app_bar.dart';
import 'package:sixam_mart/view/base/custom_button.dart';
import 'package:sixam_mart/view/base/custom_snackbar.dart';
import 'package:sixam_mart/view/base/menu_drawer.dart';
import 'package:sixam_mart/view/screens/errand/widget/location_view.dart';
import 'package:sixam_mart/view/screens/parcel/widget/parcel_view.dart';

import '../../../controller/order_controller.dart';
import '../../../data/model/body/place_order_body.dart';
import '../../../util/app_constants.dart';
import '../../base/my_text_field.dart';
import 'package:universal_html/html.dart' as html;

class ErrandMainScreen extends StatefulWidget {
  final ParcelCategoryModel category;

  const ErrandMainScreen({Key key, @required this.category}) : super(key: key);

  @override
  State<ErrandMainScreen> createState() => _ParcelLocationScreenState();
}

class _ParcelLocationScreenState extends State<ErrandMainScreen>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  TextEditingController _senderNameController = TextEditingController();
  TextEditingController _senderPhoneController = TextEditingController();
  TextEditingController _receiverNameController = TextEditingController();
  TextEditingController _receiverPhoneController = TextEditingController();
  TextEditingController _senderStreetNumberController = TextEditingController();
  TextEditingController _senderHouseController = TextEditingController();
  TextEditingController _senderFloorController = TextEditingController();
  TextEditingController _orderPriceController = TextEditingController();
  TextEditingController _receiverStreetNumberController = TextEditingController();
  TextEditingController _receiverHouseController = TextEditingController();
  TextEditingController _receiverFloorController = TextEditingController();
  String validity = "";
  TabController _tabController;
  bool checkClickEvent=false;

  bool isLoading=false;
  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, initialIndex: 0, vsync: this);
    Get.find<
        ParcelController>()
        .clear_pickupImage();
    Get.find<ParcelController>().setPickupAddress(
        Get.find<LocationController>().getUserAddress(), false);
    Get.find<ParcelController>().setIsPickedUp(true, false);
    Get.find<ParcelController>().setIsSender(true, false);
    Get.find<ParcelController>().clearMultiDropDestinationAddress();

    if (Get.find<AuthController>().isLoggedIn() &&
        Get.find<LocationController>().addressList == null) {
      Get.find<LocationController>().getAddressList();
    }
    if (Get.find<AuthController>().isLoggedIn()) {
      if (Get.find<UserController>().userInfoModel == null) {
        Get.find<UserController>().getUserInfo();
        _senderNameController.text =
            Get.find<UserController>().userInfoModel != null
                ? Get.find<UserController>().userInfoModel.fName +
                    ' ' +
                    Get.find<UserController>().userInfoModel.lName
                : '';
        _senderPhoneController.text =
            Get.find<UserController>().userInfoModel != null
                ? Get.find<UserController>().userInfoModel.phone
                : '';
      } else {
        _senderNameController.text =
            Get.find<UserController>().userInfoModel.fName +
                    ' ' +
                    Get.find<UserController>().userInfoModel.lName ??
                '';
        _senderPhoneController.text =
            Get.find<UserController>().userInfoModel.phone ?? '';
      }
    }

    _tabController?.addListener(() {
      // if(_tabController.index == 1) {
      //   _validateSender(true);
      // }
      Get.find<ParcelController>()
          .setIsPickedUp(_tabController.index == 0, false);
      Get.find<ParcelController>().setIsSender(_tabController.index == 0, true);
      /*print('my index is' + _tabController.index.toString());
      print('is sender : ${Get.find<ParcelController>().isSender}');*/
    });
  }

  @override
  void dispose() {
    super.dispose();
    _senderNameController.dispose();
    _senderPhoneController.dispose();
    _receiverNameController.dispose();
    _receiverPhoneController.dispose();
    _senderStreetNumberController.dispose();
    _senderHouseController.dispose();
    _senderFloorController.dispose();
    _receiverStreetNumberController.dispose();
    _receiverHouseController.dispose();
    _receiverFloorController.dispose();
    _scrollController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'ERRAND'),
      endDrawer: MenuDrawer(),
      body: GetBuilder<ParcelController>(builder: (parcelController) {
        try {
          if (!checkClickEvent && parcelController.isLoading) {
            Get.find<ParcelController>().startLoader(false);
          }
        } catch (e) {}
        return Container(
          child: CustomScrollView(
            controller: _scrollController,
            physics: AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Column(children: [
                  Column(children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_SMALL),
                      width: Dimensions.WEB_MAX_WIDTH,
                      color: Theme.of(context).cardColor,
                      child: Column(
                        children: [
                          LocationView(
                            isSender: true,
                            nameController: _senderNameController,
                            phoneController: _senderPhoneController,
                            bottomButton: _bottomButton(),
                            streetController: _senderStreetNumberController,
                            floorController: _senderFloorController,
                            houseController: _senderHouseController,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Proposed Price',
                              style: robotoRegular.copyWith(
                                  fontSize: Dimensions.fontSizeSmall,
                                  color: Theme.of(context).disabledColor),
                            ),
                          ),
                          SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                          MyTextField(
                            hintText: 'Type here...',
                            inputType: TextInputType.number,
                            maxLines: 1,
                            controller: _orderPriceController,
                            capitalization: TextCapitalization.words,
                          ),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Expiry time',
                                style: robotoRegular.copyWith(
                                    fontSize: Dimensions.fontSizeSmall,
                                    color: Theme.of(context).disabledColor),
                              )),
                          Divider(),
                          RadioListTile(
                            title: Text("12 hours"),
                            value: "12",
                            groupValue: validity,
                            onChanged: (value) {
                              setState(() {
                                validity = value.toString();
                              });
                            },
                          ),
                          RadioListTile(
                            title: Text("24 hours"),
                            value: "24",
                            groupValue: validity,
                            onChanged: (value) {
                              setState(() {
                                validity = value.toString();
                              });
                            },
                          ),
                          RadioListTile(
                            title: Text("48 hours"),
                            value: "48",
                            groupValue: validity,
                            onChanged: (value) {
                              setState(() {
                                validity = value.toString();
                              });
                            },
                          )
                        ],
                      ),
                    ),
                  ]),
                  if (parcelController.anothertaskList.length > 0)
                    ResponsiveHelper.isDesktop(context)
                        ? SizedBox()
                        : _bottomButton(),
                ]),
              )
            ],
          ),
        );
      }),
    );
  }

  Widget _bottomButton() {
    return GetBuilder<ParcelController>(builder: (parcelController) {
      return
        (!isLoading
          ?
      CustomButton(
              margin: ResponsiveHelper.isDesktop(context)
                  ? null
                  : EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
              buttonText: parcelController.isSender
                  ? 'continue'.tr
                  : 'save_and_continue'.tr,
              onPressed: () {

                if(_orderPriceController.text.isEmpty){
                  showCustomSnackBar('Enter Proposed Price !');
                }else if(parcelController.anothertaskList.length==0){
                  showCustomSnackBar('Add Errand task First !');
                }else if(validity==""){
                  showCustomSnackBar('Select Expiry Time !');
                }
                else {
                  checkClickEvent = true;
                  if (_tabController.index == 0) {
                    _validateSender();
                  }
                  else {

                    isLoading=true;
                    AddressModel _destination = AddressModel(
                      address: parcelController.destinationAddress != null
                          ? parcelController.destinationAddress.address
                          : "",
                      additionalAddress: parcelController.destinationAddress !=
                          null
                          ? parcelController.destinationAddress
                          .additionalAddress
                          : "",
                      addressType: parcelController.destinationAddress != null
                          ? parcelController.destinationAddress.addressType
                          : "",
                      contactPersonName: _receiverNameController.text.trim(),
                      contactPersonNumber: _receiverPhoneController.text.trim(),
                      latitude: parcelController.destinationAddress != null
                          ? parcelController.destinationAddress.latitude
                          : "",
                      longitude: parcelController.destinationAddress != null
                          ? parcelController.destinationAddress.longitude
                          : "",
                      method: parcelController.destinationAddress != null
                          ? parcelController.destinationAddress.method
                          : "",
                      zoneId: parcelController.destinationAddress != null
                          ? parcelController.destinationAddress.zoneId
                          : 0,
                      id: parcelController.destinationAddress != null
                          ? parcelController.destinationAddress.id
                          : 0,
                      streetNumber: _receiverStreetNumberController.text.trim(),
                      house: _receiverHouseController.text.trim(),
                      floor: _receiverFloorController.text.trim(),
                    );

                    parcelController.setDestinationAddress(_destination,false);
                    print(
                        'pickup : ${Get
                            .find<ParcelController>()
                            .pickupAddress
                            .toJson()}');
                    print(
                        'destination : ${Get
                            .find<ParcelController>()
                            .destinationAddress
                            .toJson()}');

                    // Get.toNamed(RouteHelper.getParcelRequestRoute(
                    //   widget.category,
                    //   Get.find<ParcelController>().pickupAddress,
                    //   Get.find<ParcelController>().destinationAddress,
                    // ));

                    Get.find<ParcelController>().startLoader(true);
                    print("anothertaskList>>" +
                        parcelController.anothertaskList.length.toString());
                    Get.find<OrderController>().errandPlaceOrder(
                        ErrandOrderBody(
                            cart: [],
                            couponDiscountAmount: null,
                            distance: parcelController.distance,
                            scheduleAt: null,
                            orderAmount: double.parse(
                                _orderPriceController.text.toString()),
                            orderNote: '',
                            orderType: 'errand',
                            receiverDetails: _destination,
                            /* paymentMethod: 'parcel',*/
                            couponCode: null,
                            storeId: null,
                            address: Get
                                .find<ParcelController>()
                                .pickupAddress
                                .address,
                            latitude: Get
                                .find<ParcelController>()
                                .pickupAddress
                                .latitude,
                            longitude: Get
                                .find<ParcelController>()
                                .pickupAddress
                                .longitude,
                            addressType: Get
                                .find<ParcelController>()
                                .pickupAddress
                                .addressType,
                            contactPersonName: Get
                                .find<ParcelController>()
                                .pickupAddress
                                .contactPersonName ??
                                '',
                            contactPersonNumber: Get
                                .find<ParcelController>()
                                .pickupAddress
                                .contactPersonNumber ??
                                '',
                            streetNumber: Get
                                .find<ParcelController>()
                                .pickupAddress
                                .streetNumber ??
                                '',
                            house: Get
                                .find<ParcelController>()
                                .pickupAddress
                                .house ??
                                '',
                            floor: Get
                                .find<ParcelController>()
                                .pickupAddress
                                .floor ??
                                '',
                            discountAmount: 0,
                            taxAmount: 0,
                            parcelCategoryId: Get
                                .find<ParcelController>()
                                .pickupAddress
                                .id
                                .toString(),
                            chargePayer: parcelController
                                .payerTypes[parcelController.payerIndex],
                            dmTips: "0",
                            receiver_addresses: parcelController.anotherList,
                            task_title: parcelController.anothertaskList,
                            task_uploaded_by: 'customer',
                            validity: validity),
                        orderCallback);
                    //}
                    /*parcelCategoryId: Get.find<ParcelController>().pickupAddress.id.toString()*/
                  }
                }
              },
            )
          : Center(child: CircularProgressIndicator()));
    });
  }

  void orderCallback(bool isSuccess, String message, String orderID) {
    Get.find<ParcelController>().startLoader(true);
    if (isSuccess) {
      isLoading=false;
      Get.find<OrderController>().clear();
      Get.find<ParcelController>().clear();
     /* if (Get.find<ParcelController>().paymentIndex == 0) {*/
        Get.offNamed(RouteHelper.getOrderSuccessRoute(orderID));
        print("if is working");
      /*} else {
        if (GetPlatform.isWeb) {
          Get.back();
          String hostname = html.window.location.hostname;
          String protocol = html.window.location.protocol;
          String selectedUrl =
              '${AppConstants.BASE_URL}/payment-mobile?order_id=$orderID&&customer_id=${Get.find<UserController>().userInfoModel.id}&&callback=$protocol//$hostname${RouteHelper.orderSuccess}?id=$orderID&type=parcel&status=';
          html.window.open(selectedUrl, "_self");
        } else {
          Get.offNamed(RouteHelper.getPaymentRoute(
              orderID, Get.find<UserController>().userInfoModel.id, 'parcel'));
        }
      }*/
    } else {
      print("if is not working");
       isLoading=false;
      showCustomSnackBar(message);
    }

  }

  void _validateSender() {
    if (Get.find<ParcelController>().pickupAddress == null) {
      showCustomSnackBar('select_pickup_address'.tr);
      _tabController.animateTo(0);
    } else if (_senderNameController.text.isEmpty) {
      showCustomSnackBar('enter_sender_name'.tr);
      _tabController.animateTo(0);
    } else if (_senderPhoneController.text.isEmpty) {
      showCustomSnackBar('enter_sender_phone_number'.tr);
      _tabController.animateTo(0);
    } else {
      AddressModel _pickup = AddressModel(
        address: Get.find<ParcelController>().pickupAddress.address,
        additionalAddress:
            Get.find<ParcelController>().pickupAddress.additionalAddress,
        addressType: Get.find<ParcelController>().pickupAddress.addressType,
        contactPersonName: _senderNameController.text.trim(),
        contactPersonNumber: _senderPhoneController.text.trim(),
        latitude: Get.find<ParcelController>().pickupAddress.latitude,
        longitude: Get.find<ParcelController>().pickupAddress.longitude,
        method: Get.find<ParcelController>().pickupAddress.method,
        zoneId: Get.find<ParcelController>().pickupAddress.zoneId,
        id: Get.find<ParcelController>().pickupAddress.id,
        streetNumber: _senderStreetNumberController.text.trim(),
        house: _senderHouseController.text.trim(),
        floor: _senderFloorController.text.trim(),
      );
      Get.find<ParcelController>().setPickupAddress(_pickup, true);
      print('pickup : ${_pickup.toJson()}');
      _tabController.animateTo(1);
    }
  }
}
