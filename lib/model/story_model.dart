import 'package:json_annotation/json_annotation.dart';

import 'package:tappik/model/episode_model.dart';
//command :
//flutter pub run build_runner build
//flutter pub run build_runner watch
part 'story_model.g.dart';

@JsonSerializable()
class StoryModel {
  String id; // id
  int num; // 순서 번호
  String title; //스토리 제목
  bool isShow; // 노출 여부
  List<EpisodeModel> episodes; // 에피소드목록
  String description; // 설명
  String cast; //출연진
  String category; //카테고리
  String difficulty; //난이도
  List<String> hashTag; // 해시 태그
  String urlThumbnail; // 썸네일 주소
  String urlPoster; // 포스터 주소
  StoryModel(
    this.id,
    this.num,
    this.title,
    this.isShow,
    this.episodes,
    this.description,
    this.cast,
    this.category,
    this.difficulty,
    this.hashTag,
    this.urlThumbnail,
    this.urlPoster,
  );
  //constructor
  factory StoryModel.fromJson(Map<String, dynamic> json) =>
      _$StoryModelFromJson(json);
  Map<String, dynamic> toJson() => _$StoryModelToJson(this);

  static getDefaultModel() {
    return StoryModel("", 0, "", true, [], "", "", "", "", [], "", "");
  }
}
