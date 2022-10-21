import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:sixam_mart/controller/category_controller.dart';
import 'package:sixam_mart/controller/location_controller.dart';
import 'package:sixam_mart/controller/notification_controller.dart';
import 'package:sixam_mart/controller/splash_controller.dart';
import 'package:sixam_mart/controller/store_controller.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/util/app_constants.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/view/base/item_view.dart';
import 'package:sixam_mart/view/base/paginated_list_view.dart';
import 'package:sixam_mart/view/screens/dashboard/dashboard_screen.dart';
import 'package:sixam_mart/view/screens/home/home_screen.dart';
import 'package:sixam_mart/view/screens/home/theme1/banner_view1.dart';
import 'package:sixam_mart/view/screens/home/theme1/best_reviewed_item_view.dart';
import 'package:sixam_mart/view/screens/home/theme1/category_view1.dart';
import 'package:sixam_mart/view/screens/home/theme1/item_campaign_view1.dart';
import 'package:sixam_mart/view/screens/home/theme1/popular_item_view1.dart';
import 'package:sixam_mart/view/screens/home/theme1/popular_store_view1.dart';
import 'package:sixam_mart/view/screens/home/widget/filter_view.dart';
import 'package:sixam_mart/view/screens/home/widget/module_view.dart';

//"_______________"
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/view/base/cart_widget.dart';
import 'package:sixam_mart/view/base/custom_image.dart';
import 'package:sixam_mart/view/base/footer_view.dart';
import 'package:sixam_mart/view/base/item_view.dart';
import 'package:sixam_mart/view/base/menu_drawer.dart';
import 'package:sixam_mart/view/base/paginated_list_view.dart';
import 'package:sixam_mart/view/base/web_menu_bar.dart';
import 'package:sixam_mart/view/screens/store/widget/store_description_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/banner_controller.dart';
import '../../../../controller/localization_controller.dart';
import '../../../../controller/parcel_controller.dart';
import '../../../../data/model/response/category_model.dart';
import '../../../../data/model/response/item_model.dart';
import '../../../../data/model/response/module_model.dart';
import '../../../../data/model/response/store_model.dart';
import '../../../../helper/date_converter.dart';
import '../../../../helper/price_converter.dart';

class NewHomeScreen extends StatelessWidget {
  final ScrollController scrollController;
  final SplashController splashController;
  final bool showMobileModule;

  const NewHomeScreen(
      {@required this.scrollController,
      @required this.splashController,
      @required this.showMobileModule});

