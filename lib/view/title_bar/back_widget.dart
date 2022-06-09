/*
 * *
 *  * Created by wangjun on 3/7/22, 3:48 PM
 *  * Copyright (c) 2022 . All rights reserved.
 *  * Last modified 3/7/22, 3:48 PM
 *
 */

import 'package:chat_view_demo/util/screen_ext.dart';
import 'package:flutter/material.dart';

class BackWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 130.dp,
      height: 130.dp,
      child: Align(
          alignment: Alignment.centerLeft,
          child: Icon(Icons.arrow_back_ios, size: 55.dp)),
    );
  }
}
