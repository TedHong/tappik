import 'package:tappik/screens/app/home/home_screen.dart';
import 'package:tappik/screens/intro/intro_screen.dart';

import '../interface/aewidget.dart';
import 'tplog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TDRouter {
  static final TDRouter _instance = new TDRouter._internal();

  factory TDRouter() {
    return _instance;
  }

  TDRouter._internal() {}
  //static StartView? mainPage;
  static ROUTE_TYPE? currentType = ROUTE_TYPE.INTRO;

  static moveTo(BuildContext context, ROUTE_TYPE type) {
    // Navigator.push(
    //     context, MaterialPageRoute(builder: (context) => getTargetRoute(type)));
    return Navigator.push(context, _createRoute(context, type, null));
  }

  static moveWithData(
      BuildContext context, ROUTE_TYPE type, Map<String, String> data) {
    AEWidget _target = getTargetRoute(type) as AEWidget;
    _target.setData(data);
    // Navigator.push(
    //     context, MaterialPageRoute(builder: (context) => _target as Widget));
    return Navigator.push(context, _createRoute(context, type, _target));
  }

  static moveToReplace(BuildContext context, ROUTE_TYPE type) {
    return Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => getTargetRoute(type)));
  }

  static logout(BuildContext context) {
    //Navigator.popUntil(context, ModalRoute.withName('/logout'));
    Navigator.pushNamedAndRemoveUntil(context, '/logout', (_) => false);
  }

  static back() {}

  static setRoute(ROUTE_TYPE? type) {
    TPLog.log('setRoute : ' + type.toString());
    currentType = type;
    Get.find<RouteController>().refresh();
  }

  static goTo(ROUTE_TYPE? type, args) {
    TPLog.log('goTo : ' + type.toString());
    Get.to(() => getTargetRoute(type), arguments: args);
  }

  static goToNamed(name) {
    Get.toNamed(name);
  }

  static goToNamedWithData(name, args) {
    Get.toNamed(name, arguments: args);
  }

  static Widget? currentView;
  static Widget getCurrentView() {
    TPLog.log('getCurrentView : ' + currentType.toString());
    return getTargetRoute(currentType);
  }

  static Route _createRoute(
      BuildContext context, ROUTE_TYPE type, AEWidget? target) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          (target != null) ? target as Widget : getTargetRoute(type),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  static Widget getTargetRoute(ROUTE_TYPE? type) {
    Widget result = Container(); // = IntroView();
    switch (type) {
      case ROUTE_TYPE.INTRO:
        result = IntroScreen();
        break;
      case ROUTE_TYPE.HOME:
        result = HomeScreen();
        break;
      case ROUTE_TYPE.ADMIN_HOME:
        //result = SignUpApp();
        break;
    }

    return result;
  }

  static StreamController() {}
}

class RouteController extends GetxController {
  late Function f;
  RouteController(fun) {
    f = fun;
  }
  refresh() {
    f();
  }
}

enum ROUTE_TYPE {
  INTRO,
  LOGIN,
  SIGNUP,
  START,
  HOME,
  DETAIL,
  CHAT,
  SETTING,
  ALARM,
  ADMIN_HOME,
}
