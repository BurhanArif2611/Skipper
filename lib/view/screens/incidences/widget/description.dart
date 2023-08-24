import 'package:sixam_mart/controller/home_controller.dart';
import 'package:sixam_mart/controller/search_controller.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/view/base/footer_view.dart';
import 'package:sixam_mart/view/base/item_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../util/styles.dart';

class Description extends StatelessWidget {
  final bool isItem;
  Description({@required this.isItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<HomeController>(builder: (homeController) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
            child: SizedBox(width: Dimensions.WEB_MAX_WIDTH, child:
            Text(
              homeController.incidenceDetailResponse.description,
              style: robotoBold.copyWith(
                  color: Theme.of(context).hintColor),
            ),
           /* ItemsView(
              isStore: isItem, items: searchController.searchItemList, stores: searchController.searchStoreList,
            )*/),
          ),
        );
      }),
    );
  }
}
