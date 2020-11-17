import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:molan_edu/utils/custom_router.dart';

/// 导航
class NavigatorUtils {
  ///替换
  static pushReplacementName(BuildContext context, String routeName) {
    FocusScope.of(context).unfocus();
    Navigator.pushReplacementNamed(context, routeName);
  }

  static pushReplacement(BuildContext context, Widget widget, {bool fullscreenDialog = false}) {
    FocusScope.of(context).unfocus();
    Navigator.pushReplacement(
      context,
      CupertinoPageRoute(builder: (context) => widget, fullscreenDialog: fullscreenDialog),
    );
  }

  static pushNamed(BuildContext context, String routeName, {Object arguments}) {
    FocusScope.of(context).unfocus();
    return Navigator.pushNamed(context, routeName, arguments: arguments);
  }

  static push(BuildContext context, Widget widget, {bool full = false, int routeType = 2}) {
    FocusScope.of(context).unfocus();
    return Navigator.push(
      context,
      routeType == 1
          ? MaterialPageRoute(builder: (context) => widget)
          : routeType == 2
              ? CupertinoPageRoute(builder: (context) => widget, fullscreenDialog: full)
              : CustomRouter(widget),
    );
  }

  static pop(BuildContext context) {
    FocusScope.of(context).unfocus();
    Navigator.pop(context);
  }

  /// 带参数返回
  static popParam(BuildContext context, result) {
    FocusScope.of(context).unfocus();
    Navigator.pop(context, result);
  }

  static popAndPush(BuildContext context, Widget widget, {bool full = false}) {
    FocusScope.of(context).unfocus();
    Navigator.pop(context);
    push(context, widget, full: full);
  }

  static popAndPushNamed(BuildContext context, String routeName) {
    FocusScope.of(context).unfocus();
    Navigator.popAndPushNamed(context, routeName);
  }

  ///移除某个页面以及之后的页面
  static removeRouteBelow(BuildContext context, anchorRoute) {
    FocusScope.of(context).unfocus();
    Navigator.of(context).removeRouteBelow(anchorRoute);
  }

  static goBack(BuildContext context, {int num = 1, params}) {
    for (var i = 0; i < num; i++) {
      if (params != null) {
        popParam(context, params);
      } else {
        pop(context);
      }
    }
  }

  ///移除所有跳转之前的页面
  static pushNamedAndRemoveUntil(BuildContext context, String routeName) {
    FocusScope.of(context).unfocus();
    Navigator.of(context).pushNamedAndRemoveUntil(routeName, (Route route) => false);
  }

  ///移除所有跳转之前的页面
  static pushAndRemoveUntil(BuildContext context, Widget widget) {
    FocusScope.of(context).unfocus();
    Navigator.of(context).pushAndRemoveUntil(
      CupertinoPageRoute(builder: (context) => widget, fullscreenDialog: true),
      (Route route) => false,
    );
  }

  static popUntil(BuildContext context, String routeName) {
    FocusScope.of(context).unfocus();
    return Navigator.popUntil(context, ModalRoute.withName(routeName));
  }
}
