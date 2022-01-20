import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:tappik/model/section_model.dart';
import 'package:tappik/model/story_model.dart';
import 'package:tappik/ted_module/utils/filepicker.dart';
import 'package:tappik/ted_module/utils/tplog.dart';

// Collection : Section
final sectionCol =
    FirebaseFirestore.instance.collection(COLLECTION_NAME.SECTION);
// Reference : Section - 레퍼런스 데이터로 변환 -> where 로 조회 가능
final sectionRef = sectionCol.withConverter<SectionModel>(
  fromFirestore: (snapshots, _) => SectionModel.fromJson(snapshots.data()!),
  toFirestore: (data, _) => data.toJson(),
);
final storyCol = FirebaseFirestore.instance.collection(COLLECTION_NAME.STORY);
final storyRef = storyCol.withConverter<StoryModel>(
  fromFirestore: (snapshots, _) => StoryModel.fromJson(snapshots.data()!),
  toFirestore: (data, _) => data.toJson(),
);

final countCol = FirebaseFirestore.instance.collection(COLLECTION_NAME.COUNT);

extension on Query<StoryModel> {
  Query<StoryModel> queryBy(StoryQuery query, value) {
    switch (query) {
      case StoryQuery.ID:
        return where('id', isEqualTo: value);
      case StoryQuery.TITLE:
        return where('title', arrayContains: value);
      case StoryQuery.HASHTAG:
        return where('hashTag', arrayContains: [value]);
      default:
        return where("");
    }
  }
}

enum StoryQuery {
  ID,
  TITLE,
  HASHTAG,
  CAST,
  CATEGORY,
  DIFFICULTY,
}

class TDFireStoreManager {
  static final TDFireStoreManager _instance = TDFireStoreManager._internal();
  factory TDFireStoreManager() {
    return _instance;
  }
  TDFireStoreManager._internal() {
    // init
  }
  // 데이터 생성 갯수 확인
  getDataCount(dataName) async {
    var num = 0;
    await countCol.doc('data_count').get().then((value) {
      Map<String, dynamic> map = value.data() as Map<String, dynamic>;
      num = map[dataName];
    });
    return num;
  }

  // 데이터 생성 갯수 증가
  updateDataCount(dataName, num) {
    countCol.doc('data_count').update({dataName: num});
  }

  // doc 아이디 생성
  genDocID(prefix, num) {
    return prefix + num.toString().padLeft(6, '0');
  }

  // SECTION =============================================

  // get section collection
  getSectionCollection() {
    return sectionCol;
  }

  // Section 데이터 추가
  addSectionData(SectionModel data) async {
    var num = await getDataCount('section');
    num++;
    var docId = genDocID(ID_PREFIX.SECTION, num);
    sectionCol.doc(docId).set(data.toJson());
    updateDataCount('section', num);
  }

  // Section 데이터 수정
  updateSectionData(docId, SectionModel data) {
    sectionCol.doc(docId).update(data.toJson());
  }

  // Section 데이터 삭제
  removeSectionData(docId) {
    sectionCol.doc(docId).delete();
  }

  // STORY =============================================
  //get story collection
  getStoryCollection() {
    return storyCol;
  }

  //story 데이터 추가
  addStoryData(StoryModel data) async {
    var num = await getDataCount('story');
    num++;
    var docId = genDocID(ID_PREFIX.STORY, num);
    data.id = docId;
    storyCol.doc(docId).set(data.toJson());
    updateDataCount('story', num);
  }

  //story 데이터 수정
  updateStoryData(docId, StoryModel data) {
    storyCol.doc(docId).update(data.toJson());
  }

  //story 데이터 삭제
  removeStoryData(docId) {
    storyCol.doc(docId).delete();
  }

  // Image Upload ====================================
  Future<String> uploadFile(String filePath, String uploadPath) async {
    File file = File(filePath);
    try {
      var stroageRef = FirebaseStorage.instance.ref(uploadPath);
      await stroageRef.putFile(file);
      String downloadUrl = await stroageRef.getDownloadURL();
      return downloadUrl;
    } on FirebaseException catch (e) {
      return '-1';
    }
  }

  /**
   * <참고>
   * File Picker 는 Web 에서 path 를 지원하지 않음
   * 파일 이름만 가져올 수 있고 업로드는 byte 를 이용해서 해야 함
   * // Upload file
    await FirebaseStorage.instance.ref('uploads/$fileName').putData(fileBytes);
   */
  Future<String> uploadFileByte(Uint8List fileBytes, String uploadPath) async {
    try {
      var stroageRef = FirebaseStorage.instance.ref(uploadPath);
      await stroageRef.putData(fileBytes);
      String downloadUrl = await stroageRef.getDownloadURL();
      return downloadUrl;
    } on FirebaseException catch (e) {
      print(e.toString());
      return '-1';
    }
  }

  deleteFile(fileUrl) async {
    try {
      await FirebaseStorage.instance.refFromURL(fileUrl).delete().then((value) {
        return true;
      });
    } on FirebaseException catch (e) {
      print(e.toString());
      return false;
    }
  }

  late TDFilePicker picker;
  Future<PlatformFile?> pickImageFile() async {
    picker = TDFilePicker();
    return await picker.pickImgFile();
  }
}

class COLLECTION_NAME {
  static String SECTION = "tbl_section";
  static String STORY = "tbl_story";
  static String COUNT = "tbl_count";
}

class ID_PREFIX {
  static String SECTION = "sc";
  static String STORY = "st";
  static String THUMBNAIL = "tmb";
  static String POSTER = "pst";
}

class STORAGE_PATH {
  static String IMG_TMB = "image/thumbnail/";
  static String IMG_PST = "image/poster/";
  static String IMG_PROFILE = "image/profile/";
}
