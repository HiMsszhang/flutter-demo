enum Env {
  PROD,
  DEV,
}

class Config {
  static Env env = Env.DEV;

  /// api host
  static const API_HOST_DEV = 'http://molanapi.moyousf.com';
  static const API_HOST_PROD = 'http://molanapi.moyousf.com';

  ///微信APPID
  static const WECHAT_APPID = 'wxfe9e70646d768fc2';
  // static const weChatAppSecret = 'dcad950cd0633a27e353477c4ec12e7a';

  // static const qqAppId = '100424468';
  // static const qqAppKey = 'glFYjkHQGSOCJHMC';
  ///腾讯云im
  static const TENCENT_IM_APPID = '1400444900';

  static String get apiHost {
    if (env == Env.PROD) {
      return API_HOST_PROD;
    } else {
      return API_HOST_DEV;
    }
  }

  static bool get isRelease => bool.fromEnvironment('dart.vm.product');

  static const String S_TOKEN = 'token';

  /// 第一次进入APP
  static const String S_FIRST = 'first';
  static const String S_USERINFO = 'userInfo';
  static const String IM_SIGN = 'imSign';
}
