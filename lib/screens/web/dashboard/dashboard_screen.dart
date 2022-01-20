import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tappik/controllers/main_controller.dart';
import 'package:tappik/screens/web/admin/section/section_edit_screen.dart';
import 'package:tappik/screens/web/admin/section/section_screen.dart';
import 'package:tappik/screens/web/admin/story/story_edit_screen.dart';
import 'package:tappik/screens/web/admin/story/story_screen.dart';
import 'package:tappik/screens/web/dashboard/constants.dart';
import 'package:tappik/ted_module/utils/tplog.dart';

import '../../../responsive.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final sideMenuController = Get.put(MainController());
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            // Header(),
            SizedBox(height: defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: GetBuilder<MainController>(
                    builder: (_) => getSubPage(sideMenuController.menuType),
                  ),
                ),
                if (!Responsive.isMobile(context))
                  SizedBox(width: defaultPadding),
                // On Mobile means if the screen is less than 850 we dont want to show it
                if (!Responsive.isMobile(context))
                  Expanded(
                    flex: 2,
                    child: Container(), //StarageDetails(),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  getSubPage(MenuType type) {
    TPLog.log('getSubPage : ' + type.toString());
    if (type == MenuType.SECTION)
      return SectionScreen();
    else if (type == MenuType.EDIT_SECTION)
      return SectionEditScreen();
    else if (type == MenuType.STORY)
      return StoryScreen();
    else if (type == MenuType.EDIT_STORY) return StoryEditScreen();
  }
}
