import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:molan_edu/utils/local_storage.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:molan_edu/pages/main.dart';
import 'package:molan_edu/providers/common_state.dart';
import 'package:molan_edu/providers/user_state.dart';
import 'package:molan_edu/generated/l10n.dart';
import 'package:molan_edu/styles.dart';
import 'package:molan_edu/utils/routes.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tencent_im_plugin/tencent_im_plugin.dart';
import 'package:tencent_im_plugin/enums/log_print_level.dart';
import 'package:molan_edu/config/config.dart';
import 'package:fluwx/fluwx.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:molan_edu/apis/common.dart';
import 'package:flutter_xupdate/flutter_xupdate.dart';
import 'package:molan_edu/apis/result.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CommonState()),
        ChangeNotifierProvider(create: (_) => UserState()),
      ],
      child: MyApp(),
    ),
  );
}

/// 默认clamping滚动
class ScrollBehaviorModified extends ScrollBehavior {
  const ScrollBehaviorModified();
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    switch (getPlatform(context)) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
      case TargetPlatform.android:
        return const BouncingScrollPhysics();
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return const ClampingScrollPhysics();
    }
    return null;
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // 初始化IM SDK(每次仅调用一次)
    TencentImPlugin.initSDK(appid: Config.TENCENT_IM_APPID, logPrintLevel: LogPrintLevel.error);
    _initFluwx();
    Future.delayed(Duration.zero, () async {
      var isFirst = await LocalStorage.getJSON(Config.S_FIRST) ?? null;
      if (isFirst == null) {
        return;
      }
      await _getVersion();
    });
  }

  /// init微信sdk
  _initFluwx() async {
    await registerWxApi(appId: Config.WECHAT_APPID, doOnAndroid: true, doOnIOS: true, universalLink: Config.WECHAT_LINK);
    var result = await isWeChatInstalled;
    print("is installed $result");
  }

  ///初始化更新检测
  void initXUpdate() {
    if (Platform.isAndroid) {
      FlutterXUpdate.init(
        ///是否输出日志
        debug: true,

        ///是否使用post请求
        isPost: false,

        ///post请求是否是上传json
        isPostJson: true,

        ///是否开启自动模式
        isWifiOnly: false,

        ///是否开启自动模式
        isAutoMode: false,

        ///需要设置的公共参数
        supportSilentInstall: false,

        ///在下载过程中，如果点击了取消的话，是否弹出切换下载方式的重试提示弹窗
        enableRetry: false,
      ).then((value) {
        print("初始化成功: $value");
      }).catchError((error) {
        print("初始化失败: $error");
      });

      FlutterXUpdate.setUpdateHandler(onUpdateError: (Map<String, dynamic> message) async {
        print("下载失败: $message");
        //下载失败
        if (message["code"] == 4000) {
          FlutterXUpdate.showRetryUpdateTipDialog(retryContent: "该网址无法继续下载，是否考虑切换蒲公英下载？", retryUrl: "https://www.pgyer.com/uTpp");
        }
      });
    } else {
      print("ios暂不支持XUpdate更新");
    }
  }

  ///将自定义的json内容解析为UpdateEntity实体类
  UpdateEntity customParseJson(Map json) {
    return UpdateEntity(
      hasUpdate: true,
      isIgnorable: json['update_status'] <= 3,
      versionCode: json['version_code'],
      versionName: json['version_name'],
      updateContent: "\r\n${json['content']}\r\n",
      downloadUrl: json['down_url'],
      apkSize: json['apk_size'],
      apkMd5: json['apk_md5'],
    );
  }

  _getVersion() async {
    initXUpdate();
    DataResult res = await CommonAPI.getVersion();
    if (res.result) {
      if (Platform.isAndroid) {
        FlutterXUpdate.updateByInfo(
          updateEntity: customParseJson(res.data),
          topImageRes: 'bg_update_top',
          themeColor: "#FFFFBAA3",
          buttonTextColor: "#FFFFFFFF",
          widthRatio: 0.92,
        );
      }
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) {
        // 初始化屏幕适配组件
        ScreenUtil.init(context, designSize: Size(750, 1334), allowFontScaling: false);
        return ScrollConfiguration(
          behavior: ScrollBehaviorModified(),
          child: FlutterEasyLoading(child: child),
        );
      },
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        //下拉刷新国际化
        RefreshLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      title: "墨岚教育",
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryColor: Styles.colorBg,
        accentColor: Styles.colorTheme,
        primarySwatch: Colors.lime,
        disabledColor: Styles.colorInfo,
        buttonColor: Styles.colorBtn,
      ),
      onGenerateRoute: (settings) {
        print(settings.name);
        var child = MyRoutes.routes(settings.name, settings.arguments)(context);
        if (settings.name == '/login' || settings.name == '/guide')
          return MaterialPageRoute(
            builder: (context) => child,
          );
        return CupertinoPageRoute(
          builder: (context) => child,
        );
      },
      home: MainPage(),
    );
  }
}
