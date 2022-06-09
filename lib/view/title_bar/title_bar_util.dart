/*
 * *
 *  * Created by wangjun on 3/16/22, 4:28 PM
 *  * Copyright (c) 2022 . All rights reserved.
 *  * Last modified 3/16/22, 4:28 PM
 *
 */

import 'package:chat_view_demo/util/screen_ext.dart';
import 'package:flutter/material.dart';

import 'title_bar_widget.dart';

class TitleBarUtil {
  TitleBarUtil._();

  static Widget titleWidget(String? title) {
    return Text(
      title ?? "",
      style: TextStyle(
          fontSize: 60.dp, color: Colors.black, fontWeight: FontWeight.bold),
    );
  }

  static Widget commonTitleBarNoMore({String? title}) {
    return TitleBarWidget(
      centerWidget: titleWidget(title),
    );
  }

  static Widget commonTitleOnlyBack() {
    return TitleBarWidget();
  }

  static Widget commonTitleBar({String? title, Widget? rightWidget}) {
    return TitleBarWidget(
        centerWidget: titleWidget(title), rightWidget: rightWidget);
  }
}
