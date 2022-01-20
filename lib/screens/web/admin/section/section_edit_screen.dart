import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tappik/controllers/main_controller.dart';
import 'package:tappik/model/section_model.dart';
import 'package:tappik/ted_module/firebase/firestore_manager.dart';
import 'package:tappik/ted_module/utils/tdtext.dart';
import 'package:tappik/ted_module/utils/custom_widget.dart';

class SectionEditScreen extends StatefulWidget {
  SectionEditScreen({Key? key}) : super(key: key);

  @override
  _SectionEditScreenState createState() => _SectionEditScreenState();
}

class _SectionEditScreenState extends State<SectionEditScreen> {
  SectionModel _data = SectionModel.getDefaultModel();
  String _type = "add"; // add, edit

  final ctrlTitle = TextEditingController();
  final ctrlNum = TextEditingController();
  final ctrlStorys = TextEditingController();

  double _formProgress = 0;
  bool _isShow = true;
  @override
  void initState() {
    super.initState();
    //_data = Get.arguments['data'];
    //_type = Get.arguments['type'];
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MainController());
    _type = controller.getActionType();
    return GetBuilder<MainController>(builder: (context) {
      _data = controller.getSectionData();
      ctrlTitle.text = _data.title;
      ctrlNum.text = _data.num.toString();

      return Container(
        child: Form(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LinearProgressIndicator(value: _formProgress),
              Row(
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    child: TDText(
                      message: (_type == 'add') ? '추가' : '수정',
                      textSize: 30,
                      textAlignment: Alignment.center,
                    ),
                  ),
                  InkWell(
                    child: CustomWidget.getRoundedButton('저장',
                        c: Colors.lightBlue),
                    onTap: () {
                      _showDialogSave(controller.getSectionId());
                      setState(() {});
                    },
                  ),
                  SizedBox(
                    width: 10,
                    height: 10,
                  ),
                  InkWell(
                    child: CustomWidget.getRoundedButton('취소',
                        c: Colors.lightGreen),
                    onTap: () {
                      //Get.back();
                      controller.setMenu(MenuType.SECTION);
                    },
                  ),
                  SizedBox(
                    width: 10,
                    height: 10,
                  ),
                  InkWell(
                    child: CustomWidget.getRoundedButton('삭제', c: Colors.grey),
                    onTap: () {
                      _showDialogDelete(controller.getSectionId());
                    },
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: _getInputField('title', ctrlTitle, (value) {
                  _data.title = value;
                }),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: _getInputField('Number', ctrlNum, (value) {
                  if (value != "") _data.num = int.parse(value);
                }, inputType: TextInputType.number),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Container(
                        width: 100,
                        child: TDText(message: 'isShow', textSize: 20)),
                    Expanded(
                      child: Container(
                        width: 300,
                        alignment: Alignment.centerLeft,
                        child: Checkbox(
                          value: _isShow,
                          onChanged: (value) {
                            setState(() {
                              _isShow = value!;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Container(
                        width: 150,
                        child: TDText(message: 'Story Ids', textSize: 20)),
                    Expanded(
                      child: Container(
                        width: 300,
                        child: TextFormField(
                          controller: ctrlStorys,
                          decoration: InputDecoration(hintText: 'Story Id'),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: CustomWidget.getRoundedButton('추가',
                            c: Colors.yellow),
                        onTap: () {
                          _data.storys.add(ctrlStorys.text.trim());
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: _data.storys.length > 0,
                child: _getGrid(_data.storys, controller),
              ),
            ],
          ),
        ),
      );
    });
  }

  _getInputField(title, ctrl, onValueChanged,
      {inputType = TextInputType.text, hint = ""}) {
    return Row(
      children: [
        Container(width: 150, child: TDText(message: title, textSize: 20)),
        Expanded(
          child: Container(
            width: 300,
            child: TextFormField(
              controller: ctrl,
              keyboardType: inputType,
              decoration: InputDecoration(hintText: hint),
              onChanged: onValueChanged,
            ),
          ),
        ),
      ],
    );
  }

  _showDialogSave(sectionId) {
    Get.defaultDialog(
        title: '확인',
        middleText: '저장 하시겠습니까?',
        textConfirm: '네',
        textCancel: '아니오',
        onConfirm: () {
          var t = ctrlTitle.text;
          var n = int.parse(ctrlNum.text);
          var s = _isShow;
          List<String> storys = _data.storys;
          SectionModel result = SectionModel(t, n, s, storys);
          if (_type == "add") {
            TDFireStoreManager().addSectionData(result);
          } else if (_type == "edit") {
            TDFireStoreManager().updateSectionData(sectionId, result);
          }
          //Get.back();
          Get.put(MainController()).setMenu(MenuType.SECTION);
        },
        onCancel: () {});
  }

  _showDialogDelete(sectionId) {
    Get.defaultDialog(
        title: '확인',
        middleText: '삭제 하시겠습니까?',
        textConfirm: '네',
        textCancel: '아니오',
        onConfirm: () {
          TDFireStoreManager().removeSectionData(sectionId);
          Get.back();
          Get.put(MainController()).setMenu(MenuType.SECTION);
        },
        onCancel: () {});
  }

  _getGrid(itemList, controller) {
    return Container(
      //color: Colors.amberAccent,
      margin: EdgeInsets.only(left: 100),
      height: 200,
      child: GridView.builder(
          itemCount: itemList!.length, //item 개수
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5, //1 개의 행에 보여줄 item 개수
            childAspectRatio: 10 / 3, //item 의 가로 1, 세로 2 의 비율
            mainAxisSpacing: 10, //수평 Padding
            crossAxisSpacing: 10, //수직 Padding
          ),
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: 20,
              width: 90,
              child: InkWell(
                child: CustomWidget.getRoundedButton(itemList!.elementAt(index),
                    c: Colors.grey, tc: Colors.white),
                onTap: () {
                  _showDialogDeleteStoryId(index, controller);
                },
              ),
            );
          }),
    );
  }

  _showDialogDeleteStoryId(int idx, MainController controller) {
    Get.defaultDialog(
        title: '확인',
        middleText: '삭제 하시겠습니까?',
        textConfirm: '네',
        textCancel: '아니오',
        onConfirm: () {
          List<String> list = controller.getSectionData().storys;
          list.removeAt(idx);
          Get.back();
          setState(() {});
        },
        onCancel: () {});
  }
}
