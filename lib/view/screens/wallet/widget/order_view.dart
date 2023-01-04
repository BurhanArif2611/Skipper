import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:sixam_mart/controller/order_controller.dart';
import 'package:sixam_mart/controller/wallet_controller.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/view/base/footer_view.dart';
import 'package:sixam_mart/view/base/no_data_screen.dart';
import 'package:sixam_mart/view/base/paginated_list_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/view/screens/wallet/widget/history_item.dart';

class OrderView extends StatelessWidget {
  final bool isRunning;
  OrderView({@required this.isRunning});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    return Scaffold(
      body: GetBuilder<WalletController>(builder: (orderController) {
        return orderController != null && orderController.transactionList!=null? orderController.transactionList.length > 0 ?
        RefreshIndicator(
          onRefresh: () async {
            if(isRunning) {
              await orderController.getWalletTransactionList('1',"accepted", false, true);
            }else {
              await orderController.getWalletTransactionList('1',"pending", false, true);
            }
          },
          child: Scrollbar(child: SingleChildScrollView(
            controller: scrollController,
            physics: AlwaysScrollableScrollPhysics(),
            child: FooterView(
              child: SizedBox(
                width: Dimensions.WEB_MAX_WIDTH,
                child: PaginatedListView(
                  scrollController: scrollController,
                  onPaginate: (int offset) {
                    if(isRunning) {
                      Get.find<WalletController>().getWalletTransactionList('1',"accepted", false, true);
                    }else {
                      Get.find<OrderController>().getHistoryOrders(offset);
                    }
                  },

                  itemView: orderController.transactionList != null
                      ? orderController
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
                    itemCount: orderController
                        .transactionList.length,
                    padding: EdgeInsets.only(
                        top: ResponsiveHelper
                            .isDesktop(context)
                            ? 28
                            : 25),
                    itemBuilder: (context, index) {
                      return HistoryItem(
                          index: index,
                          fromWallet:
                          true,
                          data: orderController
                              .transactionList);
                    },
                  )
                      : NoDataScreen(
                      text: 'no_data_found'.tr)
                      : WalletShimmer(
                      walletController: orderController),

                ),
              ),
            ),
          )),
        ) : NoDataScreen(text: 'no_order_found'.tr, showFooter: true) : WalletShimmer(walletController: orderController);
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
