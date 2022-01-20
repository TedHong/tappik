/**
 * Created by tedhong
 * Project: askeverything_m
 * File : src.http \ apis.dart
 * Date : 2020/11/05, 11:20 AM
 */

class APIs{
//03.사용자 - 02.인증 관련

//POST 비밀번호 변경
static String authPw = '/api/auth/password';

//POST 01.비밀번호 확인
  static String authPwConfirm = '/api​/auth​/password​/confirm';

//POST 04.SNS가입자용 메일 발송
  static String authSnspwd = '/api/auth/snspwd';


//GET 05.사용자 정보 취득
  static String myInfo = '/api​/my';




//03.사용자 - 03.결제 관련

//POST MOBILE웹 정기결제 등록 전처리
  static String billingMobile = '/api​/billing​/make​/mobile';

//POST 환불처리
  static String billingRefund = '/api​/billing​/refund';

//GET 결제 전 표시항목 취득
  static String billingView = '/api/billing/view';



//03.사용자 - 04.쿠폰 관련

//GET 쿠폰 목록 취득 / 쿠폰 등록
  static String couponInfo = '/api​/coupon';




//03.사용자 - 07.MAIN 관련

//GET 01.메인 화면 취득
  static String mainInfo = '/api/main';

//GET 03.마지막 공지 정보 반환
  static String mainLastnoti = '/api/main/lastnoti';

//GET 02.강의 이어서 보기 취득
  static String mainMyClass = '​/api​/main​/my';




//03.사용자 - 08.프로필 관련

//GET 메인메뉴 카테고리 취득
  static String menuList = '/api/menu';




//03.사용자 - 09.공지 관련

//GET 01.공지사항 목록 조회
  static String noticeList = '/api/notice';

//03.사용자 - 10.재생 관련

//GET 02.펠리컨 인증 토큰 발행
  static String pallyconInfo = '/api/pallycon';

//POST 01.마지막 재생시간 업데이트
  static String updatePlayTime = '/api/play/time';

//POST 04.미재생중 status 업데이트
  static String updateUnwatch = '/api/video/unwatching';


//POST 03.재생중 status 업데이트
  static String updateWatch = '/api/video/watching';




//03.사용자 - 11.프로필 관련

//GET 01.회원정보 취득 / 프로필 변경
  static String profineInfo = '/api/profile';

//GET 09.결제 내역 취득
  static String billhistory = '/api/profile/billhistory';

//POST 04.프로필 이미지 변경
  static String profileImageChange = '/api/profile/image';


//GET 03.멤버십 상태 취득
  static String profileMembership = '​/api​/profile​/membership';

//POST 10.해지 요청
  static String profileMembershipClose = '/api/profile/membership/close';

//POST 07.휴대전화 인증 확인
  static String profileSmsConfirm = '/api/profile/sms/confirm';

//POST 06.휴대전화 인증 요청
  static String profileSmsRequest = '​/api​/profile​/sms​/request';

//GET 08.이용관리 정보 취득
  static String profileUse = '​/api​/profile​/use';

//POST 05.회원 탈퇴
  static String profileWithdrawal = '​/api​/profile​/withdrawal';

//03.사용자 - 12.강의 관련

//POST 10.강의실에 담기
  static String programAddCart = '​/api​/program​/add​/class';

//GET 01.카테고리 아이디로 목록 조회
  static String programCategory = '/api/program/category';

//GET 03.클래스 아이디로 목록 조회
  static String programClassList = '​/api​/program​/class';

//GET 08.강의 상세
  static String programDetail = '​/api​/program​/detail';

//GET 02.검색어로 목록 조회
  static String programKeyword = '​/api​/program​/keyword';

//POST 09.좋아요/싫어요
  static String programLike = '​/api​/program​/like';

//GET 05.내 수강 목록 조회
  static String programMyContents = '/api/program/my/contents';

//GET 06.내가 보고 싶어한 강의 목록 조회
  static String programMyCartList = '/api/program/my/programs/cart';

//GET 07.수강 완료된 목록 조회
  static String programMyComplete = '​/api​/program​/my​/programs​/complete';

//GET 04.새로 올라온 강의 목록 조회
  static String programNewList = '​/api​/program​/new';

//POST 11.강의실에 빼기
  static String programRemoveClass = '​/api​/program​/remove​/class';

//POST 12.수강 시작
  static String programStartClass = '/api/program/start/class';


}