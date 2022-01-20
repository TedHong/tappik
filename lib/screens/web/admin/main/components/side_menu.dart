import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
//import 'package:intl/intl.dart';
import 'package:tappik/controllers/main_controller.dart';
import 'package:tappik/ted_module/utils/tdtext.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MainController());
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
              child: TDText(
            message: 'Tappik\nAdmin',
            textSize: 30,
            textColor: Colors.white,
            maxLines: 2,
          ),
              ),
          DrawerListTile(
            title: "Section",
            svgSrc: "assets/icons/menu_doc.svg",
            press: () {
              controller.setMenu(MenuType.SECTION);
            },
          ),
          DrawerListTile(
            title: "Story",
            svgSrc: "assets/icons/menu_doc.svg",
            press: () {
              controller.setMenu(MenuType.STORY);
            },
          ),          
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        color: Colors.white54,
        height: 16,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white54),
        textDirection: TextDirection.ltr,
      ),
    );
  }
}
