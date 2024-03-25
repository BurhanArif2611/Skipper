import 'dart:async';


import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'package:timeago/timeago.dart' as timeago;

import '../../base/custom_app_bar.dart';
import '../home/widget/team_card.dart';

class MyMatchesScreen extends StatefulWidget {
  static Future<void> loadData(bool reload) async {}

  @override
  State<MyMatchesScreen> createState() => _MyMatchesScreenState();
}

class _MyMatchesScreenState extends State<MyMatchesScreen> {
  final ScrollController _scrollController = ScrollController();
  final PageController _pageController = PageController();
  final ScrollController scrollController = ScrollController();
  int seconds = 5; // Initial countdown time
  Timer _timer;
  double latitude;
  double longitude;



  @override
  void initState() {
    super.initState();

    // _loadData();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    timeago.setLocaleMessages('en', timeago.EnMessages());

    return Scaffold(
        appBar: CustomAppBar(
            title: 'My Matches', onBackPressed: () => {Get.back()}),
        body: Container(color: Theme.of(context).backgroundColor,
        child:
        Scrollbar(
            child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Container(

                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                  margin: EdgeInsets.only(top:Dimensions.PADDING_SIZE_SMALL),
                  child: Column(
                    children: [
                      ListView.builder(
                          shrinkWrap: true,
                          controller: _scrollController,
                          itemCount: 10,
                          physics: ScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index_option) {
                            return TeamCardItem();
                          }),

                    ],
                  ),
                )))));
  }
}