  @override
  Widget build(BuildContext context) {
    if (Get.find<StoreController>().store == null &&
        Get.find<StoreController>().storeItemModel == null) {
      Get.find<StoreController>()
          .getStoreDetails(Store(id: AppConstants.StoreID), true);

      Get.find<StoreController>()
          .getStoreItemList(AppConstants.StoreID, 1, 'all', false);
    } else {
      // Get.find<StoreController>().startLoader(false);
      try {
        if (Get.find<SplashController>().module == null) {
          for (int i = 0;
              i < Get.find<SplashController>().moduleList.length;
              i++) {
            if (Get.find<SplashController>().moduleList[i].id ==
                Get.find<StoreController>().store.moduleId) {
              // Get.find<SplashController>().setModule(module);
              Get.find<SplashController>().setModuleWithCallStoreAPI(
                  Get.find<SplashController>().moduleList[i],
                  Get.find<StoreController>().store.id);

              break;
            }
          }
        }
      } catch (e) {}
    }
    try {
      if (Get.find<ParcelController>().parcelCategoryList != null) {
        if (Get.find<ParcelController>().parcelCategoryList.length == 0) {
          Get.find<ParcelController>().getParcelCategoryList();
        }
      } else {
        Get.find<ParcelController>().getParcelCategoryList();
      }
    } catch (e) {}
    Color _textColor =
        ResponsiveHelper.isDesktop(context) ? Colors.white : null;
    final bool _ltr = Get.find<LocalizationController>().isLtr;
    return Scaffold(
      appBar: ResponsiveHelper.isDesktop(context) ? WebMenuBar() : null,
      endDrawer: MenuDrawer(),
      backgroundColor: Theme.of(context).cardColor,
      body: GetBuilder<StoreController>(builder: (storeController) {
        return GetBuilder<CategoryController>(builder: (categoryController) {
          Store _store;
          if (storeController.store != null &&
              storeController.store.name != null &&
              categoryController.categoryList != null) {
            _store = storeController.store;
          }
          storeController.setCategoryList();

          return (storeController.store != null &&
                  storeController.store.name != null &&
                  categoryController.categoryList != null)
              ?NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (OverscrollIndicatorNotification overscroll) {
                overscroll.disallowGlow();
                return;
              },
              child:
          CustomScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  controller: scrollController,
                  slivers: [
                    ResponsiveHelper.isDesktop(context)
                        ? SliverToBoxAdapter(
                            child: Container(
                              color: Color(0xFF171A29),
                              padding:
                                  EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
                              alignment: Alignment.center,
                              child: Center(
                                  child: SizedBox(
                                      width: Dimensions.WEB_MAX_WIDTH,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                Dimensions.PADDING_SIZE_SMALL),
                                        child: Row(children: [
                                          Expanded(
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Dimensions.RADIUS_SMALL),
                                              child: CustomImage(
                                                fit: BoxFit.cover,
                                                height: 220,
                                                image:
                                                    '${Get.find<SplashController>().configModel.baseUrls.storeCoverPhotoUrl}/${_store.coverPhoto}',
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                              width: Dimensions
                                                  .PADDING_SIZE_LARGE),
                                          Expanded(
                                              child: StoreDescriptionView(
                                                  store: _store)),
                                        ]),
                                      ))),
                            ),
                          )
                        : SliverAppBar(
                            floating: true,
                            elevation: 0,
                            automaticallyImplyLeading: false,
                            backgroundColor: ResponsiveHelper.isDesktop(context)
                                ? Colors.transparent
                                : Theme.of(context).backgroundColor,
                            title: Center(
                                child: Container(
                              width: Dimensions.WEB_MAX_WIDTH,
                              height: 50,
                              color: Theme.of(context).backgroundColor,
                              child: Row(children: [
                                (storeController.store != null &&
                                        storeController.store.ecommerce == 1
                                    ? (splashController.module != null &&
                                            splashController
                                                    .configModel.module ==
                                                null)
                                        ? InkWell(
                                            onTap: () => {
                                              Get.toNamed(RouteHelper
                                                  .getFavoriteScreen())
                                              // splashController.removeModule()
                                            },
                                            child: Icon(Icons.favorite,
                                                color: Colors.black,
                                                size:
                                                    25), /*Image.asset(Images.module_icon,
                                            height: 22, width: 22),*/
                                          )
                                        : SizedBox()
                                    : SizedBox()),
                                SizedBox(
                                    width: (splashController.module != null &&
                                            splashController
                                                    .configModel.module ==
                                                null)
                                        ? Dimensions.PADDING_SIZE_EXTRA_SMALL
                                        : 0),
                                Expanded(
                                    child: InkWell(
                                  onTap: () => Get.toNamed(
                                      RouteHelper.getAccessLocationRoute(
                                          'home')),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: Dimensions.PADDING_SIZE_SMALL,
                                      horizontal:
                                          ResponsiveHelper.isDesktop(context)
                                              ? Dimensions.PADDING_SIZE_SMALL
                                              : 0,
                                    ),
                                    child: GetBuilder<LocationController>(
                                        builder: (locationController) {
                                      return Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            locationController
                                                        .getUserAddress()
                                                        .addressType ==
                                                    'home'
                                                ? Icons.home_filled
                                                : locationController
                                                            .getUserAddress()
                                                            .addressType ==
                                                        'office'
                                                    ? Icons.work
                                                    : Icons.location_on,
                                            size: 20,
                                            color: Theme.of(context)
                                                .textTheme
                                                .bodyText1
                                                .color,
                                          ),
                                          SizedBox(width: 10),
                                          Flexible(
                                            child: Text(
                                              locationController
                                                  .getUserAddress()
                                                  .address,
                                              style: robotoRegular.copyWith(
                                                color: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1
                                                    .color,
                                                fontSize:
                                                    Dimensions.fontSizeSmall,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Icon(Icons.arrow_drop_down,
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1
                                                  .color),
                                        ],
                                      );
                                    }),
                                  ),
                                )),
                                if (storeController.store != null &&
                                    storeController.store.ecommerce == 1)
                                  InkWell(
                                    child: GetBuilder<NotificationController>(
                                        builder: (notificationController) {
                                      return Stack(children: [
                                        Icon(Icons.notifications,
                                            size: 25,
                                            color: Theme.of(context)
                                                .textTheme
                                                .bodyText1
                                                .color),
                                        notificationController.hasNotification
                                            ? Positioned(
                                                top: 0,
                                                right: 0,
                                                child: Container(
                                                  height: 10,
                                                  width: 10,
                                                  decoration: BoxDecoration(
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                        width: 1,
                                                        color: Theme.of(context)
                                                            .cardColor),
                                                  ),
                                                ))
                                            : SizedBox(),
                                      ]);
                                    }),
                                    onTap: () => Get.toNamed(
                                        RouteHelper.getNotificationRoute()),
                                  ),
                              ]),
                            )),
                            actions: [SizedBox()],
                          ),
                    if (storeController.store != null &&
                        storeController.store.parcel != 1)
                      SliverPersistentHeader(
                        pinned: true,
                        delegate: SliverDelegate(
                            child: Center(
                                child: Container(
                          height: 50,
                          width: Dimensions.WEB_MAX_WIDTH,
                          color: Theme.of(context).backgroundColor,
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.PADDING_SIZE_SMALL),
                          child: InkWell(
                            onTap: () =>
                                Get.toNamed(RouteHelper.getSearchRoute()),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Dimensions.PADDING_SIZE_SMALL),
                              decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                borderRadius: BorderRadius.circular(25),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors
                                          .grey[Get.isDarkMode ? 800 : 200],
                                      spreadRadius: 1,
                                      blurRadius: 5)
                                ],
                              ),
                              child: Row(children: [
                                SizedBox(
                                    width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                Icon(
                                  Icons.search,
                                  size: 25,
                                  color: Theme.of(context).hintColor,
                                ),
                                SizedBox(
                                    width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                Expanded(
                                    child: Text(
                                  Get.find<SplashController>()
                                          .configModel
                                          .moduleConfig
                                          .module
                                          .showRestaurantText
                                      ? 'search_food_or_restaurant'.tr
                                      : 'search_item_or_store'.tr,
                                  style: robotoRegular.copyWith(
                                    fontSize: Dimensions.fontSizeSmall,
                                    color: Theme.of(context).hintColor,
                                  ),
                                )),
                              ]),
                            ),
                          ),
                        ))),
                      ),
                    SliverPadding(
                      padding: EdgeInsets.only(top: 10.0),
                      sliver: SliverAppBar(
                          expandedHeight: 230,
                          toolbarHeight: 50,
                          pinned: true,
                          floating: true,
                          title: Text(
                            AppConstants.APP_NAME,
                            textAlign: TextAlign.center,
                              style: robotoMedium.copyWith(
                                  fontSize: Dimensions
                                      .fontSizeLarge,
                                  color: Theme.of(context)
                                      .primaryColor)
                          ),
                          backgroundColor:Colors.white/* Theme.of(context).primaryColor*/,
                         /* leading: IconButton(
                            icon: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Theme.of(context).primaryColor),
                              alignment: Alignment.center,
                              child: Icon(Icons.chevron_left,
                                  color: Theme.of(context).cardColor),
                            ),
                            onPressed: () => Get.back(),
                          ),*/
                          flexibleSpace: FlexibleSpaceBar(
                            background: CustomImage(
                              fit: BoxFit.cover,
                              image:
                                  '${Get.find<SplashController>().configModel.baseUrls.storeCoverPhotoUrl}/${_store.coverPhoto}',
                            ),
                          ),
                          actions: [SizedBox()]
                          /*  [IconButton(
                  onPressed: () => Get.toNamed(RouteHelper.getCartRoute()),
                  icon: Container(
                    height: 50, width: 50,
                    decoration: BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).primaryColor),
                    alignment: Alignment.center,
                    child: CartWidget(color: Theme.of(context).cardColor, size: 15, fromStore: true),
                  ),
                )],*/
                          ),
                    ),
                    SliverToBoxAdapter(
                        child: Center(
                            child: Container(
                      width: Dimensions.WEB_MAX_WIDTH,
                      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                      color: Theme.of(context).cardColor,
                      child: storeController.store != null &&
                              (storeController.store.ecommerce == 1)
                          ? Column(children: [
                              ResponsiveHelper.isDesktop(context)
                                  ? SizedBox()
                                  : StoreDescriptionView(store: _store),
                              (storeController.store != null &&
                                      storeController.store.ecommerce == 1
                                  ? _store.discount != null
                                      ? Container(
                                          width: context.width,
                                          margin: EdgeInsets.symmetric(
                                              vertical: Dimensions
                                                  .PADDING_SIZE_SMALL),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Dimensions.RADIUS_SMALL),
                                              color: Theme.of(context)
                                                  .primaryColor),
                                          padding: EdgeInsets.all(
                                              Dimensions.PADDING_SIZE_SMALL),
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  _store.discount
                                                              .discountType ==
                                                          'percent'
                                                      ? '${_store.discount.discount}% OFF'
                                                      : '${PriceConverter.convertPrice(_store.discount.discount)} OFF',
                                                  style: robotoMedium.copyWith(
                                                      fontSize: Dimensions
                                                          .fontSizeLarge,
                                                      color: Theme.of(context)
                                                          .cardColor),
                                                ),
                                                Text(
                                                  _store.discount
                                                              .discountType ==
                                                          'percent'
                                                      ? '${'enjoy'.tr} ${_store.discount.discount}% ${'off_on_all_categories'.tr}'
                                                      : '${'enjoy'.tr} ${PriceConverter.convertPrice(_store.discount.discount)}'
                                                          ' ${'off_on_all_categories'.tr}',
                                                  style: robotoMedium.copyWith(
                                                      fontSize: Dimensions
                                                          .fontSizeSmall,
                                                      color: Theme.of(context)
                                                          .cardColor),
                                                ),
                                                SizedBox(
                                                    height: (_store.discount
                                                                    .minPurchase !=
                                                                0 ||
                                                            _store.discount
                                                                    .maxDiscount !=
                                                                0)
                                                        ? 5
                                                        : 0),
                                                _store.discount.minPurchase != 0
                                                    ? Text(
                                                        '[ ${'minimum_purchase'.tr}: ${PriceConverter.convertPrice(_store.discount.minPurchase)} ]',
                                                        style: robotoRegular.copyWith(
                                                            fontSize: Dimensions
                                                                .fontSizeExtraSmall,
                                                            color: Theme.of(
                                                                    context)
                                                                .cardColor),
                                                      )
                                                    : SizedBox(),
                                                _store.discount.maxDiscount != 0
                                                    ? Text(
                                                        '[ ${'maximum_discount'.tr}: ${PriceConverter.convertPrice(_store.discount.maxDiscount)} ]',
                                                        style: robotoRegular.copyWith(
                                                            fontSize: Dimensions
                                                                .fontSizeExtraSmall,
                                                            color: Theme.of(
                                                                    context)
                                                                .cardColor),
                                                      )
                                                    : SizedBox(),
                                                Text(
                                                  '[ ${'daily_time'.tr}: ${DateConverter.convertTimeToTime(_store.discount.startTime)} '
                                                  '- ${DateConverter.convertTimeToTime(_store.discount.endTime)} ]',
                                                  style: robotoRegular.copyWith(
                                                      fontSize: Dimensions
                                                          .fontSizeExtraSmall,
                                                      color: Theme.of(context)
                                                          .cardColor),
                                                ),
                                              ]),
                                        )
                                      : SizedBox()
                                  : SizedBox()),
                            ])
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                  Text('what_are_you_sending'.tr,
                                      style: robotoBold.copyWith(
                                          fontSize: Dimensions.fontSizeLarge)),
                                  SizedBox(
                                      height:
                                          Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                  Get.find<ParcelController>()
                                              .parcelCategoryList !=
                                          null
                                      ? Get.find<ParcelController>()
                                                      .parcelCategoryList
                                                      .length >
                                                  0 &&
                                              (storeController.store.parcel ==
                                                      1 ||
                                                  storeController
                                                          .store.errand ==
                                                      1)
                                          ? storeController.store.parcel == 1
                                              ? GridView.builder(
                                                  controller:
                                                      ScrollController(),
                                                  gridDelegate:
                                                      SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount:
                                                        ResponsiveHelper
                                                                .isDesktop(
                                                                    context)
                                                            ? 3
                                                            : ResponsiveHelper
                                                                    .isTab(
                                                                        context)
                                                                ? 2
                                                                : 1,
                                                    childAspectRatio:
                                                        ResponsiveHelper
                                                                .isDesktop(
                                                                    context)
                                                            ? (1 / 0.25)
                                                            : (1 / 0.205),
                                                    crossAxisSpacing: Dimensions
                                                        .PADDING_SIZE_SMALL,
                                                    mainAxisSpacing: Dimensions
                                                        .PADDING_SIZE_SMALL,
                                                  ),
                                                  itemCount: Get.find<
                                                          ParcelController>()
                                                      .parcelCategoryList
                                                      .length,
                                                  shrinkWrap: true,
                                                  physics:
                                                      NeverScrollableScrollPhysics(),
                                                  itemBuilder:
                                                      (context, index) {
                                                    return InkWell(
                                                      onTap: () => Get.toNamed(RouteHelper
                                                          .getParcelLocationRoute(
                                                              Get.find<ParcelController>()
                                                                      .parcelCategoryList[
                                                                  index])),
                                                      child: Container(
                                                        padding: EdgeInsets.all(
                                                            Dimensions
                                                                .PADDING_SIZE_SMALL),
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Theme.of(context)
                                                                  .cardColor,
                                                          borderRadius: BorderRadius
                                                              .circular(Dimensions
                                                                  .RADIUS_SMALL),
                                                        ),
                                                        child: Row(children: [
                                                          Container(
                                                            height: 55,
                                                            width: 55,
                                                            alignment: Alignment
                                                                .center,
                                                            decoration: BoxDecoration(
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryColor
                                                                    .withOpacity(
                                                                        0.2),
                                                                shape: BoxShape
                                                                    .circle),
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                      Dimensions
                                                                          .RADIUS_SMALL),
                                                              child:
                                                                  CustomImage(
                                                                image:
                                                                    '${Get.find<SplashController>().configModel.baseUrls.parcelCategoryImageUrl}'
                                                                    '/${Get.find<ParcelController>().parcelCategoryList[index].image}',
                                                                height: 30,
                                                                width: 30,
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                              width: Dimensions
                                                                  .PADDING_SIZE_SMALL),
                                                          Expanded(
                                                              child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                Text(
                                                                    Get.find<
                                                                            ParcelController>()
                                                                        .parcelCategoryList[
                                                                            index]
                                                                        .name,
                                                                    style:
                                                                        robotoMedium),
                                                                SizedBox(
                                                                    height: Dimensions
                                                                        .PADDING_SIZE_EXTRA_SMALL),
                                                                Text(
                                                                  Get.find<
                                                                          ParcelController>()
                                                                      .parcelCategoryList[
                                                                          index]
                                                                      .description,
                                                                  maxLines: 2,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: robotoRegular.copyWith(
                                                                      color: Theme.of(
                                                                              context)
                                                                          .disabledColor,
                                                                      fontSize:
                                                                          Dimensions
                                                                              .fontSizeSmall),
                                                                ),
                                                              ])),
                                                          SizedBox(
                                                              width: Dimensions
                                                                  .PADDING_SIZE_SMALL),
                                                          Icon(Icons
                                                              .keyboard_arrow_right),
                                                        ]),
                                                      ),
                                                    );
                                                  },
                                                )
                                              : Text("")
                                          : Center(
                                              child: Text(
                                                  'no_parcel_category_found'
                                                      .tr))
                                      : ParcelShimmer(
                                          isEnabled:
                                              Get.find<ParcelController>()
                                                      .parcelCategoryList ==
                                                  null),
                                  if (storeController.store.errand == 1)
                                    InkWell(
                                      child: Container(
                                        padding: EdgeInsets.all(
                                            Dimensions.PADDING_SIZE_SMALL),
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).cardColor,
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.RADIUS_SMALL),
                                        ),
                                        child: Row(children: [
                                          Container(
                                            height: 55,
                                            width: 55,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .primaryColor
                                                    .withOpacity(0.2),
                                                shape: BoxShape.circle),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Dimensions.RADIUS_SMALL),
                                              child: /*CustomImage(
                                                image:
                                                    '${Get.find<SplashController>().configModel.baseUrls.parcelCategoryImageUrl}'
                                                    '/2022-07-29-62e3b7d74b8a9.png',
                                                height: 30,
                                                width: 30,
                                              )*/
                                                  Image.asset(
                                                Images.errand,
                                                height: 40,
                                                width: 40,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                              width: Dimensions
                                                  .PADDING_SIZE_SMALL),
                                          if (storeController.store.errand == 1)
                                            Expanded(
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                  Text("Create Errand",
                                                      style: robotoMedium),
                                                  SizedBox(
                                                      height: Dimensions
                                                          .PADDING_SIZE_EXTRA_SMALL),
                                                ])),
                                          SizedBox(
                                              width: Dimensions
                                                  .PADDING_SIZE_SMALL),
                                          Icon(Icons.keyboard_arrow_right),
                                        ]),
                                      ),
                                      onTap: () {
                                        print("tapped on container");
                                        Get.toNamed(RouteHelper
                                            .getErrandLocationRoute());
                                      },
                                    ),
                                ]),
                    ))),
                    (storeController.store != null &&
                            storeController.store.ecommerce == 1
                        ? (storeController.categoryList.length > 0)
                            ? SliverPersistentHeader(
                                pinned: true,
                                delegate: SliverDelegate(
                                    child: Center(
                                        child: Container(
                                  height: 50,
                                  width: Dimensions.WEB_MAX_WIDTH,
                                  color: Theme.of(context).cardColor,
                                  padding: EdgeInsets.symmetric(
                                      vertical:
                                          Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount:
                                        storeController.categoryList.length,
                                    padding: EdgeInsets.only(
                                        left: Dimensions.PADDING_SIZE_SMALL),
                                    physics: BouncingScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () => storeController
                                            .setCategoryIndex(index),
                                        child: Container(
                                          padding: EdgeInsets.only(
                                            left: index == 0
                                                ? Dimensions.PADDING_SIZE_LARGE
                                                : Dimensions.PADDING_SIZE_SMALL,
                                            right: index ==
                                                    storeController.categoryList
                                                            .length -
                                                        1
                                                ? Dimensions.PADDING_SIZE_LARGE
                                                : Dimensions.PADDING_SIZE_SMALL,
                                            top: Dimensions.PADDING_SIZE_SMALL,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.horizontal(
                                              left: Radius.circular(
                                                _ltr
                                                    ? index == 0
                                                        ? Dimensions
                                                            .RADIUS_EXTRA_LARGE
                                                        : 0
                                                    : index ==
                                                            storeController
                                                                    .categoryList
                                                                    .length -
                                                                1
                                                        ? Dimensions
                                                            .RADIUS_EXTRA_LARGE
                                                        : 0,
                                              ),
                                              right: Radius.circular(
                                                _ltr
                                                    ? index ==
                                                            storeController
                                                                    .categoryList
                                                                    .length -
                                                                1
                                                        ? Dimensions
                                                            .RADIUS_EXTRA_LARGE
                                                        : 0
                                                    : index == 0
                                                        ? Dimensions
                                                            .RADIUS_EXTRA_LARGE
                                                        : 0,
                                              ),
                                            ),
                                            color: Theme.of(context)
                                                .primaryColor
                                                .withOpacity(0.1),
                                          ),
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  storeController
                                                      .categoryList[index].name,
                                                  style: index ==
                                                          storeController
                                                              .categoryIndex
                                                      ? robotoMedium.copyWith(
                                                          fontSize: Dimensions
                                                              .fontSizeSmall,
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor)
                                                      : robotoRegular.copyWith(
                                                          fontSize: Dimensions
                                                              .fontSizeSmall,
                                                          color: Theme.of(
                                                                  context)
                                                              .disabledColor),
                                                ),
                                                index ==
                                                        storeController
                                                            .categoryIndex
                                                    ? Container(
                                                        height: 5,
                                                        width: 5,
                                                        decoration: BoxDecoration(
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor,
                                                            shape: BoxShape
                                                                .circle),
                                                      )
                                                    : SizedBox(
                                                        height: 5, width: 5),
                                              ]),
                                        ),
                                      );
                                    },
                                  ),
                                ))),
                              )
                            : SliverToBoxAdapter(child: SizedBox())
                        : SliverToBoxAdapter(child: SizedBox())),
                    (storeController.store != null &&
                            storeController.store.ecommerce == 1
                        ? SliverToBoxAdapter(
                            child: FooterView(
                                child: Container(
                            width: Dimensions.WEB_MAX_WIDTH,
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                            ),
                            child: PaginatedListView(
                              scrollController: scrollController,
                              // onPaginate: (int offset) => storeController.getStoreItemList(widget.store.id, offset, storeController.type, false),
                              onPaginate: (int offset) =>
                                  storeController.getStoreItemList(
                                      (AppConstants.StoreID),
                                      offset,
                                      storeController.type,
                                      false),
                              totalSize: storeController.storeItemModel != null
                                  ? storeController.storeItemModel.totalSize
                                  : null,
                              offset: storeController.storeItemModel != null
                                  ? storeController.storeItemModel.offset
                                  : null,
                              itemView: ItemsView(
                                isStore: false,
                                stores: null,
                                items: (storeController.categoryList.length >
                                            0 &&
                                        storeController.storeItemModel != null)
                                    ? storeController.storeItemModel.items
                                    : null,
                                inStorePage: true,
                                type: storeController.type,
                                onVegFilterTap: (String type) {
                                  storeController.getStoreItemList(
                                      storeController.store.id, 1, type, true);
                                },
                                padding: EdgeInsets.symmetric(
                                  horizontal: Dimensions.PADDING_SIZE_SMALL,
                                  vertical: ResponsiveHelper.isDesktop(context)
                                      ? Dimensions.PADDING_SIZE_SMALL
                                      : 0,
                                ),
                              ),
                            ),
                          )))
                        : SliverToBoxAdapter(child: SizedBox())),
                  ],
                ))
              : Center(child: CircularProgressIndicator());
        });
      }),
    );
  }
}

