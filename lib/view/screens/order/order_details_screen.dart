import 'dart:async';

import 'package:dotted_border/dotted_border.dart';
import 'package:photo_view/photo_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sixam_mart/controller/order_controller.dart';
import 'package:sixam_mart/controller/splash_controller.dart';
import 'package:sixam_mart/data/model/response/order_details_model.dart';
import 'package:sixam_mart/data/model/response/order_model.dart';
import 'package:sixam_mart/helper/date_converter.dart';
import 'package:sixam_mart/helper/price_converter.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/view/base/confirmation_dialog.dart';
import 'package:sixam_mart/view/base/custom_app_bar.dart';
import 'package:sixam_mart/view/base/custom_button.dart';
import 'package:sixam_mart/view/base/custom_image.dart';
import 'package:sixam_mart/view/base/custom_snackbar.dart';
import 'package:sixam_mart/view/base/footer_view.dart';
import 'package:sixam_mart/view/base/menu_drawer.dart';
import 'package:sixam_mart/view/screens/order/widget/order_item_widget.dart';
import 'package:sixam_mart/view/screens/parcel/widget/card_widget.dart';
import 'package:sixam_mart/view/screens/parcel/widget/details_widget.dart';
import 'package:sixam_mart/view/screens/review/rate_review_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../controller/parcel_controller.dart';
import '../../../controller/user_controller.dart';
import '../../../util/app_constants.dart';
import '../checkout/widget/payment_button.dart';
import 'package:universal_html/html.dart' as html;

class OrderDetailsScreen extends StatefulWidget {
  final OrderModel orderModel;
  final int orderId;

  OrderDetailsScreen({@required this.orderModel, @required this.orderId});

  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  StreamSubscription _stream;

  String payment_type = "";

  void _loadData(BuildContext context, bool reload) async {
    await Get.find<OrderController>().trackOrder(
        widget.orderId.toString(), reload ? null : widget.orderModel, false);
    if (widget.orderModel == null) {
      await Get.find<SplashController>().getConfigData();
    }
    Get.find<OrderController>().getOrderDetails(widget.orderId.toString());
  }

