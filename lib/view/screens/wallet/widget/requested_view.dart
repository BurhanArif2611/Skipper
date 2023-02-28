import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:sixam_mart/controller/order_controller.dart';
import 'package:sixam_mart/controller/wallet_controller.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/view/base/footer_view.dart';
import 'package:sixam_mart/view/base/no_data_screen.dart';
import 'package:sixam_mart/view/base/paginated_list_view.dart';
import 'package:sixam_mart/view/screens/wallet/widget/history_item.dart';

import '../../../../helper/date_converter.dart';
import '../../../../helper/price_converter.dart';
import '../../../../util/images.dart';
import '../../../../util/styles.dart';
import '../../../base/confirmation_dialog.dart';
import '../../../base/custom_button.dart';

class RequestedView extends StatelessWidget {
  final bool isRunning;

  RequestedView({@required this.isRunning});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    return Scaffold(
      body: GetBuilder<WalletController>(builder: (orderController) {
        return orderController != null &&
                orderController.requestTransactionList != null
            ? orderController.requestTransactionList.length > 0
                ? RefreshIndicator(
                    onRefresh: () async {
                      await orderController.getWalletRequestTransactionList(
                          '1', "accepted", false, true);
                    },
                    child: Scrollbar(
                        child: SingleChildScrollView(
                      controller: scrollController,
                      physics: AlwaysScrollableScrollPhysics(),
                      child: FooterView(
                        child: SizedBox(
                          width: Dimensions.WEB_MAX_WIDTH,
                          child: PaginatedListView(
                            scrollController: scrollController,
                            onPaginate: (int offset) {
                              Get.find<WalletController>()
                                  .getWalletRequestTransactionList(
                                      '1', "pending", false, true);
                            },
                            itemView:
                                orderController.requestTransactionList != null
                                    ? orderController
                                                .requestTransactionList.length >
                                            0
                                        ? ListView.builder(
                                            key: UniqueKey(),
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: orderController
                                                .requestTransactionList.length,
                                            padding: EdgeInsets.only(
                                                top: ResponsiveHelper.isDesktop(
                                                        context)
                                                    ? 28
                                                    : 25),
                                            itemBuilder: (context, index) {
                                              return Container(
                                                  margin: EdgeInsets.all(Dimensions
                                                      .PADDING_SIZE_EXTRA_SMALL),
                                                  padding: EdgeInsets.only(
                                                      left: Dimensions
                                                          .PADDING_SIZE_EXTRA_SMALL,
                                                      right: Dimensions
                                                          .PADDING_SIZE_EXTRA_SMALL,
                                                      top: Dimensions
                                                          .PADDING_SIZE_SMALL),
                                                  decoration: BoxDecoration(
                                                    color: Theme.of(context)
                                                        .cardColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            Dimensions
                                                                .RADIUS_SMALL),
                                                  ),
                                                  child: Column(children: [
                                                    Container(
                                                        child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(
                                                            child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    'Requested Amount',
                                                                    style: robotoMedium.copyWith(
                                                                        color: Theme.of(context)
                                                                            .hintColor,
                                                                        fontSize:
                                                                            Dimensions.fontSizeDefault),
                                                                    maxLines: 1,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                  ),
                                                                  SizedBox(
                                                                      width: Dimensions
                                                                          .PADDING_SIZE_EXTRA_SMALL),
                                                                  Text(
                                                                    PriceConverter.convertPrice(orderController
                                                                        .requestTransactionList[
                                                                            index]
                                                                        .amount),
                                                                    style: robotoRegular.copyWith(
                                                                        fontSize:
                                                                            Dimensions
                                                                                .fontSizeSmall,
                                                                        color: Theme.of(context)
                                                                            .hintColor),
                                                                  )
                                                                ]),
                                                            SizedBox(
                                                                height: Dimensions
                                                                    .PADDING_SIZE_EXTRA_SMALL),
                                                            Text(
                                                                orderController
                                                                            .requestTransactionList[
                                                                                index]
                                                                            .status !=
                                                                        null
                                                                    ? orderController
                                                                        .requestTransactionList[
                                                                            index]
                                                                        .status
                                                                    : "",
                                                                style: robotoRegular.copyWith(
                                                                    fontSize:
                                                                        Dimensions
                                                                            .fontSizeSmall,
                                                                    color: Theme.of(
                                                                            context)
                                                                        .errorColor),
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis),
                                                          ],
                                                        )),
                                                        Container(
                                                            child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Text(
                                                                orderController.requestTransactionList[index].createdAt !=
                                                                        null
                                                                    ? DateConverter.dateTimeStringToDateTime(orderController
                                                                        .requestTransactionList[
                                                                            index]
                                                                        .createdAt
                                                                        .toString())
                                                                    : '',
                                                                style: robotoRegular.copyWith(
                                                                    fontSize:
                                                                        Dimensions
                                                                            .fontSizeSmall,
                                                                    color: Theme.of(
                                                                            context)
                                                                        .hintColor),
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis),
                                                            SizedBox(
                                                                height: Dimensions
                                                                    .PADDING_SIZE_EXTRA_SMALL),
                                                            Text(
                                                                orderController
                                                                    .requestTransactionList[
                                                                index]
                                                                    .status!=null&& orderController
                                                                    .requestTransactionList[
                                                                index]
                                                                    .status=='pending'? 'Pending for approval':'',
                                                                style: robotoRegular.copyWith(
                                                                    fontSize:
                                                                        Dimensions
                                                                            .fontSizeSmall,
                                                                    color: Colors
                                                                        .yellow),
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis),
                                                          ],
                                                        )),
                                                      ],
                                                    )),
                                                    if (orderController
                                                            .requestTransactionList[
                                                                index]
                                                            .status ==
                                                        'pending')
                                                      Column(children: [
                                                        Align(
                                                            alignment: Alignment
                                                                .topRight,
                                                            child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  CustomButton(
                                                                    height: Dimensions
                                                                        .PADDING_SIZE_EXTRA_LARGE,
                                                                    width: 120,
                                                                    fontSize:
                                                                        Dimensions
                                                                            .fontSizeDefault,
                                                                    buttonText:
                                                                        'Cancel Request',
                                                                    onPressed: () =>
                                                                        Get.dialog(
                                                                            ConfirmationDialog(
                                                                              icon: Images.warning,
                                                                              title: 'Alert'.tr,
                                                                              description: 'Are you sure? you want to cancel withdraw request.'.tr,
                                                                              onYesPressed: () {
                                                                                Get.back();
                                                                                Get.find<WalletController>().CancelRequestToWallet(orderController.requestTransactionList[index].id.toString(), index);
                                                                              },
                                                                            ),
                                                                            barrierDismissible: false),
                                                                  )
                                                                ]))
                                                      ]),
                                                    SizedBox(
                                                        height: Dimensions
                                                            .PADDING_SIZE_EXTRA_SMALL),

                                                    /*Padding(
                                    padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                    child: Divider(color: Theme.of(context).disabledColor),
                                  ),*/
                                                  ]
                                                  ));
                                            },
                                          )
                                        : NoDataScreen(text: 'no_data_found'.tr)
                                    : WalletShimmer(
                                        walletController: orderController),
                          ),
                        ),
                      ),
                    )),
                  )
                : NoDataScreen(text: 'no_order_found'.tr, showFooter: true)
            : WalletShimmer(walletController: orderController);
      }),
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
      padding:
          EdgeInsets.only(top: ResponsiveHelper.isDesktop(context) ? 25 : 25),
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
