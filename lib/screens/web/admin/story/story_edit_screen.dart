import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tappik/controllers/main_controller.dart';
import 'package:tappik/model/episode_model.dart';
import 'package:tappik/model/story_model.dart';
import 'package:tappik/ted_module/firebase/firestore_manager.dart';
import 'package:tappik/ted_module/utils/tdtext.dart';
import 'package:tappik/ted_module/utils/custom_widget.dart';
import 'package:tappik/ted_module/utils/random_string.dart';

class StoryEditScreen extends StatefulWidget {
  StoryEditScreen({Key? key}) : super(key: key);

  @override
  _StoryEditScreenState createState() => _StoryEditScreenState();
}

class _StoryEditScreenState extends State<StoryEditScreen> {
  final ScrollController episodeScrollCtrl = ScrollController();
  StoryModel _data = StoryModel.getDefaultModel();
  String _type = "add"; // add, edit

  final ctrlTitle = TextEditingController();
  final ctrlNum = TextEditingController();
  final ctrlDes = TextEditingController();
  final ctrlCast = TextEditingController();
  final ctrlCategory = TextEditingController();
  final ctrlHashtag = TextEditingController();
  final ctrlThumbnail = TextEditingController();
  final ctrlPoster = TextEditingController();

  final ctrlEpiNum = TextEditingController();
  final ctrlEpiTitle = TextEditingController();
  final ctrlEpiUrl = TextEditingController();

  double _formProgress = 0;
  bool _isShow = true;

  Uint8List? bytesThumbnail;
  Uint8List? bytesPoster;

  @override
  void initState() {
    super.initState();
    //_data = Get.arguments['data'];
    //_type = Get.arguments['type'];
  }