  @override
  void initState() {
    super.initState();

    _stream = FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("onMessage on Details: ${message.data}");
      _loadData(context, true);
    });

    _loadData(context, false);
  }

  @override
  void dispose() {
    super.dispose();

    _stream.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (widget.orderModel == null) {
          return Get.offAllNamed(RouteHelper.getInitialRoute());
        } else {
          return true;
        }
      },
      child: Scaffold(
        appBar: CustomAppBar(
            title: 'order_details'.tr,
            onBackPressed: () {
              if (widget.orderModel == null) {
                Get.offAllNamed(RouteHelper.getInitialRoute());
              } else {
                Get.back();
              }
            }),
        endDrawer: MenuDrawer(),
        body: GetBuilder<OrderController>(builder: (orderController) {
          double _deliveryCharge = 0;
          double _itemsPrice = 0;
          double _discount = 0;
          double _couponDiscount = 0;
          double _tax = 0;
          double _addOns = 0;
          double _dmTips = 0;
          OrderModel _order = orderController.trackModel;
          bool _parcel = false;
          bool _errand = false;

          if (orderController.orderDetails != null) {
            _parcel = _order.orderType == 'parcel';
            _errand = _order.orderType == 'errand';
            _deliveryCharge = _order.deliveryCharge;
            _couponDiscount = _order.couponDiscountAmount;
            _discount = _order.storeDiscountAmount;
            _tax = _order.totalTaxAmount;
            _dmTips = _order.dmTips;
            for (OrderDetailsModel orderDetails
            in orderController.orderDetails) {
              for (AddOn addOn in orderDetails.addOns) {
                _addOns = _addOns + (addOn.price * addOn.quantity);
              }
              _itemsPrice =
                  _itemsPrice + (orderDetails.price * orderDetails.quantity);
            }
          }
          double _subTotal = _itemsPrice + _addOns;
          double _total=0;
          if(_errand){
            _total=_order.orderAmount;
          }
          else{
          _total = _itemsPrice +
              _addOns -
              _discount +
              _tax +
              _deliveryCharge -
              _couponDiscount +
              _dmTips;}


          return orderController.orderDetails != null
              ? Column(children: [
            Expanded(
                child: Scrollbar(
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      padding: ResponsiveHelper.isDesktop(context)
                          ? EdgeInsets.zero
                          : EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                      child: FooterView(
                          child: SizedBox(
                              width: Dimensions.WEB_MAX_WIDTH,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(children: [
                                      Text(
                                          '${_parcel
                                              ? 'delivery_id'.tr
                                              : 'order_id'.tr}:',
                                          style: robotoRegular),
                                      SizedBox(
                                          width: Dimensions
                                              .PADDING_SIZE_EXTRA_SMALL),
                                      Text(_order.id.toString(),
                                          style: robotoMedium),
                                      SizedBox(
                                          width: Dimensions
                                              .PADDING_SIZE_EXTRA_SMALL),
                                      Expanded(child: SizedBox()),
                                      Icon(Icons.watch_later, size: 17),
                                      SizedBox(
                                          width: Dimensions
                                              .PADDING_SIZE_EXTRA_SMALL),
                                      Text(
                                        DateConverter.dateTimeStringToDateTime(
                                            _order.createdAt),
                                        style: robotoRegular,
                                      ),
                                    ]),
                                    SizedBox(
                                        height: Dimensions.PADDING_SIZE_SMALL),

                                    _order.scheduled == 1
                                        ? Row(children: [
                                      Text('${'scheduled_at'.tr}:',
                                          style: robotoRegular),
                                      SizedBox(
                                          width: Dimensions
                                              .PADDING_SIZE_EXTRA_SMALL),
                                      Text(
                                          DateConverter
                                              .dateTimeStringToDateTime(
                                              _order.scheduleAt),
                                          style: robotoMedium),
                                    ])
                                        : SizedBox(),
                                    SizedBox(
                                        height: _order.scheduled == 1
                                            ? Dimensions.PADDING_SIZE_SMALL
                                            : 0),

                                    Get
                                        .find<SplashController>()
                                        .configModel
                                        .orderDeliveryVerification
                                        ? Row(children: [
                                      Text(
                                          '${'delivery_verification_code'.tr}:',
                                          style: robotoRegular),
                                      SizedBox(
                                          width: Dimensions
                                              .PADDING_SIZE_EXTRA_SMALL),
                                      Text(_order.otp, style: robotoMedium),
                                    ])
                                        : SizedBox(),
                                    // Text('${'scheduled_at'.tr}:'+_order.dropoff_locations.length.toString(), style: robotoRegular),

                                    SizedBox(
                                        height: Get
                                            .find<SplashController>()
                                            .configModel
                                            .orderDeliveryVerification
                                            ? 10
                                            : 0),

                                    Row(children: [
                                      Text(_order.orderType.tr,
                                          style: robotoMedium),
                                      Expanded(child: SizedBox()),
                                      _order.paymentMethod !=null?
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                            Dimensions.PADDING_SIZE_SMALL,
                                            vertical: Dimensions
                                                .PADDING_SIZE_EXTRA_SMALL),
                                        decoration: BoxDecoration(
                                          color: Theme
                                              .of(context)
                                              .primaryColor,
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.RADIUS_SMALL),
                                        ),
                                        child: Text(
                                          _order.paymentMethod ==
                                              'cash_on_delivery'
                                              ? 'cash_on_delivery'.tr
                                              :_order.paymentMethod =='wallet'? 'wallet'.tr:_order.paymentMethod =='digital_payment'|| _order.paymentMethod =='flutterwave'? 'digital_payment'.tr:_order.paymentMethod =='flutterwave'?'digital_payment'.tr:"",
                                          style: robotoRegular.copyWith(
                                              color: Theme
                                                  .of(context)
                                                  .cardColor,
                                              fontSize:
                                              Dimensions.fontSizeExtraSmall),
                                        ),
                                      ):Text(""),
                                    ]),
                                    Divider(
                                        height: Dimensions.PADDING_SIZE_LARGE),

                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: Dimensions
                                              .PADDING_SIZE_EXTRA_SMALL),
                                      child:
                                      _order.orderType=='errand'?
                                      Row(children: [

                                        Text(
                                            'No. of Task',
                                            style: robotoRegular),
                                        SizedBox(
                                            width: Dimensions
                                                .PADDING_SIZE_EXTRA_SMALL),
                                        Text(_order!=null?_order.errand_tasks!=null?
                                          _order.errand_tasks.length
                                              .toString():"":"  ",
                                          style: robotoMedium.copyWith(
                                              color:
                                              Theme
                                                  .of(context)
                                                  .primaryColor),
                                        ),
                                        Expanded(child: SizedBox()),
                                        Container(
                                            height: 7,
                                            width: 7,
                                            decoration: BoxDecoration(
                                              color: (_order.orderStatus ==
                                                  'failed' ||
                                                  _order.orderStatus ==
                                                      'refunded')
                                                  ? Colors.red
                                                  : Colors.green,
                                              shape: BoxShape.circle,
                                            )),
                                        SizedBox(
                                            width: Dimensions
                                                .PADDING_SIZE_EXTRA_SMALL),
                                        (_order != null &&
                                            _order.delivered == "" ?
                                        Text(
                                          _order.orderStatus == 'delivered'
                                              ? '${'delivered_at'
                                              .tr} ${DateConverter
                                              .dateTimeStringToDateTime(
                                              _order != null &&
                                                  _order.delivered != ""
                                                  ? _order.delivered
                                                  : 0)}'
                                              : _order.orderStatus.tr,
                                          style: robotoRegular.copyWith(
                                              fontSize: Dimensions
                                                  .fontSizeSmall),
                                        ) : SizedBox()),
                                      ]):
                                      Row(children: [

                                        Text(
                                            '${_parcel
                                                ? 'charge_pay_by'.tr
                                                : 'item'.tr}:',
                                            style: robotoRegular),
                                        SizedBox(
                                            width: Dimensions
                                                .PADDING_SIZE_EXTRA_SMALL),
                                        Text(
                                          _parcel
                                              ? _order.chargePayer.tr
                                              : orderController
                                              .orderDetails.length
                                              .toString(),
                                          style: robotoMedium.copyWith(
                                              color:
                                              Theme
                                                  .of(context)
                                                  .primaryColor),
                                        ),
                                        Expanded(child: SizedBox()),
                                        Container(
                                            height: 7,
                                            width: 7,
                                            decoration: BoxDecoration(
                                              color: (_order.orderStatus ==
                                                  'failed' ||
                                                  _order.orderStatus ==
                                                      'refunded')
                                                  ? Colors.red
                                                  : Colors.green,
                                              shape: BoxShape.circle,
                                            )),
                                        SizedBox(
                                            width: Dimensions
                                                .PADDING_SIZE_EXTRA_SMALL),
                                        (_order != null &&
                                            _order.delivered == "" ?
                                        Text(
                                          _order.orderStatus == 'delivered'
                                              ? '${'delivered_at'
                                              .tr} ${DateConverter
                                              .dateTimeStringToDateTime(
                                              _order != null &&
                                                  _order.delivered != ""
                                                  ? _order.delivered
                                                  : 0)}'
                                              : _order.orderStatus.tr,
                                          style: robotoRegular.copyWith(
                                              fontSize: Dimensions
                                                  .fontSizeSmall),
                                        ) : SizedBox()),
                                      ]),
                                    ),
                                    Divider(
                                        height: Dimensions.PADDING_SIZE_LARGE),
                                    SizedBox(
                                        height: Dimensions.PADDING_SIZE_SMALL),

                                    _parcel
                                        ? CardWidget(
                                        child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                            children: [
                                              DetailsWidget(
                                                  title: 'sender_details'.tr,
                                                  address:
                                                  _order.deliveryAddress),
                                              SizedBox(
                                                  height: Dimensions
                                                      .PADDING_SIZE_LARGE),
                                              //DetailsWidget(title: 'receiver_details'.tr, address: _order.receiverDetails),
                                              /* DetailsWidget(
                                                  title: 'receiver_details'.tr,
                                                  address:
                        l                              _order.deliveryAddress),*/
                                              Text('receiver_details'.tr,
                                                  style: robotoMedium),
                                              /*Card(
                                                    child: Padding(
                                                        padding: EdgeInsets.all(
                                                            Dimensions
                                                                .PADDING_SIZE_SMALL),
                                                        child:
                                              Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      _order.deliveryAddress
                                                              .contactPersonName ??
                                                          '',
                                                      style: robotoRegular.copyWith(
                                                          fontSize: Dimensions
                                                              .fontSizeSmall,
                                                          color: Theme.of(
                                                                  context)
                                                              .primaryColor),
                                                    ),
                                                    Text(
                                                      _order.deliveryAddress
                                                              .address ??
                                                          '',
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: robotoRegular.copyWith(
                                                          fontSize: Dimensions
                                                              .fontSizeSmall),
                                                    ),
                                                    Wrap(children: [
                                                      (_order.deliveryAddress
                                                                      .streetNumber !=
                                                                  null &&
                                                              _order
                                                                  .deliveryAddress
                                                                  .streetNumber
                                                                  .isNotEmpty)
                                                          ? Text(
                                                              'street_number'
                                                                      .tr +
                                                                  ': ' +
                                                                  _order
                                                                      .deliveryAddress
                                                                      .streetNumber +
                                                                  ', ',
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: robotoRegular.copyWith(
                                                                  fontSize:
                                                                      Dimensions
                                                                          .fontSizeSmall,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .hintColor),
                                                            )
                                                          : SizedBox(),
                                                      (_order.deliveryAddress
                                                                      .house !=
                                                                  null &&
                                                              _order
                                                                  .deliveryAddress
                                                                  .house
                                                                  .isNotEmpty)
                                                          ? Text(
                                                              'house'.tr +
                                                                  ': ' +
                                                                  _order
                                                                      .deliveryAddress
                                                                      .house +
                                                                  ', ',
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: robotoRegular.copyWith(
                                                                  fontSize:
                                                                      Dimensions
                                                                          .fontSizeSmall,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .hintColor),
                                                            )
                                                          : SizedBox(),
                                                      (_order.deliveryAddress
                                                                      .floor !=
                                                                  null &&
                                                              _order
                                                                  .deliveryAddress
                                                                  .floor
                                                                  .isNotEmpty)
                                                          ? Text(
                                                              'floor'.tr +
                                                                  ': ' +
                                                                  _order
                                                                      .deliveryAddress
                                                                      .floor,
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: robotoRegular.copyWith(
                                                                  fontSize:
                                                                      Dimensions
                                                                          .fontSizeSmall,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .hintColor),
                                                            )
                                                          : SizedBox(),
                                                    ]),
                                                    Text(
                                                      _order.deliveryAddress
                                                              .contactPersonNumber ??
                                                          '',
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: robotoRegular.copyWith(
                                                          fontSize: Dimensions
                                                              .fontSizeSmall),
                                                    ),
                                                  ]),),),*/
                                              // Text('receiver_details'.tr, style: robotoMedium),
                                              SizedBox(
                                                  height: Dimensions
                                                      .PADDING_SIZE_EXTRA_SMALL),
                                              ListView.builder(
                                                shrinkWrap: true,
                                                physics:
                                                NeverScrollableScrollPhysics(),
                                                itemCount: _order
                                                    .dropoff_locations.length,
                                                padding: EdgeInsets.zero,
                                                itemBuilder: (context, index) {
                                                  int drop_count = index + 1;
                                                  return Card(
                                                    child: Padding(
                                                      padding: EdgeInsets.all(
                                                          Dimensions
                                                              .PADDING_SIZE_SMALL),
                                                      child: Column(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          children: [
                                                            Row(children: [
                                                              Text(
                                                                  "Drop Point: " +
                                                                      drop_count
                                                                          .toString(),
                                                                  style:
                                                                  robotoMedium),
                                                              SizedBox(
                                                                  height: Dimensions
                                                                      .PADDING_SIZE_EXTRA_SMALL),
                                                              Text("",
                                                                  style:
                                                                  robotoMedium),
                                                              SizedBox(
                                                                  width: Dimensions
                                                                      .PADDING_SIZE_EXTRA_SMALL),
                                                              Expanded(
                                                                  child:
                                                                  SizedBox()),
                                                              if (_order
                                                                  .dropoff_locations[
                                                              index]
                                                                  .status ==
                                                                  "delivered"
                                                                  ? true
                                                                  : false)
                                                                Container(
                                                                    height: 7,
                                                                    width: 7,
                                                                    decoration: BoxDecoration(
                                                                        shape: BoxShape
                                                                            .circle,
                                                                        color: Colors
                                                                            .green)),
                                                              if (_order
                                                                  .dropoff_locations[
                                                              index]
                                                                  .status ==
                                                                  "delivered"
                                                                  ? true
                                                                  : false)
                                                                SizedBox(
                                                                    width: Dimensions
                                                                        .PADDING_SIZE_EXTRA_SMALL),
                                                              if (_order
                                                                  .dropoff_locations[index]
                                                                  .status ==
                                                                  "delivered"
                                                                  ? true
                                                                  : false)
                                                                Text(
                                                                  "Delivered",
                                                                  style: robotoRegular
                                                                      .copyWith(
                                                                      color: Theme
                                                                          .of(
                                                                          context)
                                                                          .primaryColor,
                                                                      fontSize:
                                                                      Dimensions
                                                                          .fontSizeSmall),
                                                                ),
                                                            ]),
                                                            SizedBox(
                                                                height: Dimensions
                                                                    .PADDING_SIZE_EXTRA_SMALL),
                                                            Text(
                                                              _order
                                                                  .dropoff_locations[
                                                              index]
                                                                  .receiver_details
                                                                  .contactPersonName ??
                                                                  '',
                                                              style: robotoRegular
                                                                  .copyWith(
                                                                  fontSize:
                                                                  Dimensions
                                                                      .fontSizeSmall,
                                                                  color: Theme
                                                                      .of(
                                                                      context)
                                                                      .primaryColor),
                                                            ),
                                                            Text(
                                                              _order
                                                                  .dropoff_locations[
                                                              index]
                                                                  .receiver_details
                                                                  .address ??
                                                                  '',
                                                              maxLines: 1,
                                                              overflow:
                                                              TextOverflow
                                                                  .ellipsis,
                                                              style: robotoRegular
                                                                  .copyWith(
                                                                  fontSize:
                                                                  Dimensions
                                                                      .fontSizeSmall),
                                                            ),
                                                            Wrap(children: [
                                                              (_order
                                                                  .dropoff_locations[index]
                                                                  .receiver_details
                                                                  .streetNumber !=
                                                                  null &&
                                                                  _order
                                                                      .dropoff_locations[
                                                                  index]
                                                                      .receiver_details
                                                                      .streetNumber
                                                                      .isNotEmpty)
                                                                  ? Text(
                                                                'street_number'
                                                                    .tr +
                                                                    ': ' +
                                                                    _order
                                                                        .dropoff_locations[index]
                                                                        .receiver_details
                                                                        .streetNumber +
                                                                    ', ',
                                                                maxLines:
                                                                1,
                                                                overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                                style: robotoRegular
                                                                    .copyWith(
                                                                    fontSize: Dimensions
                                                                        .fontSizeSmall,
                                                                    color:
                                                                    Theme
                                                                        .of(
                                                                        context)
                                                                        .hintColor),
                                                              )
                                                                  : SizedBox(),
                                                              (_order
                                                                  .dropoff_locations[index]
                                                                  .receiver_details
                                                                  .house !=
                                                                  null &&
                                                                  _order
                                                                      .dropoff_locations[
                                                                  index]
                                                                      .receiver_details
                                                                      .house
                                                                      .isNotEmpty)
                                                                  ? Text(
                                                                'house'.tr +
                                                                    ': ' +
                                                                    _order
                                                                        .dropoff_locations[index]
                                                                        .receiver_details
                                                                        .house +
                                                                    ', ',
                                                                maxLines:
                                                                1,
                                                                overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                                style: robotoRegular
                                                                    .copyWith(
                                                                    fontSize: Dimensions
                                                                        .fontSizeSmall,
                                                                    color:
                                                                    Theme
                                                                        .of(
                                                                        context)
                                                                        .hintColor),
                                                              )
                                                                  : SizedBox(),
                                                              (_order
                                                                  .dropoff_locations[index]
                                                                  .receiver_details
                                                                  .floor !=
                                                                  null &&
                                                                  _order
                                                                      .dropoff_locations[
                                                                  index]
                                                                      .receiver_details
                                                                      .floor
                                                                      .isNotEmpty)
                                                                  ? Text(
                                                                'floor'.tr +
                                                                    ': ' +
                                                                    _order
                                                                        .dropoff_locations[index]
                                                                        .receiver_details
                                                                        .floor,
                                                                maxLines:
                                                                1,
                                                                overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                                style: robotoRegular
                                                                    .copyWith(
                                                                    fontSize: Dimensions
                                                                        .fontSizeSmall,
                                                                    color:
                                                                    Theme
                                                                        .of(
                                                                        context)
                                                                        .hintColor),
                                                              )
                                                                  : SizedBox(),
                                                            ]),
                                                            Text(
                                                              _order
                                                                  .dropoff_locations[
                                                              index]
                                                                  .receiver_details
                                                                  .contactPersonNumber ??
                                                                  '',
                                                              maxLines: 1,
                                                              overflow:
                                                              TextOverflow
                                                                  .ellipsis,
                                                              style: robotoRegular
                                                                  .copyWith(
                                                                  fontSize:
                                                                  Dimensions
                                                                      .fontSizeSmall),
                                                            ),
                                                            SizedBox(
                                                                height: Dimensions
                                                                    .PADDING_SIZE_EXTRA_SMALL),
                                                            Text(
                                                                "OTP: " +
                                                                    _order
                                                                        .dropoff_locations[
                                                                    index]
                                                                        .otp
                                                                        .toString(),
                                                                style: robotoMedium
                                                                    .copyWith(
                                                                    color: Theme
                                                                        .of(
                                                                        context)
                                                                        .primaryColor)),
                                                          ]),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ]))
                                        : ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                      NeverScrollableScrollPhysics(),
                                      itemCount: orderController
                                          .orderDetails.length,
                                      padding: EdgeInsets.zero,
                                      itemBuilder: (context, index) {
                                        return OrderItemWidget(
                                            order: _order,
                                            orderDetails: orderController
                                                .orderDetails[index]);
                                      },
                                    ),
                                    SizedBox(
                                        height: _parcel
                                            ? Dimensions.PADDING_SIZE_LARGE
                                            : 0),

                                    Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          (Get
                                              .find<SplashController>()
                                              .getModule(
                                              _order.moduleType)
                                              .orderAttachment &&
                                              _order.orderAttachment !=
                                                  null &&
                                              _order
                                                  .orderAttachment.isNotEmpty)
                                              ? Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text('prescription'.tr,
                                                    style: robotoRegular),
                                                SizedBox(
                                                    height: Dimensions
                                                        .PADDING_SIZE_SMALL),
                                                InkWell(
                                                  onTap: () =>
                                                      openDialog(
                                                          context,
                                                          '${Get
                                                              .find<
                                                              SplashController>()
                                                              .configModel
                                                              .baseUrls
                                                              .orderAttachmentUrl}/${_order
                                                              .orderAttachment}'),
                                                  child: Center(
                                                      child: ClipRRect(
                                                        borderRadius: BorderRadius
                                                            .circular(Dimensions
                                                            .RADIUS_SMALL),
                                                        child: CustomImage(
                                                          image:
                                                          '${Get
                                                              .find<
                                                              SplashController>()
                                                              .configModel
                                                              .baseUrls
                                                              .orderAttachmentUrl}/${_order
                                                              .orderAttachment}',
                                                          width: 100,
                                                          height: 100,
                                                        ),
                                                      )),
                                                ),
                                                SizedBox(
                                                    height: Dimensions
                                                        .PADDING_SIZE_LARGE),
                                              ])
                                              : SizedBox(),
                                          SizedBox(
                                              width: (Get
                                                  .find<SplashController>()
                                                  .getModule(
                                                  _order.moduleType)
                                                  .orderAttachment &&
                                                  _order.orderAttachment !=
                                                      null &&
                                                  _order.orderAttachment
                                                      .isNotEmpty)
                                                  ? Dimensions
                                                  .PADDING_SIZE_SMALL
                                                  : 0),
                                          (_order.orderNote != null &&
                                              _order.orderNote.isNotEmpty)
                                              ? Expanded(
                                            child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  Text('additional_note'.tr,
                                                      style: robotoRegular),
                                                  SizedBox(
                                                      height: Dimensions
                                                          .PADDING_SIZE_SMALL),
                                                  Container(
                                                    width: Dimensions
                                                        .WEB_MAX_WIDTH,
                                                    padding: EdgeInsets.all(
                                                        Dimensions
                                                            .PADDING_SIZE_SMALL),
                                                    decoration:
                                                    BoxDecoration(
                                                      borderRadius: BorderRadius
                                                          .circular(Dimensions
                                                          .RADIUS_SMALL),
                                                      border: Border.all(
                                                          width: 1,
                                                          color: Theme
                                                              .of(
                                                              context)
                                                              .disabledColor),
                                                    ),
                                                    child: Text(
                                                      _order.orderNote,
                                                      style: robotoRegular
                                                          .copyWith(
                                                          fontSize: Dimensions
                                                              .fontSizeSmall,
                                                          color: Theme
                                                              .of(
                                                              context)
                                                              .disabledColor),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                      height: Dimensions
                                                          .PADDING_SIZE_LARGE),
                                                ]),
                                          )
                                              : SizedBox(),
                                        ]),

                                    CardWidget(
                                        showCard: _parcel,
                                        child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  _parcel
                                                      ? 'parcel_category'.tr
                                                      : Get
                                                      .find<SplashController>()
                                                      .getModule(_order
                                                      .moduleType)
                                                      .showRestaurantText
                                                      ? 'restaurant_details'
                                                      .tr
                                                      : 'store_details'.tr,
                                                  style: robotoRegular),
                                              SizedBox(
                                                  height: Dimensions
                                                      .PADDING_SIZE_EXTRA_SMALL),
                                              (_parcel &&
                                                  _order.parcelCategory ==
                                                      null)
                                                  ? Text(
                                                'no_parcel_category_data_found'
                                                    .tr,
                                              )
                                                  : _order.store != null
                                                  ?
                                              Row(children: [
                                                ClipOval(
                                                    child: CustomImage(
                                                      image: _parcel
                                                          ? '${Get
                                                          .find<
                                                          SplashController>()
                                                          .configModel
                                                          .baseUrls
                                                          .parcelCategoryImageUrl}/${_order
                                                          .parcelCategory
                                                          .image}'
                                                          : '${Get
                                                          .find<
                                                          SplashController>()
                                                          .configModel
                                                          .baseUrls
                                                          .storeImageUrl}/${_order
                                                          .store.logo}',
                                                      height: 35,
                                                      width: 35,
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
                                                            _parcel
                                                                ? _order
                                                                .parcelCategory
                                                                .name
                                                                : _order
                                                                .store
                                                                .name,
                                                            maxLines: 1,
                                                            overflow:
                                                            TextOverflow
                                                                .ellipsis,
                                                            style: robotoRegular
                                                                .copyWith(
                                                                fontSize:
                                                                Dimensions
                                                                    .fontSizeSmall),
                                                          ),
                                                          Text(
                                                            _parcel
                                                                ? _order
                                                                .parcelCategory
                                                                .description
                                                                : _order
                                                                .store
                                                                .address,
                                                            maxLines: 1,
                                                            overflow:
                                                            TextOverflow
                                                                .ellipsis,
                                                            style: robotoRegular
                                                                .copyWith(
                                                                fontSize:
                                                                Dimensions
                                                                    .fontSizeSmall,
                                                                color: Theme
                                                                    .of(
                                                                    context)
                                                                    .disabledColor),
                                                          ),
                                                        ])),
                                                (!_parcel &&
                                                    _order.orderType ==
                                                        'take_away' &&
                                                    (_order
                                                        .orderStatus ==
                                                        'pending' ||
                                                        _order.orderStatus ==
                                                            'accepted' ||
                                                        _order.orderStatus ==
                                                            'confirmed' ||
                                                        _order.orderStatus ==
                                                            'processing' ||
                                                        _order.orderStatus ==
                                                            'handover' ||
                                                        _order.orderStatus ==
                                                            'picked_up'))
                                                    ? TextButton.icon(
                                                  onPressed:
                                                      () async {
                                                    if (!_parcel) {
                                                      String url =
                                                          'https://www.google.com/maps/dir/?api=1&destination=${_order
                                                          .store.latitude}'
                                                          ',${_order.store
                                                          .longitude}&mode=d';
                                                      if (await canLaunchUrlString(
                                                          url)) {
                                                        await launchUrlString(
                                                            url);
                                                      } else {
                                                        showCustomSnackBar(
                                                            'unable_to_launch_google_map'
                                                                .tr);
                                                      }
                                                    }
                                                  },
                                                  icon: Icon(Icons
                                                      .directions),
                                                  label: Text(
                                                      'direction'
                                                          .tr),
                                                )
                                                    : SizedBox(),
                                              ])
                                                  : Center(
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: Dimensions
                                                            .PADDING_SIZE_SMALL),
                                                    child: Text(
                                                        'no_restaurant_data_found'
                                                            .tr,
                                                        maxLines: 1,
                                                        overflow:
                                                        TextOverflow
                                                            .ellipsis,
                                                        style: robotoRegular
                                                            .copyWith(
                                                            fontSize:
                                                            Dimensions
                                                                .fontSizeSmall)),
                                                  )),
                                            ])),
                                    SizedBox(
                                        height: _parcel
                                            ? 0
                                            : Dimensions.PADDING_SIZE_LARGE),

                                    // Total
                                    _parcel
                                        ? SizedBox()
                                        : _errand
                                        ? SizedBox()
                                        : Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Text('item_price'.tr,
                                                    style:
                                                    robotoRegular),
                                                Text(
                                                    PriceConverter
                                                        .convertPrice(
                                                        _itemsPrice),
                                                    style:
                                                    robotoRegular),
                                              ]),
                                          SizedBox(height: 10),
                                          Get
                                              .find<SplashController>()
                                              .getModule(
                                              _order.moduleType)
                                              .addOn
                                              ? Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              Text('addons'.tr,
                                                  style:
                                                  robotoRegular),
                                              Text(
                                                  '(+) ${PriceConverter
                                                      .convertPrice(_addOns)}',
                                                  style:
                                                  robotoRegular),
                                            ],
                                          )
                                              : SizedBox(),
                                          Get
                                              .find<SplashController>()
                                              .getModule(
                                              _order.moduleType)
                                              .addOn
                                              ? Divider(
                                            thickness: 1,
                                            color: Theme
                                                .of(
                                                context)
                                                .hintColor
                                                .withOpacity(0.5),
                                          )
                                              : SizedBox(),
                                          Get
                                              .find<SplashController>()
                                              .getModule(
                                              _order.moduleType)
                                              .addOn
                                              ? Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              Text('subtotal'.tr,
                                                  style:
                                                  robotoMedium),
                                              Text(
                                                  PriceConverter
                                                      .convertPrice(
                                                      _subTotal),
                                                  style:
                                                  robotoMedium),
                                            ],
                                          )
                                              : SizedBox(),
                                          SizedBox(
                                              height: Get
                                                  .find<
                                                  SplashController>()
                                                  .getModule(_order
                                                  .moduleType)
                                                  .addOn
                                                  ? 10
                                                  : 0),
                                          Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Text('discount'.tr,
                                                    style:
                                                    robotoRegular),
                                                Text(
                                                    '(-) ${PriceConverter
                                                        .convertPrice(
                                                        _discount)}',
                                                    style:
                                                    robotoRegular),
                                              ]),
                                          SizedBox(height: 10),
                                          _couponDiscount > 0
                                              ? Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Text(
                                                    'coupon_discount'
                                                        .tr,
                                                    style:
                                                    robotoRegular),
                                                Text(
                                                  '(-) ${PriceConverter
                                                      .convertPrice(
                                                      _couponDiscount)}',
                                                  style:
                                                  robotoRegular,
                                                ),
                                              ])
                                              : SizedBox(),
                                          SizedBox(
                                              height:
                                              _couponDiscount > 0
                                                  ? 10
                                                  : 0),
                                          Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Text('vat_tax'.tr,
                                                    style:
                                                    robotoRegular),
                                                Text(
                                                    '(+) ${PriceConverter
                                                        .convertPrice(_tax)}',
                                                    style:
                                                    robotoRegular),
                                              ]),
                                          SizedBox(height: 10),
                                          (_dmTips > 0)
                                              ? Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              Text(
                                                  'delivery_man_tips'
                                                      .tr,
                                                  style:
                                                  robotoRegular),
                                              Text(
                                                  '(+) ${PriceConverter
                                                      .convertPrice(_dmTips)}',
                                                  style:
                                                  robotoRegular),
                                            ],
                                          )
                                              : SizedBox(),
                                          SizedBox(
                                              height:
                                              _dmTips > 0 ? 10 : 0),
                                          Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Text('delivery_fee'.tr,
                                                    style:
                                                    robotoRegular),
                                                _deliveryCharge > 0
                                                    ? Text(
                                                  '(+) ${PriceConverter
                                                      .convertPrice(
                                                      _deliveryCharge)}',
                                                  style:
                                                  robotoRegular,
                                                )
                                                    : Text('free'.tr,
                                                    style: robotoRegular
                                                        .copyWith(
                                                        color: Theme
                                                            .of(
                                                            context)
                                                            .primaryColor)),
                                              ]),
                                        ]),
                                    if (!_errand)
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical:
                                            Dimensions.PADDING_SIZE_SMALL),
                                        child: Divider(
                                            thickness: 1,
                                            color: Theme
                                                .of(context)
                                                .hintColor
                                                .withOpacity(0.5)),
                                      ),
                                    if (!_errand)
                                      Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('total_amount'.tr,
                                                style: robotoMedium.copyWith(
                                                  fontSize:
                                                  Dimensions.fontSizeLarge,
                                                  color: Theme
                                                      .of(context)
                                                      .primaryColor,
                                                )),
                                            Text(
                                              PriceConverter.convertPrice(
                                                  _total),
                                              style: robotoMedium.copyWith(
                                                  fontSize:
                                                  Dimensions.fontSizeLarge,
                                                  color: Theme
                                                      .of(context)
                                                      .primaryColor),
                                            ),
                                          ]),

                                    if (_order.orderType == 'errand' &&
                                        _errand && _order
                                        .errand_bids != null &&
                                        _order.errand_bids.length >
                                            0)
                                      Text('Errand Bids', style: robotoRegular),

                                    if (_order.orderType == 'errand' &&
                                        _errand && _order.errand_bids != null &&
                                        _order.errand_bids.length >
                                            0)
                                      ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: _order.errand_bids.length,
                                        padding: EdgeInsets.zero,
                                        itemBuilder: (context, index) {
                                          double amount = double.parse(
                                              _order
                                                  .errand_bids[index]
                                                  .counter_amount);

                                          return Card(
                                            child: Padding(
                                                padding: EdgeInsets.all(16.0),
                                                child: Container(
                                                    width: double.maxFinite,
                                                    height: _order
                                                        .errand_bids[
                                                    index]
                                                        .status == 'pending'
                                                        ? 440
                                                        : 125,
                                                    child: Column(children: [
                                                      Row(children: [
                                                        ClipOval(
                                                            child: CustomImage(
                                                              image: _order
                                                                  .errand_bids[index]
                                                                  .delivery_man !=
                                                                  null && _order
                                                                  .errand_bids[index]
                                                                  .delivery_man
                                                                  .identity_image !=
                                                                  null
                                                                  ?
                                                              '${Get
                                                                  .find<
                                                                  SplashController>()
                                                                  .configModel
                                                                  .baseUrls
                                                                  .parcelCategoryImageUrl}/${_order
                                                                  .errand_bids[index]
                                                                  .delivery_man
                                                                  .identity_image}'
                                                                  : Images
                                                                  .about_us
                                                              ,
                                                              height: 35,
                                                              width: 35,
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
                                                                    _order
                                                                        .errand_bids[index]
                                                                        .delivery_man
                                                                        .f_name +
                                                                        ' ' +
                                                                        _order
                                                                            .errand_bids[index]
                                                                            .delivery_man
                                                                            .l_name
                                                                    ,
                                                                    maxLines: 1,
                                                                    overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                    style: robotoRegular
                                                                        .copyWith(
                                                                        fontSize:
                                                                        Dimensions
                                                                            .fontSizeSmall),
                                                                  ),
                                                                  Text(
                                                                    _order
                                                                        .errand_bids[index]
                                                                        .delivery_man
                                                                        .updated_at,
                                                                    maxLines: 1,
                                                                    overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                    style: robotoRegular
                                                                        .copyWith(
                                                                        fontSize:
                                                                        Dimensions
                                                                            .fontSizeSmall,
                                                                        color: Theme
                                                                            .of(
                                                                            context)
                                                                            .disabledColor),
                                                                  ),
                                                                ])),
                                                        (!_parcel &&
                                                            _order.orderType ==
                                                                'take_away' &&
                                                            (_order
                                                                .orderStatus ==
                                                                'pending' ||
                                                                _order
                                                                    .orderStatus ==
                                                                    'accepted' ||
                                                                _order
                                                                    .orderStatus ==
                                                                    'confirmed' ||
                                                                _order
                                                                    .orderStatus ==
                                                                    'processing' ||
                                                                _order
                                                                    .orderStatus ==
                                                                    'handover' ||
                                                                _order
                                                                    .orderStatus ==
                                                                    'picked_up'))
                                                            ? TextButton.icon(
                                                          onPressed:
                                                              () async {
                                                            if (!_parcel) {
                                                              String url =
                                                                  'https://www.google.com/maps/dir/?api=1&destination=${_order
                                                                  .store
                                                                  .latitude}'
                                                                  ',${_order
                                                                  .store
                                                                  .longitude}&mode=d';
                                                              if (await canLaunchUrlString(
                                                                  url)) {
                                                                await launchUrlString(
                                                                    url);
                                                              } else {
                                                                showCustomSnackBar(
                                                                    'unable_to_launch_google_map'
                                                                        .tr);
                                                              }
                                                            }
                                                          },
                                                          icon: Icon(Icons
                                                              .directions),
                                                          label: Text(
                                                              'direction'
                                                                  .tr),
                                                        )
                                                            : SizedBox(),
                                                      ]),

                                                      SizedBox(
                                                          height: Dimensions
                                                              .PADDING_SIZE_SMALL),
                                                      Row(
                                                          children: [
                                                            Text(
                                                                'Counter Amount : ',
                                                                style:
                                                                robotoMedium
                                                                    .copyWith(
                                                                  fontSize: Dimensions
                                                                      .fontSizeLarge,
                                                                  color: Theme
                                                                      .of(
                                                                      context)
                                                                      .disabledColor,
                                                                )),
                                                            Text(
                                                              PriceConverter
                                                                  .convertPrice(
                                                                  amount),
                                                              style: robotoMedium
                                                                  .copyWith(
                                                                  fontSize: Dimensions
                                                                      .fontSizeLarge,
                                                                  color: Theme
                                                                      .of(
                                                                      context)
                                                                      .primaryColor),
                                                            ),
                                                          ]),
                                                      SizedBox(
                                                          height: Dimensions
                                                              .PADDING_SIZE_SMALL),
                                                      Row(
                                                        // mainAxisAlignment:
                                                        // MainAxisAlignment
                                                        //     .spaceBetween,
                                                          children: [
                                                            Text('Status : ',
                                                                style:
                                                                robotoMedium
                                                                    .copyWith(
                                                                  fontSize: Dimensions
                                                                      .fontSizeLarge,
                                                                  color: Theme
                                                                      .of(
                                                                      context)
                                                                      .disabledColor,
                                                                )),
                                                            Text(
                                                              _order
                                                                  .errand_bids[
                                                              index]
                                                                  .status,
                                                              style: robotoMedium
                                                                  .copyWith(
                                                                  fontSize:
                                                                  Dimensions
                                                                      .fontSizeLarge,
                                                                  color: Colors
                                                                      .green),
                                                            ),
                                                          ]),

                                                      SizedBox(
                                                          height: Dimensions
                                                              .PADDING_SIZE_SMALL),
                                                      if(_order
                                                          .errand_bids[
                                                      index]
                                                          .status == 'pending')
                                                        Row(
                                                            children: [
                                                              Text(
                                                                  'Select Payment Type ',
                                                                  style:
                                                                  robotoMedium
                                                                      .copyWith(
                                                                    fontSize: Dimensions
                                                                        .fontSizeLarge,
                                                                    color: Theme
                                                                        .of(
                                                                        context)
                                                                        .disabledColor,
                                                                  )),
                                                              Text('',
                                                                style: robotoMedium
                                                                    .copyWith(
                                                                    fontSize: Dimensions
                                                                        .fontSizeLarge,
                                                                    color: Theme
                                                                        .of(
                                                                        context)
                                                                        .primaryColor),
                                                              ),
                                                            ]),
                                                      if(_order
                                                          .errand_bids[
                                                      index]
                                                          .status == 'pending')
                                                        SizedBox(
                                                            height: Dimensions
                                                                .PADDING_SIZE_SMALL),
                                                      if(_order
                                                          .errand_bids[
                                                      index]
                                                          .status == 'pending')
                                                        Get
                                                            .find<
                                                            SplashController>()
                                                            .configModel
                                                            .cashOnDelivery
                                                            ? PaymentButton(
                                                          icon: Images
                                                              .cash_on_delivery,
                                                          title: 'cash_on_delivery'
                                                              .tr,
                                                          subtitle: 'pay_your_payment_after_getting_item'
                                                              .tr,
                                                          isSelected: Get
                                                              .find<
                                                              OrderController>()
                                                              .paymentIndex ==
                                                              0,
                                                          onTap: () =>
                                                              Get.find<
                                                                  OrderController>()
                                                                  .setPaymentIndex(
                                                                  0, true),
                                                        )
                                                            : SizedBox(),
                                                      if(_order
                                                          .errand_bids[
                                                      index]
                                                          .status == 'pending')
                                                        Get
                                                            .find<
                                                            SplashController>()
                                                            .configModel
                                                            .digitalPayment
                                                            ? PaymentButton(
                                                          icon: Images
                                                              .digital_payment,
                                                          title: 'digital_payment'
                                                              .tr,
                                                          subtitle: 'faster_and_safe_way'
                                                              .tr,
                                                          isSelected: Get
                                                              .find<
                                                              OrderController>()
                                                              .paymentIndex ==
                                                              1,
                                                          onTap: () =>
                                                              Get.find<
                                                                  OrderController>()
                                                                  .setPaymentIndex(
                                                                  1, true),
                                                        )
                                                            : SizedBox(),
                                                      if(_order
                                                          .errand_bids[
                                                      index]
                                                          .status == 'pending')
                                                        Get
                                                            .find<
                                                            SplashController>()
                                                            .configModel
                                                            .customerWalletStatus ==
                                                            1 ? PaymentButton(
                                                          icon: Images.wallet,
                                                          title: 'wallet_payment'
                                                              .tr,
                                                          subtitle: 'pay_from_your_existing_balance'
                                                              .tr,
                                                          isSelected: Get
                                                              .find<
                                                              OrderController>()
                                                              .paymentIndex ==
                                                              2,
                                                          onTap: () =>
                                                              Get.find<
                                                                  OrderController>()
                                                                  .setPaymentIndex(
                                                                  2, true),
                                                        ) : SizedBox(),
                                                      if(_order
                                                          .errand_bids[
                                                      index]
                                                          .status == 'pending')

                                                        CustomButton(
                                                            height: 40,
                                                            buttonText: 'Accept',
                                                            onPressed: () =>
                                                            {

                                                              if(Get
                                                                  .find<
                                                                  OrderController>()
                                                                  .paymentIndex ==
                                                                  0){
                                                                payment_type =
                                                                'cash_on_delivery'
                                                              } else
                                                                if(Get
                                                                    .find<
                                                                    OrderController>()
                                                                    .paymentIndex ==
                                                                    1){
                                                                  payment_type =
                                                                  'digital_payment'
                                                                } else
                                                                  if(Get
                                                                      .find<
                                                                      OrderController>()
                                                                      .paymentIndex ==
                                                                      2){
                                                                    payment_type =
                                                                    'wallet'
                                                                  },
                                                  if(payment_type!=""){
                                                    Get.find<
                                                        OrderController>()
                                                        .acceptErrandCounter(
                                                        _order
                                                            .errand_bids[
                                                        index]
                                                            .order_id,
                                                        _order
                                                            .errand_bids[
                                                        index]
                                                            .id,payment_type,
                                                        orderCallback),
                                                  }else {
                                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                            content: Text("Please Select Payment Methode !"),
                                                            ))
                                                  }
                                                            }),
                                                    ]))),
                                            color: Colors.white,
                                          );
                                        },
                                      ),

                                    SizedBox(
                                        height:
                                        ResponsiveHelper.isDesktop(context)
                                            ? Dimensions
                                            .PADDING_SIZE_EXTRA_LARGE
                                            : 0),
                                    if (_errand &&
                                        _order.errand_tasks != null &&
                                        _order.errand_tasks.length >
                                            0)
                                      Text(
                                          'Errand Tasks', style: robotoRegular),
                                    SizedBox(
                                        height:
                                        ResponsiveHelper.isDesktop(context)
                                            ? Dimensions.PADDING_SIZE_LARGE
                                            : 0),
                                    if (_errand &&
                                        _order.errand_tasks != null &&
                                        _order.errand_tasks.length >
                                            0)
                                      ListView.builder(
                                        padding: const EdgeInsets.only(top: 5),
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, position) {
                                          return Card(
                                            shape: RoundedRectangleBorder(
                                              side: BorderSide(
                                                color: (_order
                                                    .errand_tasks[position]
                                                    .status != 'pending'
                                                    ? Colors.green
                                                    : Colors
                                                    .transparent), //<-- SEE HERE
                                              ),
                                              borderRadius: BorderRadius
                                                  .circular(5.0),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Container(
                                                  child: Column(children: [
                                                    Row(children: [
                                                      Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                              "${'Task'} ${'('}${position +
                                                                  1}${')'}",
                                                              style: robotoMedium
                                                                  .copyWith(
                                                                  fontSize:
                                                                  Dimensions
                                                                      .fontSizeDefault))),
                                                      Expanded(
                                                          child: SizedBox()),
                                                      Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                              _order
                                                                  .errand_tasks[position]
                                                                  .status,
                                                              style: robotoMedium
                                                                  .copyWith(
                                                                  color: _order
                                                                      .errand_tasks[position]
                                                                      .status ==
                                                                      'pending'
                                                                      ? Theme
                                                                      .of(
                                                                      context)
                                                                      .disabledColor
                                                                      : Colors
                                                                      .green,
                                                                  fontSize:
                                                                  Dimensions
                                                                      .fontSizeLarge))),
                                                    ]),
                                                    SizedBox(
                                                        height: Dimensions
                                                            .PADDING_SIZE_LARGE),
                                                   /* Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child:
                                                        DottedBorder(
                                                            color: Colors.black,
                                                            strokeWidth: 1,
                                                            child: (_order
                                                                .errand_tasks[position]
                                                                .errand_task_media
                                                                .length > 0 ?
                                                            CustomImage(
                                                              image:
                                                              '${Get
                                                                  .find<
                                                                  SplashController>()
                                                                  .configModel
                                                                  .baseUrls
                                                                  .errandTaskImageUrl}'
                                                                  '/' + _order
                                                                  .errand_tasks[position]
                                                                  .errand_task_media[0]
                                                                  .image,
                                                              height: 30,
                                                              width: 30,
                                                            ) : Image.asset(
                                                                Images
                                                                    .placeholder,
                                                                height: 50,
                                                                width: 50,
                                                                fit: BoxFit
                                                                    .fill))
                                                        )),*/
                                                /*Container(
                                                    child:
                                                    PhotoView(
                                                      tightMode: true,
                                                      imageProvider: NetworkImage(  '${Get
                                                          .find<
                                                          SplashController>()
                                                          .configModel
                                                          .baseUrls
                                                          .errandTaskImageUrl}'
                                                          '/' + _order
                                                          .errand_tasks[position]
                                                          .errand_task_media[0]
                                                          .image),

                                                    )),*/


                                                    SizedBox(
                                                      height: 70,
                                                      width: double.infinity,
                                                      child: ListView.builder(
                                                        shrinkWrap: true,
                                                        scrollDirection: Axis.horizontal,
                                                        physics: NeverScrollableScrollPhysics(),
                                                        itemBuilder: (context, Position) {
                                                          return Container(
                                                              width: 60,
                                                              child: Stack(children: [
                                                                //Stack

                                                                Align(
                                                                    alignment: Alignment.centerLeft,
                                                                    child:
                                                                    DottedBorder(
                                                                        color: Colors.black,
                                                                        strokeWidth: 1,
                                                                        child: (_order
                                                                            .errand_tasks[position]
                                                                            .errand_task_media
                                                                            .length > 0 ?
                                                                        CustomImage(
                                                                          image:
                                                                          '${Get
                                                                              .find<
                                                                              SplashController>()
                                                                              .configModel
                                                                              .baseUrls
                                                                              .errandTaskImageUrl}'
                                                                              '/' + _order
                                                                              .errand_tasks[position]
                                                                              .errand_task_media[Position]
                                                                              .image,
                                                                          height: 40,
                                                                          width: 40,
                                                                        ) : Image.asset(
                                                                            Images
                                                                                .placeholder,
                                                                            height: 50,
                                                                            width: 50,
                                                                            fit: BoxFit
                                                                                .fill))
                                                                    )),
                                                              ]));
                                                        },
                                                        itemCount: _order
                                                            .errand_tasks[position]
                                                            .errand_task_media
                                                            .length,
                                                      ),
                                                    ),

                                                    SizedBox(
                                                        height: Dimensions
                                                            .PADDING_SIZE_LARGE),
                                                    Align(
                                                      alignment: Alignment
                                                          .centerLeft,
                                                      child: Text(
                                                        'Ttile',
                                                        style: robotoRegular
                                                            .copyWith(
                                                            fontSize: Dimensions
                                                                .fontSizeSmall,
                                                            color:
                                                            Theme
                                                                .of(context)
                                                                .disabledColor),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        height:
                                                        Dimensions
                                                            .PADDING_SIZE_EXTRA_SMALL),
                                                    Align(
                                                      alignment: Alignment
                                                          .centerLeft,
                                                      child: Text(
                                                          _order
                                                              .errand_tasks[position]
                                                              .title
                                                              .toString(),
                                                          textAlign: TextAlign
                                                              .start,
                                                          style: robotoMedium
                                                              .copyWith(
                                                              color: Colors
                                                                  .grey,
                                                              fontSize:
                                                              Dimensions
                                                                  .fontSizeDefault)),
                                                    ),
                                                    SizedBox(
                                                        height: Dimensions
                                                            .PADDING_SIZE_LARGE),
                                                    Align(
                                                      alignment: Alignment
                                                          .centerLeft,
                                                      child: Text(
                                                        'Comment',
                                                        style: robotoRegular
                                                            .copyWith(
                                                            fontSize: Dimensions
                                                                .fontSizeSmall,
                                                            color:
                                                            Theme
                                                                .of(context)
                                                                .disabledColor),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        height:
                                                        Dimensions
                                                            .PADDING_SIZE_EXTRA_SMALL),
                                                    Align(
                                                      alignment: Alignment
                                                          .centerLeft,
                                                      child: Text(
                                                          _order
                                                              .errand_tasks[position]
                                                              .description
                                                              .toString(),
                                                          textAlign: TextAlign
                                                              .start,
                                                          style: robotoMedium
                                                              .copyWith(
                                                              color: Colors
                                                                  .grey,
                                                              fontSize:
                                                              Dimensions
                                                                  .fontSizeDefault)),
                                                    )
                                                  ])),
                                            ),
                                            color: Colors.white,
                                          );
                                        },
                                        itemCount: _order.errand_tasks.length,
                                      ),


                                    SizedBox(
                                        height:
                                        ResponsiveHelper.isDesktop(context)
                                            ? Dimensions.PADDING_SIZE_LARGE
                                            : 0),
                                    SizedBox(
                                        height:
                                        Dimensions
                                            .PADDING_SIZE_DEFAULT),
                                    if (_errand)
                                      Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('total_amount'.tr,
                                                style: robotoMedium.copyWith(
                                                  fontSize:
                                                  Dimensions.fontSizeLarge,
                                                  color: Theme
                                                      .of(context)
                                                      .primaryColor,
                                                )),
                                            Text(
                                              PriceConverter.convertPrice(
                                                  _total),
                                              style: robotoMedium.copyWith(
                                                  fontSize:
                                                  Dimensions.fontSizeLarge,
                                                  color: Theme
                                                      .of(context)
                                                      .primaryColor),
                                            ),
                                          ]),
                                    ResponsiveHelper.isDesktop(context)
                                        ? _bottomView(
                                        orderController, _order, _parcel)
                                        : SizedBox(),
                                  ]))),
                    ))),
            ResponsiveHelper.isDesktop(context)
                ? SizedBox()
                : _bottomView(orderController, _order, _parcel),
          ])
              : Center(child: CircularProgressIndicator());
        }),
      ),
    );
  }

  void openDialog(BuildContext context, String imageUrl) =>
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Dimensions.RADIUS_LARGE)),
            child: Stack(children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(Dimensions.RADIUS_LARGE),
                child: PhotoView(
                  tightMode: true,
                  imageProvider: NetworkImage(imageUrl),
                  heroAttributes: PhotoViewHeroAttributes(tag: imageUrl),
                ),
              ),
              Positioned(
                  top: 0,
                  right: 0,
                  child: IconButton(
                    splashRadius: 5,
                    onPressed: () => Get.back(),
                    icon: Icon(Icons.cancel, color: Colors.red),
                  )),
            ]),
          );
        },
      );

  Widget _bottomView(OrderController orderController, OrderModel order,
      bool parcel) {
    return Column(children: [
      !orderController.showCancelled
          ? Center(
        child: SizedBox(
          width: Dimensions.WEB_MAX_WIDTH,
          child: Row(children: [
            (order.orderStatus == 'pending' ||
                order.orderStatus == 'accepted' ||
                order.orderStatus == 'confirmed' ||
                order.orderStatus == 'processing' ||
                order.orderStatus == 'handover' ||
                order.orderStatus == 'picked_up')
                ? Expanded(
              child: CustomButton(
                buttonText:
                parcel ? 'track_delivery'.tr : 'track_order'.tr,
                margin: ResponsiveHelper.isDesktop(context)
                    ? null
                    : EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                onPressed: () {
                  Get.toNamed(
                      RouteHelper.getOrderTrackingRoute(order.id));
                },
              ),
            )
                : SizedBox(),
            order.orderStatus == 'pending'
                ? Expanded(
                child: Padding(
                  padding: ResponsiveHelper.isDesktop(context)
                      ? EdgeInsets.zero
                      : EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                  child: TextButton(
                    style: TextButton.styleFrom(
                        minimumSize: Size(1, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              Dimensions.RADIUS_SMALL),
                          side: BorderSide(
                              width: 2,
                              color: Theme
                                  .of(context)
                                  .disabledColor),
                        )),
                    onPressed: () {
                      Get.dialog(ConfirmationDialog(
                        icon: Images.warning,
                        description: 'are_you_sure_to_cancel'.tr,
                        onYesPressed: () {
                          orderController.cancelOrder(order.id);
                        },
                      ));
                    },
                    child: Text(
                        parcel
                            ? 'cancel_delivery'.tr
                            : 'cancel_order'.tr,
                        style: robotoBold.copyWith(
                          color: Theme
                              .of(context)
                              .disabledColor,
                          fontSize: Dimensions.fontSizeLarge,
                        )),
                  ),
                ))
                : SizedBox(),
          ]),
        ),
      )
          : Center(
        child: Container(
          width: Dimensions.WEB_MAX_WIDTH,
          height: 50,
          margin: ResponsiveHelper.isDesktop(context)
              ? null
              : EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
                width: 2, color: Theme
                .of(context)
                .primaryColor),
            borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
          ),
          child: Text('order_cancelled'.tr,
              style: robotoMedium.copyWith(
                  color: Theme
                      .of(context)
                      .primaryColor)),
        ),
      ),
      (order.orderStatus == 'delivered' && order.deliveryMan != null
          /*(parcel
              ? order.deliveryMan != null
              : orderController.orderDetails != null &&
              orderController.orderDetails.length > 0 &&
              orderController.orderDetails[0].itemCampaignId == null)*/)
          ? Center(
        child:
          (orderController.orderDetailsModel!=null &&(orderController.orderDetailsModel.order_type=='errand' ||orderController.orderDetailsModel.order_type=='parcel'))|| orderController.orderDetailsModel!=null && orderController.orderDetailsModel.is_dm_reviewed_count==0?
        Container(
          width: Dimensions.WEB_MAX_WIDTH,
          padding: ResponsiveHelper.isDesktop(context)
              ? null
              : EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          child: CustomButton(
            buttonText: 'review'.tr,
            onPressed: () {
              List<OrderDetailsModel> _orderDetailsList = [];
              List<int> _orderDetailsIdList = [];
              orderController.orderDetails.forEach((orderDetail) {
                if (!_orderDetailsIdList
                    .contains(orderDetail.itemDetails.id)) {
                  _orderDetailsList.add(orderDetail);
                  _orderDetailsIdList.add(orderDetail.itemDetails.id);
                }
              });
              Get.toNamed(RouteHelper.getReviewRoute(),
                  arguments: RateReviewScreen(
                    orderDetailsList: _orderDetailsList,
                    deliveryMan: order.deliveryMan,
                    orderID: order.id,
                  ));
            },
          ),
        ):SizedBox(),
      )
          : SizedBox(),
      (order.orderStatus == 'failed' &&
          Get
              .find<SplashController>()
              .configModel
              .cashOnDelivery)
          ? Center(
        child: Container(
          width: Dimensions.WEB_MAX_WIDTH,
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          child: CustomButton(
            buttonText: 'switch_to_cash_on_delivery'.tr,
            onPressed: () {
              Get.dialog(ConfirmationDialog(
                  icon: Images.warning,
                  description: 'are_you_sure_to_switch'.tr,
                  onYesPressed: () {
                    orderController
                        .switchToCOD(order.id.toString())
                        .then((isSuccess) {
                      Get.back();
                      if (isSuccess) {
                        Get.back();
                      }
                    });
                  }));
            },
          ),
        ),
      )
          : SizedBox(),
    ]);
  }

  void orderCallback(bool isSuccess, String message, String orderID) {
    //  Get.find<ParcelController>().startLoader(true);
    if (isSuccess) {
      if (Get
          .find<OrderController>()
          .paymentIndex == 0) {
        // Get.offNamed(RouteHelper.getOrderSuccessRoute(orderID));
      } else {
        if (GetPlatform.isWeb) {
          Get.back();
          String hostname = html.window.location.hostname;
          String protocol = html.window.location.protocol;
          String selectedUrl =
              '${AppConstants
              .BASE_URL}/payment-mobile?order_id=$orderID&&customer_id=${Get
              .find<UserController>()
              .userInfoModel
              .id}&&callback=$protocol//$hostname${RouteHelper
              .orderSuccess}?id=$orderID&type=errand&status=';
          html.window.open(selectedUrl, "_self");
        }
        else {
          if(Get
              .find<
              OrderController>()
              .paymentIndex ==
              1) {
            Get.offNamed(RouteHelper.getPaymentRoute(
                orderID, Get
                .find<UserController>()
                .userInfoModel
                .id, 'errand'));
          }
        }
      }
    } else {
      showCustomSnackBar(message);
    }
  }
}
