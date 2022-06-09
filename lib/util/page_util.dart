import 'package:chat_view_demo/util/screen_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:ui' as ui show window;

import 'color_util.dart';

///
///解决statusbar color https://stackoverflow.com/questions/52489458/how-to-change-status-bar-color-in-flutter
///
///

class PageUtil {
  PageUtil._();

  static final toolbarHeight = 220.dp;

  static buildPageNoTitle(Widget body,
      {Color backgroundColor = colorFFF4F4F4}) {
    setStatusBarColorTransparentAndDark();

    return Scaffold(
      backgroundColor: backgroundColor,
      body: body,
    );
  }

  static buildPage(Widget body,
      {Color? statusBarColor,
      Widget? titleWidget,
      Widget? bottomBar,
      Brightness brightness = Brightness.dark,
      Color? backgroundColor}) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: backgroundColor,
      appBar: AppBar(
        toolbarHeight: toolbarHeight,
        backgroundColor: statusBarColor ?? Colors.transparent,
        // status bar color
        automaticallyImplyLeading: false,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: statusBarColor ?? Colors.transparent,
            statusBarBrightness: brightness,
            statusBarIconBrightness: brightness),
        shadowColor: Colors.transparent,
        title: titleWidget,
      ),
      body: body,
      bottomNavigationBar: bottomBar,
    );
  }

  static Widget buildPageNoAppBar(Widget body, {Widget? bottomBar}) {
    setStatusBarColorTransparentAndDark();

    return Scaffold(
      body: body,
      bottomNavigationBar: bottomBar,
    );
  }

  static void setStatusBarColorTransparentAndDark() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
        statusBarColor: Colors.transparent));
  }

  /// 标题栏高度（包括状态栏）
  ///
  static double get navigationBarHeight {
    MediaQueryData mediaQuery = MediaQueryData.fromWindow(ui.window);
    return mediaQuery.padding.top + kToolbarHeight;
  }

  /// 状态栏高度
  ///
  static double get topSafeHeight {
    MediaQueryData mediaQuery = MediaQueryData.fromWindow(ui.window);
    return mediaQuery.padding.top;
  }

  /// 底部状态栏高度
  ///
  static double get bottomSafeHeight {
    MediaQueryData mediaQuery = MediaQueryData.fromWindow(ui.window);
    return mediaQuery.padding.bottom;
  }
}
