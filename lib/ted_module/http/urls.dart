import '../common/config.dart';
import '../common/constants.dart';

enum REQ_URL {
  NONE,
  OAUTH_SIGNUP, //가입
  OAUTH_LOGIN, //로그인, 토큰 취득
  API_MAIN, //메인 화면 취득
  API_USER_CONTENT_COUNT, //사용자 - 컨텐츠 - 조회수
  API_USER_PROGRAM_COUNT, //사용자 - 프로그램 - 조회수
  API_COMMON_CONTENT_COUNT, //전체 - 컨텐츠 - 조회수
  API_COMMON_PROGRAM_COUNT, //전체 - 프로그램 - 조회수
  API_USER_CONTENT_VIEWTIME, //사용자 - 컨텐츠 - 시청시간
  API_COMMON_CONTENT_VIEWTIME, //전체 - 컨텐츠 - 시청시간
  API_COMMON_PROGRAM_VIEWTIME, //전체 - 프로그램 - 시청시간
  API_USER_ACCESSCOUNT, //사용자 - 접속 횟수
  API_PROGRAM_LIKE, //프로그램 - 좋아요/별로에요 수
  API_COMMON_KEYWORD, //전체 - 검색 키워드
  API_USER_KEYWORD, //사용자 - 검색 키워드
}

class Urls {
  static get_Host(REQ_URL type) {
    if (type == REQ_URL.OAUTH_LOGIN)
      return get_OAUTH_Host();
    else
      return get_API_Host();
  }

  static get_API_Host() {
    // switch (Config.server_type) {
    //   case SERVER_TYPE.LOCAL:
    //     return Constants.LOCAL_API_URL;
    //   case SERVER_TYPE.BETA:
    //     return Constants.BETA_API_URL;
    //   case SERVER_TYPE.REAL:
    //     return Constants.REAL_API_URL;
    // }
  }

  static get_Web_Host() {
    // switch (Config.server_type) {
    //   case SERVER_TYPE.LOCAL:
    //     return Constants.BETA_WEB_URL;
    //     break;
    //   case SERVER_TYPE.BETA:
    //     return Constants.BETA_WEB_URL;
    //     break;
    //   case SERVER_TYPE.REAL:
    //     return Constants.REAL_WEB_URL;
    //     break;
    // }
  }

  static get_OAUTH_Host() {
    // switch (Config.server_type) {
    //   case SERVER_TYPE.LOCAL:
    //     return Constants.LOCAL_OAUTH_URL;
    //     break;
    //   case SERVER_TYPE.BETA:
    //     return Constants.BETA_OAUTH_URL;
    //     break;
    //   case SERVER_TYPE.REAL:
    //     return Constants.REAL_OAUTH_URL;
    //     break;
    // }
  }

  static getUrl(REQ_URL type) {
    switch (type) {
      case REQ_URL.OAUTH_SIGNUP:
        return "/oauth/token";
      case REQ_URL.OAUTH_LOGIN:
        return "/oauth/token";
      case REQ_URL.API_USER_CONTENT_COUNT:
        return "/civ/user/contentView/count";
      case REQ_URL.API_USER_PROGRAM_COUNT:
        return "/civ/user/programView/count";
      case REQ_URL.API_COMMON_CONTENT_COUNT:
        return "/civ/content/contentView/count";
      case REQ_URL.API_COMMON_PROGRAM_COUNT:
        return "/civ/content/programView/count";
      case REQ_URL.API_USER_CONTENT_VIEWTIME:
        return "/civ/user/contentView/duration";
      case REQ_URL.API_COMMON_CONTENT_VIEWTIME:
        return "/civ/content/contentView/duration";
      case REQ_URL.API_COMMON_PROGRAM_VIEWTIME:
        return "/civ/content/programView/duration";
      case REQ_URL.API_USER_ACCESSCOUNT:
        return "/civ/user/accessView/count";
      case REQ_URL.API_PROGRAM_LIKE:
        return "/civ/content/programView/count/rate";
      case REQ_URL.API_COMMON_KEYWORD:
        return "/civ/content/searchView/count/total";
      case REQ_URL.API_USER_KEYWORD:
        return "/civ/user/searchView/count";
      case REQ_URL.NONE:
        // TODO: Handle this case.
        break;
      case REQ_URL.API_MAIN:
        // TODO: Handle this case.
        break;
    }
  }
}