class SliverDelegate extends SliverPersistentHeaderDelegate {
  Widget child;

  SliverDelegate({@required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 50;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(SliverDelegate oldDelegate) {
    return oldDelegate.maxExtent != 50 ||
        oldDelegate.minExtent != 50 ||
        child != oldDelegate.child;
  }
}

class CategoryProduct {
  CategoryModel category;
  List<Item> products;

  CategoryProduct(this.category, this.products);
}

class ParcelShimmer extends StatelessWidget {
  final bool isEnabled;

  ParcelShimmer({@required this.isEnabled});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: ResponsiveHelper.isDesktop(context)
            ? 3
            : ResponsiveHelper.isTab(context)
                ? 2
                : 1,
        childAspectRatio:
            (1 / (ResponsiveHelper.isMobile(context) ? 0.20 : 0.20)),
        crossAxisSpacing: Dimensions.PADDING_SIZE_SMALL,
        mainAxisSpacing: Dimensions.PADDING_SIZE_SMALL,
      ),
      itemCount: 10,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
          ),
          child: Shimmer(
            duration: Duration(seconds: 2),
            enabled: isEnabled,
            child: Row(children: [
              Container(
                height: 50,
                width: 50,
                alignment: Alignment.center,
                padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                decoration: BoxDecoration(
                    color: Colors.grey[300], shape: BoxShape.circle),
              ),
              SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    Container(height: 15, width: 200, color: Colors.grey[300]),
                    SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    Container(height: 15, width: 100, color: Colors.grey[300]),
                  ])),
              SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
              Icon(Icons.keyboard_arrow_right),
            ]),
          ),
        );
      },
    );
  }
}
