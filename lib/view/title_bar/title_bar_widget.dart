/*
 * *
 *  * Created by wangjun on 3/7/22, 3:45 PM
 *  * Copyright (c) 2022 . All rights reserved.
 *  * Last modified 3/7/22, 3:45 PM
 *
 */

import 'package:flutter/material.dart';

import 'back_widget.dart';

class TitleBarWidget extends StatefulWidget {
  Widget? rightWidget;
  Widget? centerWidget;

  TitleBarWidget({this.centerWidget, this.rightWidget});

  @override
  State<StatefulWidget> createState() {
    return _TitleBarWidgetState();
  }
}

class _TitleBarWidgetState extends State<TitleBarWidget> {
  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            flex: 1,
            child: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: BackWidget())),
        Expanded(
            flex: 2,
            child: widget.centerWidget == null
                ? Container()
                : Center(child: widget.centerWidget!)),
        Expanded(
          child: widget.rightWidget == null ? Container() : widget.rightWidget!,
          flex: 1,
        )
      ],
    );
  }
}
