import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CommonState with ChangeNotifier, DiagnosticableTreeMixin {
  String _themeType = "normal";

  get themeType => _themeType;

  // 接口方法
  void updateRightTitles() {
    _themeType = "blue";
    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('themeType', themeType));
  }
}
