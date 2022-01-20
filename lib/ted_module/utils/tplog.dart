import 'dart:convert';
import '../common/config.dart';
import '../common/constants.dart';
import '../utils/utils.dart';
import 'package:intl/intl.dart';

class TPLog {
  static bool _showLog = false; //리얼 서버에서 로그를 보고 싶을 떄 true 로 변경
  static log(var _msg) {
    if (Config.server_type == SERVER_TYPE.BETA || _showLog) print(getNow()+" "+_msg);
  }

  static logTag(var tag, var _msg) {
    if (Config.server_type == SERVER_TYPE.BETA || _showLog)
      print(getNow()+" [" + tag.toString() + "] " + _msg.toString());
  }

  static maplog(Map<String, dynamic> map) {
    if (Config.server_type == SERVER_TYPE.BETA || _showLog)
      print(getNow()+" [MAP_LOG] " + JsonEncoder().convert(map));
  }

  static divider(var _msg) {
    if (Config.server_type == SERVER_TYPE.BETA || _showLog)
      print("============" + _msg + " =============");
  }

  static String getNow(){
    String format = 'yyyy-MM-dd HH:mm:ss |';
    return DateFormat(format).format(DateTime.now());
  }
}
