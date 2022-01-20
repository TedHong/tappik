import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tappik/controllers/main_controller.dart';
import 'package:tappik/model/section_model.dart';
import 'package:tappik/ted_module/firebase/firestore_manager.dart';
import 'package:tappik/ted_module/utils/tdtext.dart';
import 'package:tappik/ted_module/utils/custom_widget.dart';
import 'package:tappik/ted_module/utils/tplog.dart';

class SectionScreen extends StatefulWidget {
  SectionScreen({Key? key}) : super(key: key);

  @override
  _SectionScreenState createState() => _SectionScreenState();
}

class _SectionScreenState extends State<SectionScreen> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MainController());
    return StreamBuilder<QuerySnapshot>(
      stream: TDFireStoreManager().getSectionCollection().snapshots(),
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
                  controller.setSctionData('add',
                      id: "", sectionData: SectionModel.getDefaultModel());
                  controller.setMenu(MenuType.EDIT_SECTION);
                  // setState(() {});
                },
              ),
              ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: snapshot.data!.docs.map((doc) {
                  Map<String, dynamic> map = doc.data() as Map<String, dynamic>;
                  SectionModel data = SectionModel.fromJson(map);
                  return Card(
                    child: ListTile(
                      title: TDText(message: data.title, textSize: 20),
                      trailing: InkWell(
                        child: CustomWidget.getRoundedButton('Edit',
                            c: Colors.lightBlue),
                        onTap: () {
                          //Get.toNamed('/admin/editsection', arguments: {'type': 'edit','data': data});
                          controller.setSctionData('edit',
                              id: doc.id, sectionData: data);
                          controller.setMenu(MenuType.EDIT_SECTION);
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
