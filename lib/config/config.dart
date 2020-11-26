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
  static const WECHAT_LINK = 'https://www.ximosf.com/app/';

  ///腾讯云im
  static const TENCENT_IM_APPID = '1400444900';

  /// 蒲公英下载地址
  static const PGY_URL = "https://www.pgyer.com/uTpp";

  static String get apiHost {
    if (env == Env.PROD) {
      return API_HOST_PROD;
    } else {
      return API_HOST_DEV;
    }
  }

  static bool get isRelease => bool.fromEnvironment('dart.vm.product');

  static const String S_TOKEN = 'token';
  static const String S_COLLECTION = 'courseCollection';

  /// 第一次进入APP
  static const String S_FIRST = 'first';
  static const String IM_SIGN = 'imSign';
  static const String S_HISTORY = 'searchHistory';
  static const String COPYBOOK_SETTING = 'copybookSetting';
}
