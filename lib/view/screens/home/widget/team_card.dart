import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../../controller/home_controller.dart';
import '../../../../data/model/body/country_flag.dart';
import '../../../../data/model/response/matchList/matches.dart';
import '../../../../helper/route_helper.dart';
import '../../../../util/dimensions.dart';
import '../../../../util/images.dart';
import '../../../../util/styles.dart';
import 'package:intl/intl.dart';

import '../../../base/country_flag_image.dart';

class TeamCardItem extends StatelessWidget {
  Matches matches;
  bool shadow;
  bool redirection;


  TeamCardItem(this.matches, this.shadow, this.redirection);

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: () {
      if(redirection)
      Get.toNamed(RouteHelper.getCreateLeagueRoute(matches));
    }, child:
        Container(
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          margin: EdgeInsets.only(top: Dimensions.PADDING_SIZE_LARGE),
          decoration: BoxDecoration(
            color: Theme.of(context).hintColor,
            borderRadius: BorderRadius.circular(Dimensions.RADIUS_LARGE),
            boxShadow: (shadow &&
                    (matches.startAt != null
                        ? isDateWithinNext72Hours(matches.startAt)
                        : false)
                ? [
                    BoxShadow(
                        color: Colors.yellowAccent[Get.isDarkMode ? 600 : 100],
                        spreadRadius: 0.5,
                        blurRadius: 10)
                  ]
                : null),
          ),
          child:
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "${matches.tournament.name}",
                            style: robotoRegular.copyWith(
                                color: Theme.of(context).cardColor,
                                fontSize: Dimensions.fontSizeExtraSmall),
                          ))),
                  Expanded(
                      flex: 1,
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "${matches.play_status == "scheduled" ? "Scheduled" : matches.play_status == "started" || matches.play_status == "in_play" ? "Live" : matches.play_status}",
                            style: robotoMedium.copyWith(
                                color: Theme.of(context).errorColor,
                                fontSize: Dimensions.fontSizeSmall),
                          ))),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                        child: Row(
                      children: [
                        Flexible(
                            child: Column(
                          children: [
                            CountryFlagImage(matches.teams.a.code),


                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              matches.teams.a.name,
                              style: robotoMedium.copyWith(
                                color: Theme.of(context).cardColor,
                                fontSize: Dimensions.fontSizeSmall,
                              ),
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow
                                  .ellipsis, // Ensure text doesn't overflow
                            ),
                          ],
                        )),
                        SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          // Make this text flexible to prevent overflow
                          child: Text(
                            matches.teams.a.code,
                            style: robotoBold.copyWith(
                              color: Theme.of(context).cardColor,
                              fontSize: Dimensions.fontSizeSmall,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow
                                .ellipsis, // Ensure text truncates if too long
                          ),
                        ),
                      ],
                    )),
                  ),
                  Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          /*Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .disabledColor
                                    .withOpacity(0.20),
                              ),
                              padding: EdgeInsets.all(5),
                              child: Text(
                                "0h:8m",
                                style: robotoMedium.copyWith(
                                    color: Theme.of(context).errorColor,
                                    fontSize: Dimensions.fontSizeSmall),
                              ),
                            ),*/
                          Text(
                            matches.startAt != null &&
                                    matches.startAt != "" &&
                                    isDateWithinNext72Hours(matches.startAt)
                                ? '${changeDateFormate(matches.startAt)}'
                                : '${matches.startAt}',
                            style: robotoMedium.copyWith(
                                color: Theme.of(context).disabledColor,
                                fontSize: Dimensions.fontSizeSmall),
                            textAlign: TextAlign.center,
                          )
                        ],
                      )),
                  Expanded(
                    flex: 2,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Flexible(
                          child: Text(
                            matches.teams.b.code,
                            style: robotoBold.copyWith(
                              color: Theme.of(context).cardColor,
                              fontSize: Dimensions.fontSizeSmall,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow
                                .ellipsis, // This will ensure the text doesn't overflow
                          ),
                        ),
                        SizedBox(width: 10),
                        Flexible(
                            child: Column(
                          children: [
                            CountryFlagImage(matches.teams.b.code),

                            SizedBox(height: 5),
                            Text(
                              matches.teams.b.name,
                              style: robotoMedium.copyWith(
                                color: Theme.of(context).cardColor,
                                fontSize: Dimensions.fontSizeSmall,
                              ),
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow
                                  .ellipsis, // Ensures the text doesn't overflow
                            ),
                          ],
                        )),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              (matches.squad != null &&
                  matches.squad.a != null &&
                  matches.squad.a.playingXi != null &&
                  matches.squad.a.playingXi.length > 0)?
              Divider(
                thickness: 0.5,
                color: Theme.of(context).disabledColor.withOpacity(0.50),
              ):SizedBox.shrink(),

              (matches.squad != null &&
                  matches.squad.a != null &&
                  matches.squad.a.playingXi != null &&
                  matches.squad.a.playingXi.length > 0)?
              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child:SizedBox.shrink()/* Row(
                        children: [
                          Text(
                            "2 Team",
                            style: robotoRegular.copyWith(
                                color: Theme.of(context).cardColor,
                                fontSize: Dimensions.fontSizeExtraSmall),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "3 Contests",
                            style: robotoRegular.copyWith(
                                color: Theme.of(context).cardColor,
                                fontSize: Dimensions.fontSizeExtraSmall),
                          )
                        ],
                      )*/
                  ),
                  Expanded(
                      flex: 1,
                      child: (matches.squad != null &&
                              matches.squad.a != null &&
                              matches.squad.a.playingXi != null &&
                              matches.squad.a.playingXi.length > 0)
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "Lineup Announced",
                                  style: robotoMedium.copyWith(
                                      color: Colors.green,
                                      fontSize: Dimensions.fontSizeSmall),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Image.asset(
                                  Images.lineup,
                                )
                              ],
                            )
                          : SizedBox.shrink()),
                ],
              ):SizedBox.shrink(),
            ],
          ))
   );
  }

  bool isDateWithinNext72Hours(String dateString) {
    // Parse the input date string
    if (dateString != null) {
      final DateFormat format = DateFormat("dd MMM yyyy \n hh:mm a");
      final DateTime inputDate = format.parse(dateString);
      // Get current time
      final DateTime now = DateTime.now();

      // Calculate time after 72 hours
      final DateTime timeAfter72Hours = now.add(Duration(hours: 72));

      // Check if the input date is within the range
      return inputDate.isAfter(now) && inputDate.isBefore(timeAfter72Hours);
    } else {
      return true;
    }
  }

  String changeDateFormate(String date) {
    try {
      // Attempt to parse the input date
      DateTime targetDateTime;

      // Check if the date is in ISO-8601 format, otherwise customize parsing
      if (RegExp(r'^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}').hasMatch(date)) {
        targetDateTime = DateTime.parse(date);
      } else {
        // Adjust parsing if the format is different (e.g., "dd/MM/yyyy HH:mm")
        targetDateTime = DateFormat("dd MMM yyyy \n hh:mm a").parse(date);
      }

      // Format it to a readable string or calculate remaining time
      DateTime now = DateTime.now();

      if (targetDateTime.isAfter(now)) {
        Duration difference = targetDateTime.difference(now);
        int hours = difference.inHours;
        int minutes = difference.inMinutes % 60;

        return "$hours h : $minutes m";
      } else {
        return "The target date is in the past.";
      }
    } catch (e) {
      print("Error parsing date: $e");
      return "Invalid date format.";
    }
  }

/* void ConvertTime(int time) {
    // Convert Unix timestamp to milliseconds
    try {
      int timestamp = time * 1000;

      // Create a DateTime object from the timestamp
      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);

      // Format the DateTime object to display in IST
      String formattedDateTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(
          dateTime.toUtc().add(Duration(hours: 5, minutes: 30)));

      print(formattedDateTime); // Output: 2021-01-26 05:30:00
    }catch(e){}
  }*/
}
