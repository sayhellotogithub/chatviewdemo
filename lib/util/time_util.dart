/*
 * *
 *  * Created by wangjun on 3/8/22, 3:14 PM
 *  * Copyright (c) 2022 . All rights reserved.
 *  * Last modified 3/8/22, 3:14 PM
 *
 */


import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeUtil {
  TimeUtil._();

  static int getDayTotalSeconds() {
    return 24 * 60 * 60;
  }

  static int getDayRemainingSeconds() {
    final now = DateTime.now();
    return getDayTotalSeconds() -
        now.hour * 60 * 60 -
        now.minute * 60 -
        now.second;
  }

  static String secondsToHHMMSS(double time) {
    return "${time ~/ (60 * 60)}:${(time ~/ (60)) % 60}:${time.toInt() % (60)}";
  }

  ///
  /// 11、、若是当天发送的内容则显示当天具体时间若是当天发送的内容则显示当天具体时间	（（时时，，分分))
  /// 22、、若是昨天发送的内容则显示昨天若是昨天发送的内容则显示昨天	（（不显示具体的时间不显示具体的时间	））
  /// 33、、若是前天发送的内容则显示前天若是前天发送的内容则显示前天	（（不显示具体的时间不显示具体的时间	））
  /// 44、、其他时间都显示为年月日其他时间都显示为年月日	（（不显示具体时间不显示具体时间	））
  ///
  static String conversationTime(BuildContext context, int? time) {

    if (time == null) {
      return "";
    }
    final date = DateTime.fromMillisecondsSinceEpoch(time);
    final now = DateTime.now();
    final dateCheck = DateTime(date.year, date.month, date.day);

    if (dateCheck == DateTime(now.year, now.month, now.day)) {
      //today
      return hhmmFormat(date);
    } else if (dateCheck == DateTime(now.year, now.month, now.day - 1)) {
      //yesterday
      return "yesterday";
    } else if (dateCheck == DateTime(now.year, now.month, now.day - 2)) {
      //before yesterday
      return "before yesterday";
    } else {
      return apiDayFormat(date);
    }
  }

  ///  如果是今天 5、每隔5分钟	，展示一次时间
  static String chatTimeShow(
      BuildContext context, int? currentTime, int? lastTime) {
    if (currentTime == null) {
      return "";
    }
    if (lastTime == null) {
      return conversationTime(context, currentTime);
    }

    //如果是则每隔5分钟显示时间
    final date = DateTime.fromMillisecondsSinceEpoch(currentTime);

    Duration duration =
        date.difference(DateTime.fromMillisecondsSinceEpoch(lastTime));
    if (duration.inMinutes >= 5) {
      return conversationTime(context, currentTime);
    }
    return "";
  }

  static final DateFormat _dayFormat = DateFormat('dd');
  static final DateFormat _firstDayFormat = DateFormat('MMM dd');
  static final DateFormat _fullDayFormat = DateFormat('EEE MMM dd, yyyy');
  static final DateFormat _apiDayFormat = DateFormat('yyyy-MM-dd');
  static final DateFormat _monthFormat = DateFormat('MMMM yyyy');
  static final DateFormat _HH_mm_Format = DateFormat('HH:mm');
  static final DateFormat yyyyMMddHHmm =DateFormat('yyyy-MM-dd HH:mm');
  static final DateFormat yyyyMMddHHmmss =DateFormat('yyyy-MM-dd HH:mm:ss');
  static final DateFormat yyyyDotMMDotHH= DateFormat('yyyy.MM.dd');

  static String formatMonth(DateTime d) => _monthFormat.format(d);

  static String formatDay(DateTime d) => _dayFormat.format(d);

  static String formatFirstDay(DateTime d) => _firstDayFormat.format(d);

  static String fullDayFormat(DateTime d) => _fullDayFormat.format(d);

  static String apiDayFormat(DateTime d) => _apiDayFormat.format(d);

  static String hhmmFormat(DateTime d) => _HH_mm_Format.format(d);


  static const List<String> weekdays = [
    'Sun',
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat'
  ];

  /// The list of days in a given month
  static List<DateTime> daysInMonth(DateTime month) {
    var first = firstDayOfMonth(month);
    var daysBefore = first.weekday;
    var firstToDisplay = first.subtract(Duration(days: daysBefore));
    var last = lastDayOfMonth(month);

    var daysAfter = 7 - last.weekday;

    // If the last day is sunday (7) the entire week must be rendered
    if (daysAfter == 0) {
      daysAfter = 7;
    }

    var lastToDisplay = last.add(Duration(days: daysAfter));
    return daysInRange(firstToDisplay, lastToDisplay).toList();
  }

  static bool isFirstDayOfMonth(DateTime day) {
    return isSameDay(firstDayOfMonth(day), day);
  }

  static bool isLastDayOfMonth(DateTime day) {
    return isSameDay(lastDayOfMonth(day), day);
  }

  static DateTime firstDayOfMonth(DateTime month) {
    return DateTime(month.year, month.month);
  }

  static DateTime firstDayOfWeek(DateTime day) {
    /// Handle Daylight Savings by setting hour to 12:00 Noon
    /// rather than the default of Midnight
    day = DateTime.utc(day.year, day.month, day.day, 12);

    /// Weekday is on a 1-7 scale Monday - Sunday,
    /// This Calendar works from Sunday - Monday
    var decreaseNum = day.weekday % 7;
    return day.subtract(Duration(days: decreaseNum));
  }

  static DateTime lastDayOfWeek(DateTime day) {
    /// Handle Daylight Savings by setting hour to 12:00 Noon
    /// rather than the default of Midnight
    day = DateTime.utc(day.year, day.month, day.day, 12);

    /// Weekday is on a 1-7 scale Monday - Sunday,
    /// This Calendar's Week starts on Sunday
    var increaseNum = day.weekday % 7;
    return day.add(Duration(days: 7 - increaseNum));
  }

  /// The last day of a given month
  static DateTime lastDayOfMonth(DateTime month) {
    var beginningNextMonth = (month.month < 12)
        ? DateTime(month.year, month.month + 1, 1)
        : DateTime(month.year + 1, 1, 1);
    return beginningNextMonth.subtract(Duration(days: 1));
  }

  /// Returns a [DateTime] for each day the given range.
  ///
  /// [start] inclusive
  /// [end] exclusive
  static Iterable<DateTime> daysInRange(DateTime start, DateTime end) sync* {
    var i = start;
    var offset = start.timeZoneOffset;
    while (i.isBefore(end)) {
      yield i;
      i = i.add(Duration(days: 1));
      var timeZoneDiff = i.timeZoneOffset - offset;
      if (timeZoneDiff.inSeconds != 0) {
        offset = i.timeZoneOffset;
        i = i.subtract(Duration(seconds: timeZoneDiff.inSeconds));
      }
    }
  }

  /// Whether or not two times are on the same day.
  static bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  static bool isSameWeek(DateTime a, DateTime b) {
    /// Handle Daylight Savings by setting hour to 12:00 Noon
    /// rather than the default of Midnight
    a = DateTime.utc(a.year, a.month, a.day);
    b = DateTime.utc(b.year, b.month, b.day);

    var diff = a.toUtc().difference(b.toUtc()).inDays;
    if (diff.abs() >= 7) {
      return false;
    }

    var min = a.isBefore(b) ? a : b;
    var max = a.isBefore(b) ? b : a;
    var result = max.weekday % 7 - min.weekday % 7 >= 0;
    return result;
  }

  static DateTime previousMonth(DateTime m) {
    var year = m.year;
    var month = m.month;
    if (month == 1) {
      year--;
      month = 12;
    } else {
      month--;
    }
    return DateTime(year, month);
  }

  static DateTime nextMonth(DateTime m) {
    var year = m.year;
    var month = m.month;

    if (month == 12) {
      year++;
      month = 1;
    } else {
      month++;
    }
    return DateTime(year, month);
  }

  static DateTime previousWeek(DateTime w) {
    return w.subtract(Duration(days: 7));
  }

  static DateTime nextWeek(DateTime w) {
    return w.add(Duration(days: 7));
  }
}