  setInitData(StoryModel story) {
    ctrlTitle.text = story.title;
    ctrlNum.text = story.num.toString();
    ctrlDes.text = story.description;
    ctrlCast.text = story.cast;
    ctrlCategory.text = story.category;
    ctrlHashtag.text = story.hashTag.join(",");
    ctrlThumbnail.text = story.urlThumbnail;
    ctrlPoster.text = story.urlPoster;
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MainController());
    _type = controller.getActionType();
    return GetBuilder<MainController>(builder: (context) {
      _data = controller.getStoryData();
      setInitData(_data);

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
                      message: (_type == 'add') ? '??????' : '??????',
                      textSize: 30,
                      textAlignment: Alignment.center,
                    ),
                  ),
                  InkWell(
                    child: CustomWidget.getRoundedButton('??????',
                        c: Colors.lightBlue),
                    onTap: () {
                      _showDialogSave(controller.getStoryId());
                      setState(() {});
                    },
                  ),
                  SizedBox(
                    width: 10,
                    height: 10,
                  ),
                  InkWell(
                    child: CustomWidget.getRoundedButton('??????',
                        c: Colors.lightGreen),
                    onTap: () {
                      //Get.back();
                      controller.setMenu(MenuType.STORY);
                    },
                  ),
                  SizedBox(
                    width: 10,
                    height: 10,
                  ),
                  InkWell(
                    child: CustomWidget.getRoundedButton('??????', c: Colors.grey),
                    onTap: () {
                      _showDialogDelete(controller.getStoryId());
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
              // ??????
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Container(
                        width: 150,
                        child: TDText(message: "Description", textSize: 20)),
                    Expanded(
                      child: Container(
                        width: 300,
                        child: TextFormField(
                          controller: ctrlDes,
                          minLines: 1,
                          maxLines: 5,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(hintText: "???????????? \\n ??????"),
                          onChanged: (value) {
                            _data.description = value;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // ?????????
              Padding(
                padding: EdgeInsets.all(8.0),
                child: _getInputField('Casting', ctrlCast, (value) {
                  _data.cast = value;
                }),
              ),
              //????????????
              Padding(
                padding: EdgeInsets.all(8.0),
                child: _getInputField('Category', ctrlCategory, (value) {
                  _data.category = value;
                }),
              ),
              //????????????
              Padding(
                padding: EdgeInsets.all(8.0),
                child: _getInputField('Hashtag', ctrlHashtag, (value) {
                  _data.hashTag = value.split(',').toList();
                }, hint: "?????? ????????? ??????( , )??? ????????? ???????????????(???: #tag1, #tag2)"),
              ),
              // ????????? - ?????????
              Padding(
                padding: EdgeInsets.all(8.0),
                child: _getImageUploadField('Thumbnail', ctrlThumbnail,
                    onValueChanged: (value) {
                  _data.hashTag = value;
                }, onTapFunc: () {
                  TDFireStoreManager().pickImageFile().then((value) {
                    setState(() {
                      ctrlThumbnail.text = value!.name;
                      bytesThumbnail = value.bytes;
                    });
                  });
                }),
              ),
              // ????????? - ?????????
              Padding(
                padding: EdgeInsets.all(8.0),
                child: _getImageUploadField('Poster', ctrlPoster,
                    onValueChanged: (value) {
                  _data.hashTag = value;
                }, onTapFunc: () {
                  TDFireStoreManager().pickImageFile().then((value) {
                    setState(() {
                      ctrlPoster.text = value!.name;
                      bytesPoster = value.bytes;
                    });
                  });
                }),
              ),
              Divider(thickness: 1, color: Colors.grey),
              //???????????? ?????????
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Container(
                      height: 200,
                      width: 500,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(4.0),
                            child: _getInputField('Ep)Number', ctrlEpiNum,
                                (value) {
                              //if(value != "") _data.num = int.parse(value);
                            }, inputType: TextInputType.number),
                          ),
                          //???????????? - ??????
                          Padding(
                            padding: EdgeInsets.all(4.0),
                            child: _getInputField('Ep)Title', ctrlEpiTitle,
                                (value) {
                              // _data.hashTag = value;
                            }),
                          ),
                          // ???????????? - ????????? URL
                          Padding(
                            padding: EdgeInsets.all(4.0),
                            child:
                                _getInputField('Ep)Url', ctrlEpiUrl, (value) {
                              // _data.hashTag = value;
                            }),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(5),
                        height: 100,
                        child: InkWell(
                          child: CustomWidget.getRoundedButton('??????',
                              c: Colors.white38, fs: 26),
                          onTap: () {
                            var n = int.parse(ctrlEpiNum.text);
                            var t = ctrlEpiTitle.text;
                            var u = ctrlEpiUrl.text;
                            EpisodeModel ep = EpisodeModel(n, t, true, u);
                            _data.episodes.add(ep);
                            setState(() {
                              ctrlEpiNum.text = "";
                              ctrlEpiTitle.text = "";
                              ctrlEpiUrl.text = "";
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: _data.episodes.length > 0,
                child: Container(
                  height: 300,
                  child: ListView.builder(
                    controller: episodeScrollCtrl,
                    scrollDirection: Axis.vertical,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(8),
                    itemCount: _data.episodes.length,
                    itemBuilder: (BuildContext context, int index) {
                      EpisodeModel data = _data.episodes[index];
                      return Card(
                        child: ListTile(
                          title: TDText(
                              message: data.num.toString() + " : " + data.title,
                              textSize: 16),
                          trailing: InkWell(
                            child: CustomWidget.getRoundedButton('Delete',
                                c: Colors.lightBlue),
                            onTap: () {
                              _showDeleteDialogEpisode(index, controller);
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
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

  _getImageUploadField(title, ctrl,
      {inputType = TextInputType.text, onValueChanged, onTapFunc}) {
    return Row(
      children: [
        Container(width: 150, child: TDText(message: title, textSize: 20)),
        Expanded(
          child: Container(
            width: 300,
            child: TextFormField(
              readOnly: true,
              controller: ctrl,
              keyboardType: inputType,
              decoration: InputDecoration(hintText: "jpg, png ????????? ???????????????."),
              onChanged: onValueChanged,
            ),
          ),
        ),
        InkWell(
          child: CustomWidget.getRoundedButton('??????', c: Colors.grey),
          onTap: onTapFunc,
        ),
      ],
    );
  }

  // ?????? ?????? ??????
  _showDialogSave(StoryId) {
    Get.defaultDialog(
        title: '??????',
        middleText: '?????? ???????????????????',
        textConfirm: '???',
        textCancel: '?????????',
        onConfirm: () async {
          var urlThumbnail = "thumbnail url";
          if (bytesThumbnail != null && bytesThumbnail!.isNotEmpty) {
            var ext = ctrlThumbnail.text.endsWith('png') ? ".png" : ".jpg";
            var _fileName = ID_PREFIX.THUMBNAIL + "_" + randomAlpha(10) + ext;
            urlThumbnail = await TDFireStoreManager().uploadFileByte(
                bytesThumbnail!, STORAGE_PATH.IMG_TMB + _fileName);
          } else {
            urlThumbnail = _data.urlThumbnail;
          }
          var urlPoster = "poster url";
          if (bytesPoster != null && bytesPoster!.isNotEmpty) {
            var ext = ctrlPoster.text.endsWith('png') ? ".png" : ".jpg";
            var _fileName = ID_PREFIX.POSTER + "_" + randomAlpha(10);
            urlPoster = await TDFireStoreManager().uploadFileByte(
                bytesPoster!, STORAGE_PATH.IMG_PST + _fileName + ext);
          } else {
            urlPoster = _data.urlPoster;
          }

          var id = ""; // TDFireStoreManager ?????? ??????
          int num = int.parse(ctrlNum.text);
          var title = ctrlTitle.text;
          var isShow = _isShow;
          List<EpisodeModel> episodes = _data.episodes;
          var description = ctrlDes.text;
          var cast = ctrlCast.text;
          var category = ctrlCategory.text;
          var difficulty = "??????";
          List<String> hashTag = ctrlHashtag.text.split(',').toList();

          StoryModel result = StoryModel(
              id,
              num,
              title,
              isShow,
              episodes,
              description,
              cast,
              category,
              difficulty,
              hashTag,
              urlThumbnail,
              urlPoster);
          if (_type == "add") {
            TDFireStoreManager().addStoryData(result);
          } else if (_type == "edit") {
            result.id = StoryId;
            TDFireStoreManager().updateStoryData(StoryId, result);
          }
          //Get.back();
          Get.put(MainController()).setMenu(MenuType.STORY);
        },
        onCancel: () {});
  }

  _showDialogDelete(StoryId) {
    Get.defaultDialog(
        title: '??????',
        middleText: '?????? ???????????????????',
        textConfirm: '???',
        textCancel: '?????????',
        onConfirm: () async {
          if (ctrlThumbnail.text != "") {
            TDFireStoreManager().deleteFile(ctrlThumbnail.text);
          }
          if (ctrlPoster.text != "") {
            TDFireStoreManager().deleteFile(ctrlPoster.text);
          }
          TDFireStoreManager().removeStoryData(StoryId);
          Get.back();
          Get.put(MainController()).setMenu(MenuType.STORY);
        },
        onCancel: () {});
  }

  _showDeleteDialogEpisode(int idx, MainController controller) {
    Get.defaultDialog(
        title: '??????',
        middleText: '?????? ???????????????????',
        textConfirm: '???',
        textCancel: '?????????',
        onConfirm: () {
          List<EpisodeModel> list = controller.getStoryData().episodes;
          list.removeAt(idx);
          Get.back();
          setState(() {});
        },
        onCancel: () {});
  }
}
