class Constants {
  static String package_name = 'kr.co.tappik.tappik_beta';
  static String app_name = 'tappik';
  static String apikey = '';
  static String BASIC_AUTH = '';
  static String USERDATA = 'userdata';
}

enum SERVER_TYPE {
  LOCAL,
  BETA,
  REAL,
}

class TPRoute {
  static String INTRO = "/intro";
  static String APP_PICK = "/app/picks";
  static String APP_LOGIN = "/app/login";
  static String APP_SIGNUP = "/app/signup";
  static String APP_DETAIL = "/app/detail";
  static String APP_SHOP = "/app/shop";
  static String APP_MYPAGE = "/app/mypage";
  static String WEB_ADMIN = "/admin";
}
