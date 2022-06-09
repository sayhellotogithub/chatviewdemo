

import 'package:flutter/material.dart';

import 'back_widget.dart';

class TitleBarBackWidget extends StatefulWidget {
  String? title;

  TitleBarBackWidget({this.title});

  @override
  State<StatefulWidget> createState() {
    return _TitleBarBackWidgetState();
  }
}

class _TitleBarBackWidgetState extends State<TitleBarBackWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: BackWidget()),
      ],
    );
  }
}
