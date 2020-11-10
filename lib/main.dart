import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:molan_edu/pages/main.dart';
import 'package:molan_edu/providers/common_state.dart';
import 'package:molan_edu/providers/user_state.dart';
import 'package:molan_edu/generated/l10n.dart';
import 'package:molan_edu/styles.dart';
import 'package:molan_edu/utils/routes.dart';
import 'package:tencent_im_plugin/tencent_im_plugin.dart';
import 'package:tencent_im_plugin/enums/log_print_level.dart';
import 'package:molan_edu/config/config.dart';
import 'package:fluwx/fluwx.dart';
import 'package:molan_edu/utils/net/code.dart';
import 'package:molan_edu/utils/net/event.dart';
import 'package:molan_edu/utils/navigator.dart';
import 'package:fluttertoast/fluttertoast.dart';

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

class _MyAppState extends State<MyApp> with HttpErrorListener {
  @override
  void initState() {
    super.initState();
    // 初始化IM SDK(每次仅调用一次)
    TencentImPlugin.initSDK(appid: Config.TENCENT_IM_APPID, logPrintLevel: LogPrintLevel.info);
    _initFluwx();
  }

  /// init微信sdk
  _initFluwx() async {
    await registerWxApi(appId: Config.WECHAT_APPID, doOnAndroid: true, doOnIOS: true, universalLink: "https://your.univerallink.com/link/");
    var result = await isWeChatInstalled;
    print("is installed $result");
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
          child: child,
        );
      },
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      title: "墨岚教育",
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryColor: Styles.colorBg,
        accentColor: Styles.colorTheme,
        primarySwatch: Colors.lime,
        disabledColor: Styles.colorInfo,
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

mixin HttpErrorListener on State<MyApp> {
  StreamSubscription stream;

  @override
  void initState() {
    super.initState();

    stream = httpEventBus.on<HttpErrorEvent>().listen((event) {
      errorHandleFunction(event.code, event.message);
    });
  }

  @override
  void dispose() {
    super.dispose();
    Fluttertoast.cancel();
    if (stream != null) {
      stream.cancel();
      stream = null;
    }
  }

  ///网络错误提醒
  errorHandleFunction(int code, message) {
    switch (code) {
      case Code.NETWORK_ERROR:
        _showToast('网络异常');
        break;
      case 401:
        _showToast('登录过期，请重新登录！');
        NavigatorUtils.pushNamed(context, '/login');
        break;
      case 403:
        _showToast('403权限错误');
        break;
      case 404:
        _showToast('404错误');
        break;
      case 422:
        _showToast('请求实体异常');
        break;
      case Code.NETWORK_TIMEOUT:
        //超时
        _showToast('请求超时');
        break;
      default:
        _showToast(message ?? 'error');
        break;
    }
  }

  void _showToast(String msg) {
    Fluttertoast.showToast(msg: msg);
  }
}
