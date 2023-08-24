import 'package:sixam_mart/controller/splash_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DateConverter {

  static String formatDate(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd hh:mm:ss a').format(dateTime);
  }

  static String dateToTimeOnly(DateTime dateTime) {
    return DateFormat(_timeFormatter()).format(dateTime);
  }

  static String dateToDateAndTime(DateTime dateTime) {
    return DateFormat('dd MMM yyyy HH:mm').format(dateTime);
  }

  static String dateToDateAndTimeAm(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd ${_timeFormatter()}').format(dateTime);
  }

  static String dateTimeStringToDateTime(String dateTime) {
    print("dateTimeStringToDateTime ${dateTime}");
    return DateFormat('dd MMM yyyy  ${_timeFormatter()}').format(DateFormat('yyyy-MM-dd HH:mm:ss').parseUtc(dateTime).toLocal());
  }

  static String dateTimeStringToDateOnly(String dateTime) {
    return DateFormat('dd MMM yyyy').format(DateFormat('yyyy-MM-dd HH:mm:ss').parseUtc(dateTime).toLocal());
  }

  static String getTime(String dateTime1) {
  //  return DateFormat('dd MMM yyyy').format(DateFormat('yyyy-MM-dd HH:mm:ss').parseUtc(dateTime).toLocal());
    DateTime dateTime = DateTime.parse(dateTime1);

// Format the extracted time portion
   // String formattedTime = "${dateTime.hour}:${dateTime.minute}:${dateTime.second}";
    String formattedTime = DateFormat('h:mm a').format(dateTime);
    print(formattedTime);
    return formattedTime;
  }

  static String getDate(String dateTime1) {

    DateTime dateTime = DateTime.parse(dateTime1);
    String formattedTime = DateFormat('dd MMM yyyy').format(dateTime);
    print(formattedTime);
    return formattedTime;
  }

  static DateTime dateTimeStringToDate(String dateTime) {
    return DateFormat('yyyy-MM-dd HH:mm:ss').parseUtc(dateTime).toLocal();
  }

  static DateTime isoStringToLocalDate(String dateTime) {
    return DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').parseUtc(dateTime).toLocal();
  }

  static String isoStringToDateTimeString(String dateTime) {
    return DateFormat('dd MMM yyyy  ${_timeFormatter()}').format(isoStringToLocalDate(dateTime));
  }

  static String isoStringToLocalDateOnly(String dateTime) {
    return DateFormat('dd MMM yyyy').format(isoStringToLocalDate(dateTime));
  }

  static String stringToLocalDateOnly(String dateTime) {
    return DateFormat('dd MMM yyyy').format(DateFormat('yyyy-MM-dd').parseUtc(dateTime).toLocal());
  }

  static String localDateToIsoString(DateTime dateTime) {
    return DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').format(dateTime);
  }

  static String convertTimeToTime(String time) {
    return DateFormat(_timeFormatter()).format(DateFormat('HH:mm').parseUtc(time).toLocal());
  }

  static DateTime convertStringTimeToDate(String time) {
    return DateFormat('HH:mm').parse(time);
  }

  static bool isAvailable(String start, String end, {DateTime time}) {
    DateTime _currentTime;
    if(time != null) {
      _currentTime = time;
    }else {
      _currentTime = Get.find<SplashController>().currentTime;
    }
    DateTime _start = start != null ? DateFormat('HH:mm').parse(start) : DateTime(_currentTime.year);
    DateTime _end = end != null ? DateFormat('HH:mm').parse(end) : DateTime(_currentTime.year, _currentTime.month, _currentTime.day, 23, 59, 59);
    DateTime _startTime = DateTime(_currentTime.year, _currentTime.month, _currentTime.day, _start.hour, _start.minute, _start.second);
    DateTime _endTime = DateTime(_currentTime.year, _currentTime.month, _currentTime.day, _end.hour, _end.minute, _end.second);
    if(_endTime.isBefore(_startTime)) {
      if(_currentTime.isBefore(_startTime) && _currentTime.isBefore(_endTime)){
        _startTime = _startTime.add(Duration(days: -1));
      }else {
        _endTime = _endTime.add(Duration(days: 1));
      }
    }
    return _currentTime.isAfter(_startTime) && _currentTime.isBefore(_endTime);
  }

  static String _timeFormatter() {
    return Get.find<SplashController>().configModel.timeformat == '24' ? 'HH:mm' : 'hh:mm a';
  }

  static String convertFromMinute(int minMinute, int maxMinute) {
    int _firstValue = minMinute;
    int _secondValue = maxMinute;
    String _type = 'min';
    if(minMinute >= 525600) {
      _firstValue = (minMinute / 525600).floor();
      _secondValue = (maxMinute / 525600).floor();
      _type = 'year';
    }else if(minMinute >= 43200) {
      _firstValue = (minMinute / 43200).floor();
      _secondValue = (maxMinute / 43200).floor();
      _type = 'month';
    }else if(minMinute >= 10080) {
      _firstValue = (minMinute / 10080).floor();
      _secondValue = (maxMinute / 10080).floor();
      _type = 'week';
    }else if(minMinute >= 1440) {
      _firstValue = (minMinute / 1440).floor();
      _secondValue = (maxMinute / 1440).floor();
      _type = 'day';
    }else if(minMinute >= 60) {
      _firstValue = (minMinute / 60).floor();
      _secondValue = (maxMinute / 60).floor();
      _type = 'hour';
    }
    return '$_firstValue-$_secondValue ${_type.tr}';
  }
  String timeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays >= 365) {
      return DateFormat.yMMMMd().format(dateTime); // If more than a year, display the full date
    } else if (difference.inDays >= 2) {
      return DateFormat.MMMEd().format(dateTime); // If more than a day, display month and day
    } else if (difference.inDays >= 1) {
      return 'Yesterday';
    } else if (difference.inHours >= 2) {
      return '${difference.inHours} hours ago';
    } else if (difference.inHours >= 1) {
      return 'An hour ago';
    } else if (difference.inMinutes >= 2) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inMinutes >= 1) {
      return 'A minute ago';
    } else {
      return 'Just now';
    }
  }

}
