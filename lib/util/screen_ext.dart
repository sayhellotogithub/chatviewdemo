import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';

extension ScreenExt on num {
  double get dp => ScreenUtil.getInstance().getAdapterSize(this.toDouble());

  double get sp => ScreenUtil.getInstance().getSp(this.toDouble());

  Widget get vGap => SizedBox(
      height: ScreenUtil.getInstance().getAdapterSize(this.toDouble()));

  Widget get hGap =>
      SizedBox(width: ScreenUtil.getInstance().getAdapterSize(this.toDouble()));
}
