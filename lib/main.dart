import 'package:flutter/material.dart';
import 'package:tappik/screens/app/auth/login_screen.dart';
import 'package:tappik/screens/app/auth/signup_screen.dart';
import 'package:tappik/screens/app/detail/detail_screen.dart';
import 'package:tappik/screens/app/mypage/mypage_screen.dart';
import 'package:tappik/screens/app/pick/pick_screen.dart';
import 'package:tappik/screens/app/shop/shop_screen.dart';
import 'package:tappik/screens/web/admin/main/admin_screen.dart';
import 'package:tappik/screens/app/home/home_screen.dart';
import '../ted_module/common/constants.dart';
import 'screens/web/dashboard/constants.dart';
import 'screens/intro/intro_screen.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp(options: DefaultFirebaseConfig.platformOptions);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: Constants.app_name,
      debugShowCheckedModeBanner: false,
      textDirection: TextDirection.ltr,
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      //   textTheme: TextTheme(headline6: TextStyle(color: Colors.black)),
      //   fontFamily: GoogleFonts.notoSans().fontFamily,
      // ),
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.white),
        canvasColor: secondaryColor,
      ),
      home: IntroScreen(),
      getPages: [
        GetPage(
          name: TPRoute.INTRO,
          page: () => IntroScreen(),
        ),
        GetPage(
          name: TPRoute.APP_LOGIN,
          page: () => LoginScreen(),
        ),
        GetPage(
          name: TPRoute.APP_SIGNUP,
          page: () => SignupScreen(),
        ),
        GetPage(
          name: TPRoute.APP_PICK,
          page: () => PickScreen(),
        ),
        GetPage(
          name: TPRoute.APP_DETAIL,
          page: () => DetailScreen(),
        ),
        GetPage(
          name: TPRoute.APP_SHOP,
          page: () => ShopScreen(),
        ),
        GetPage(
          name: TPRoute.APP_MYPAGE,
          page: () => MypageScreen(),
        ),
        //web : 어드민
        GetPage(
          name: TPRoute.WEB_ADMIN,
          page: () => AdminScreen(),
        ),
        // GetPage(
        //   name: '/admin/editsection',
        //   page: () => SectionEditScreen(),
        // ),
      ],
    );
  }
}
