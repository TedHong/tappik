import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tappik/controllers/main_controller.dart';
import 'package:tappik/model/story_model.dart';
import 'package:tappik/ted_module/firebase/firestore_manager.dart';
import 'package:tappik/ted_module/utils/tdtext.dart';
import 'package:tappik/ted_module/utils/custom_widget.dart';
import 'package:tappik/ted_module/utils/tplog.dart';

class StoryScreen extends StatefulWidget {
  StoryScreen({Key? key}) : super(key: key);

  @override
  _StoryScreenState createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {
  @override
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MainController());
    return StreamBuilder<QuerySnapshot>(
      stream: TDFireStoreManager().getStoryCollection().snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Column(
            children: [
              InkWell(
                child: CustomWidget.getRoundedButton('Add', c: Colors.green),
                onTap: () {
                  controller.setStoryData('add',
                      id: "", storyData: StoryModel.getDefaultModel());
                  controller.setMenu(MenuType.EDIT_STORY);
                  // setState(() {});
                },
              ),
              ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: snapshot.data!.docs.map((doc) {
                  Map<String, dynamic> map = doc.data() as Map<String, dynamic>;
                  StoryModel data = StoryModel.fromJson(map);
                  return Card(
                    child: ListTile(
                      title: TDText(message: data.title, textSize: 20),
                      trailing: InkWell(
                        child: CustomWidget.getRoundedButton('Edit',
                            c: Colors.lightBlue),
                        onTap: () {
                          //Get.toNamed('/admin/editsection', arguments: {'type': 'edit','data': data});
                          controller.setStoryData('edit',
                              id: doc.id, storyData: data);
                          controller.setMenu(MenuType.EDIT_STORY);
                        },
                      ),
                    ),
                  );
                }).toList(),
              )
            ],
          );
        }
      },
    );
  }
}
