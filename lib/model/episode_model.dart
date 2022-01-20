import 'package:json_annotation/json_annotation.dart';
//command :
//flutter pub run build_runner build
//flutter pub run build_runner watch
part 'episode_model.g.dart';

@JsonSerializable()
class EpisodeModel {
  int num; //번호
  String title; // 에피소드 제목
  bool isShow; // 노출 여부
  String chatUrl; // 챗봇 주소
  EpisodeModel(this.num, this.title, this.isShow, this.chatUrl); //constructor
  factory EpisodeModel.fromJson(Map<String, dynamic> json) =>
      _$EpisodeModelFromJson(json);
  Map<String, dynamic> toJson() => _$EpisodeModelToJson(this);
}
