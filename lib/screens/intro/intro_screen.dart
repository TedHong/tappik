import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:tappik/screens/web/admin/main/admin_screen.dart';
import 'package:tappik/ted_module/common/colors.dart';
import 'package:tappik/ted_module/common/constants.dart';
import 'package:tappik/ted_module/firebase/firebase_config.dart';
import 'package:tappik/ted_module/utils/tplog.dart';
import '../../ted_module/utils/tdtext.dart';
import '../../ted_module/utils/utils.dart';
import 'package:flutter/material.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  BuildContext? _context;
  _IntroScreenState() {
    // Future.delayed(const Duration(milliseconds: 2000), () {
    //   setState(() {
    //     if (kIsWeb) {
    //       // running on the web!
    //       Get.to('/admin');
    //       //AERouter.moveToReplace(_context!, ROUTE_TYPE.ADMIN_HOME);
    //     } else {
    //       AERouter.moveToReplace(_context!, ROUTE_TYPE.HOME);
    //     }
    //   });
    // });
  }

  /// The future is part of the state of our widget. We should not call `initializeApp`
  /// directly inside [build].
  final Future<FirebaseApp> _initialization =
      Firebase.initializeApp(options: DefaultFirebaseConfig.platformOptions);
  @override
  void initState() {
    //firebase null 에러 해결
    //initializeFlutterFire().whenComplete(() {
    //super.initState();
    //});
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    bool _isWeb = true;
    try {
      _isWeb = (Platform.isAndroid || Platform.isIOS);
    } catch (e) {
      _isWeb = true;
    }

    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Container(
              width: 100,
              height: 100,
              alignment: Alignment.center,
              child: Text("ERROR"));
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return Material(
            child: Scaffold(
                body: Center(
              child: _isWeb ? startMobile() : startWeb(),
            )),
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Container(
          width: 100,
          height: 100,
          alignment: Alignment.center,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AEColors.POINT50),
          ),
        );
      },
    );
  }

  initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp(
          options: DefaultFirebaseConfig.platformOptions);
    } catch (e) {
      print(e.toString());
    }
  }

  startMobile() {
    Utils.startTimer(2, () {
      Get.offNamed(TPRoute.APP_LOGIN);
    });
    return Center(
      child: TDText(
        message: "Tappik",
        textSize: 50,
        textColor: Colors.black,
      ),
    );
  }

  startWeb() {
    return Column(
      children: [
        Container(
          //color: Colors.amber,
          width: 150,
          height: 150,
          child: TDText(
            message: "Tappik",
            textSize: 50,
            textColor: Colors.black,
          ),
          // CustomWidget.AEImageSize(
          //     'assets/img/seoul_logo.png', 100, 100, BoxFit.fitWidth),
        ),
        InkWell(
          onTap: () {
            TPLog.log("onTap");
            //TDFireStoreManager().getStoryList(["st00001"]);
            Get.off(AdminScreen());
            setState(() {});
          },
          child: Container(
              width: 200,
              height: 60,
              alignment: Alignment.center,
              child: TDText(
                message: "Get Data",
                textSize: 30,
                textAlign: TextAlign.center,
                textAlignment: Alignment.center,
              ),
              color: Colors.amber),
        )
      ],
    );
  }
}
