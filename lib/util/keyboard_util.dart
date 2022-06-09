/*
 * *
 *  * Created by wangjun on 3/31/22, 2:51 PM
 *  * Copyright (c) 2022 . All rights reserved.
 *  * Last modified 3/31/22, 2:51 PM
 *
 */
import 'package:flutter/material.dart';

class KeyboardUtil {
  KeyboardUtil._();

  /// 隐藏键盘
  ///
  /// [context] 上下文
  ///
  static void hideKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
