import 'dart:io';

import 'dart:async';
import 'dart:convert';
import '../utils/utils.dart';
import '../utils/tplog.dart';
import '../http/urls.dart';
import '../common/constants.dart';
import 'package:http/http.dart' as http; 

class AEHttp {
  late http.Client client;
  static final AEHttp _instance = AEHttp._internal();
  factory AEHttp() {
    return _instance;
  }
  AEHttp._internal() {
    // init
    client = http.Client();
  }

  // API - Http Get request
  Future<dynamic> requestGet(
    REQ_URL type,
    Map<String, dynamic> params,
  ) async {
    TPLog.divider(" requestGet : " + type.toString());
    var _token = "";
    String _host = Urls.get_Host(type);
    _host = _host.replaceAll("https://", "");
    _host = _host.replaceAll("http://", "");
    String _url = Urls.getUrl(type);

    try {
      var uri = (params != null)
          ? Uri.https(_host, _url, params)
          : Uri.https(_host, _url);

      Map<String, String> requestHeaders = {
        //'Content-type': 'application/x-www-form-urlencoded',
        'Accept': "application/json, text/plain;charset=UTF-8, */*",
        //'Authorization': _token,
        //'x-client-mobile': 'true'
      };
      // bool isSignURI =
      //     (type == REQ_URL.OAUTH_LOGIN || type == REQ_URL.OAUTH_SIGNUP);
      // if (isSignURI == false) {
      //   String _sessionToken =
      //       await Utils.getPrefData(Constants.KEY_ACCESS_TOKEN);
      //   _token = "Bearer " + _sessionToken;
      //   requestHeaders['Authorization'] = _token;
      // }

      TPLog.logTag("REQ URL", uri.toString());
      TPLog.maplog(requestHeaders);
      final http.Response response = await client.get(uri, headers: requestHeaders);

      TPLog.logTag("RES URL", response.request?.url);
      TPLog.logTag("RES BODY", response.body);
      String resBody = utf8.decode(response.bodyBytes);
      TPLog.logTag("RES BODY", resBody);
      if (response.statusCode == 200) {
        TPLog.divider(" GET Finish : " + type.toString());
        return (response.body == "") ? null : json.decode(resBody);
      } else {
        checkError(response.body);
      }
    } on Exception catch (e, s) {
      TPLog.logTag('Exception', "$e");
      TPLog.logTag('Stacktrace', "$s");
    }
  }

  // Http Post Request
  Future<String> requestPost(
      REQ_URL type, Map<String, dynamic> params, bool checkSavedData) async {
    TPLog.divider(" requestPost : " + type.toString());
    var _token = "";

    var _host = Urls.get_Host(type);
    var _url = Urls.getUrl(type);
    bool isSignURI =
        (type == REQ_URL.OAUTH_LOGIN || type == REQ_URL.OAUTH_SIGNUP);
    Map<String, String> requestHeaders = {
      'Accept': "application/json, text/plain, */*",
      'Accept-Charset': 'utf-8',
      //'Content-Type': 'application/json',
    };
    // if (isSignURI == false) {
    //   String _sessionToken =
    //       await Utils.getPrefData(Constants.KEY_ACCESS_TOKEN);
    //   _token = "Bearer " + _sessionToken;
    //   requestHeaders['Authorization'] = _token;
    // }

    TPLog.logTag("REQ URL", _host + _url);
    String paramStr = JsonEncoder().convert(params);
    TPLog.logTag("paramStr", paramStr);
    final response = await client.post(
      Uri.parse(_host + _url),
      headers: requestHeaders,
      body: paramStr,
    );

    TPLog.logTag("RES URL", response.request?.url);
    String resBody = utf8.decode(response.bodyBytes);
    TPLog.logTag("RES resBody", resBody);
    TPLog.logTag("RES BODY", response.body.toString());
    if (response.statusCode == 200) {
      //FlutterSession().set(type.toString(), response.body); // 세션에 저장
      TPLog.divider(" POST Finish : " + type.toString());
    } else {
      checkError(resBody);
    }
    return resBody;
  }

  Future<String> requestLogin(
      Map<String, dynamic> params, bool checkSavedData) async {
    REQ_URL type = REQ_URL.OAUTH_LOGIN;
    TPLog.divider(" requestPost : " + type.toString());
    var _token = "Basic " + Utils.btoa(Constants.BASIC_AUTH);
    //bool _isLogin = await isLogin();

    var _host = Urls.get_Host(type);
    var _url = Urls.getUrl(type);

    Map<String, String> requestHeaders = {
      //'Accept': "application/json, text/plain, */*",
      //'Content-type': 'application/x-www-form-urlencoded',
      'Authorization': _token,
    };

    TPLog.logTag("REQ URL", _host + _url);
    String paramStr = JsonEncoder().convert(params);
    TPLog.logTag("paramStr", paramStr);
    final response = await client.post(
      Uri.parse(_host + _url),
      headers: requestHeaders,
      body: params,
    );

    TPLog.logTag("RES URL", response.request?.url);
    //String resBody = utf8.decode(response.bodyBytes);
    //AELog.logTag("RES resBody", resBody);
    TPLog.logTag("RES BODY", response.body.toString());
    if (response.statusCode == 200) {
      //FlutterSession().set(type.toString(), response.body); // 세션에 저장
      TPLog.divider(" POST Finish : " + type.toString());
    } else {
      checkError(response.body);
    }
    return response.body;
  }

  checkError(String err) {
    TPLog.log(err);
    Map<String, dynamic> error = json.decode(err);
    if (error['message'] == "unauthorized" ||
        error['message'] == "invalid_grant") {
      Utils.showToast('로그인 정보가 올바르지 않습니다.\n가입 시 사용하신 정보를 입력해 주세요. :)');
    } else {
      TPLog.log(error['message']);
    }
  }

  //Access Token 갱신
  // Http Post Request
  Future<String> requestRefreshToken(Map<String, dynamic> params) async {
    REQ_URL type = REQ_URL.OAUTH_LOGIN;

    TPLog.divider(" requestPost : " + type.toString());

    var _token = "Basic " + Utils.btoa(Constants.BASIC_AUTH);

    TPLog.log("_token : " + _token);

    var _host = Urls.get_Host(type);
    var _url = Urls.getUrl(type);
    Map<String, String> requestHeaders = {
      'Accept': "application/json, text/plain, */*",
      'Authorization': _token,
      'x-client-mobile': 'true'
    };
    TPLog.logTag("REQ URL", _host + _url);
    String paramStr = JsonEncoder().convert(params);
    TPLog.logTag("paramStr", paramStr);
    final response = await client.post(
      Uri.parse(_host + _url),
      headers: requestHeaders,
      body: params,
    );

    TPLog.logTag("RES URL", response.request?.url);
    TPLog.logTag("RES BODY", response.body.toString());
    if (response.statusCode == 200) {
      //FlutterSession().set(type.toString(), response.body); // 세션에 저장
      TPLog.divider(" POST Finish : " + type.toString());
    } else {
      checkError(response.body);
    }
    return response.body;
  }

  Future<String?> postAudioFile(path) async {
    
    var headers = {'Content-Type': 'multipart/form-data'};
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'http://ec2-15-165-237-154.ap-northeast-2.compute.amazonaws.com/predict'));
    request.files.add(await http.MultipartFile.fromPath('file[]', path));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      print(result);
      return result;
    } else {
      print(response.reasonPhrase);
      return response.reasonPhrase;
    }
  }
}
