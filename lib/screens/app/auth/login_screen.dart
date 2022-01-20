import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tappik/ted_module/common/constants.dart';
import 'package:tappik/ted_module/utils/td_router.dart';
import 'package:tappik/ted_module/utils/tdtext.dart';
import 'package:tappik/ted_module/utils/custom_widget.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Stack(
        children: [
          Align(
              alignment: Alignment.center,
              child: TDText(
                  message: "Tappik",
                  textSize: 50,
                  textAlignment: Alignment.center,
                  textColor: Colors.black)),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(top: 300),
              child: InkWell(
                child: Image.asset(
                    "assets/images/kakao_login_medium_wide.png"), // width:300, height:45, fit:BoxFit.fitWidth),
                onTap: () {
                  Get.offNamed(TPRoute.APP_PICK);
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
