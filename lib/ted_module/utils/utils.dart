/**
 * Created by tedhong
 * Project: askeverything_m
 * File : src.utils \ utils.dart
 * Date : 2020/11/02, 2:52 PM
 */
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../common/colors.dart';
import '../http/aehttp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart' show DateFormat, NumberFormat;

class Utils {
  // 문자열을 base64 형태의 byte 로 변환
  static btoa(String str) {
    var bytes = utf8.encode(str);
    var base64 = base64Encode(bytes);
    return base64;
  }

  static logout() {}
//SharedPreferences
  static setPrefString(String key, String value) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString(key, value);
  }

  static setPrefStringList(String key, List<String> value) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setStringList(key, value);
  }

  static setPrefInt(String key, int value) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setInt(key, value);
  }

  static setPrefBool(String key, bool value) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setBool(key, value);
  }

  static setPrefDouble(String key, double value) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setDouble(key, value);
  }

  static dynamic getPrefData(String key) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return await pref.get(key) ?? null;
  }

  static Future<bool> getPrefBool(String key) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool(key) ?? false;
  }

  static Future<int> getPrefInt(String key) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getInt(key) ?? 0;
  }

  static Future<String?> getPrefString(String key) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(key) ?? "";
  }

  static Future<List<String>?> getPrefStringList(String key) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getStringList(key) ?? [];
  }

  static dynamic removeData(String key) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return await pref.remove(key);
  }

  static removeAllPref() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }

//end of SharedPrefrences

  static showToast(String str) {
    Fluttertoast.showToast(
        msg: str,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: AEColors.POINT,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(em);
  }

  static launchBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false, forceWebView: false);
    }
  }

  static convertTime(var ms) {
    var _ms = ms;
    var hours = (_ms / (60 * 60 * 100)).toInt();
    var h_d = (_ms % (60 * 60 * 100)).toInt();
    if (hours > 0) _ms = h_d;

    var min = (((_ms / (100 * 60)))).toInt(); //분
    var m_d = (((_ms % (100 * 60)))).toInt(); //분
    if (min > 0) _ms = m_d;

    var seconds = (_ms / 100).toInt(); //초
    return (hours > 0)
        ? "${hours}시 ${min}분 ${seconds}초"
        : "${min}분 ${seconds}초";
  }

  static int doubleToInt(double d) {
    return d.round();
  }

  static String addComma(int param) {
    return new NumberFormat('###,###,###,###')
        .format(param)
        .replaceAll(' ', '');
  }

  static void setOrientationPortrait() {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  }

  static void setOrientationLandscape() {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  }

// SystemChrome.setEnabledSystemUIOverlays([]);    //  상태바, 내비게이션 감추기(fullscreen)
// SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);    //  모두 보이기(일반 화면)
// SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);    //  상태바 감추기
// SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);    //  내베기에션바 감추기
  static void hideAndroidNavigationUI() {
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  static void showAndroidNavigationUI() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  }

  static void copyToClipboard(String str, {String toast = ""}) {
    Clipboard.setData(ClipboardData(text: str));
    if (toast != "") {
      showToast(toast);
    }
  }

  //시간을 YYYYMMDD 형태의 문자열로 반환 현재, 1달전, 3달전, 6달전, 12달전, 1주전
  static getDateString(type) {
    String format = 'yyyyMMdd';
    DateTime now = DateTime.now().toUtc().add(Duration(hours: 9));
    ;
    switch (type) {
      case DATE_TYPE.NOW:
        return DateFormat(format).format(now);
      case DATE_TYPE.B_MON_1:
        return DateFormat(format).format(now.add(Duration(days: -30)));
      case DATE_TYPE.B_MON_3:
        return DateFormat(format).format(now.add(Duration(days: -30 * 3)));
      case DATE_TYPE.B_MON_6:
        return DateFormat(format).format(now.add(Duration(days: -30 * 6)));
      case DATE_TYPE.B_MON_12:
        return DateFormat(format).format(now.add(Duration(days: -30 * 12)));
      case DATE_TYPE.B_WEEK_1:
        return DateFormat(format).format(now.add(Duration(days: -7)));
    }
  }

  static getDateToString(date) {
    return DateFormat('yyyyMMdd').format(date);
  }

  static getNowToFormat(String format) {
    return DateFormat(format)
        .format(DateTime.now().toUtc().add(Duration(hours: 9)));
  }

  static getStatusMessage(REQUEST_STATUS status) {
    switch (status) {
      case REQUEST_STATUS.READY:
        return "조회 버튼을 눌러주세요.";
      case REQUEST_STATUS.LOADING:
        return "데이터를 불러오고 있습니다";
      case REQUEST_STATUS.SUCESS:
        return "조회 완료!";
      case REQUEST_STATUS.NOTHING:
        return "데이터가 없습니다.";
      case REQUEST_STATUS.ERROR:
        return "오류가 발생했습니다. 다시 시도해주세요.";

      default:
    }
  }

  static startTimer(sec, action) {
    return Future.delayed(Duration(seconds: sec), action);
  }
}

enum DATE_TYPE {
  NOW,
  B_MON_1, // 1달 전
  B_MON_3, // 3달 전
  B_MON_6, // 6달 전
  B_MON_12, // 12달 전
  B_WEEK_1, // 1주 전
  SELECT, // 지정 기간
}

enum REQUEST_STATUS {
  READY, // '조회를 눌러주세요'
  LOADING, // '데이터를 불러오고 있습니다'
  SUCESS, // 조회 완료
  NOTHING, // 데이터가 없습니다.
  ERROR, //오류가 발생했습니다.
}
