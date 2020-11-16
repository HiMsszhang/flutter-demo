import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class Styles {
  static const colorBg = Color(0xFFFFFFFF);
  static const colorTheme = Color(0xFFF8BE90);
  static const colorInfo = Color(0xFF9A9A9A);
  static const colorBorder = Color(0xFFECECEC);
  static const colorText = Color(0xFF333333);
  static const color666666 = Color(0xFF666666);
  static const color999999 = Color(0xFF999999);
  static const colorRed = Color(0xFFFF0000);
  static const colorBlue = Color(0xFF7CC3FF);
  static const colorNoData = Color(0xFFFFC9A7);
  static const colorBtn = Color(0xFFFFA06B);

  /// 一般字体
  static normalFont({
    double fontSize,
    Color color = colorText,
    FontWeight fontWeight,
    double height,
    TextDecoration decoration,
  }) {
    return TextStyle(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
      height: height ?? 1.1,
      decoration: decoration,
    );
  }

  /// 特殊字体
  static specialFont({
    double fontSize,
    Color color,
    FontWeight fontWeight,
    double height,
    TextDecoration decoration,
  }) {
    return TextStyle(
      // fontFamily: 'HappyFont',
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
      height: height ?? 1.1,
      decoration: decoration,
    );
  }

  /// 常用阴影
  static final normalDecoration = BoxDecoration(
    boxShadow: [
      BoxShadow(
        color: Color.fromRGBO(163, 163, 163, 0.2),
        blurRadius: 30.w,
      )
    ],
    color: Colors.white,
  );
}
