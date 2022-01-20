import 'package:json_annotation/json_annotation.dart';
//command :
//flutter pub run build_runner build
//flutter pub run build_runner watch
part 'section_model.g.dart';

@JsonSerializable()
class SectionModel {
  String title; //섹션 제목
  int num; // 순서
  bool isShow; // 노출 여부
  List<String> storys; // 스토리 아이디 목록

  SectionModel(this.title, this.num, this.isShow, this.storys); //constructor
  factory SectionModel.fromJson(Map<String, dynamic> json) =>
      _$SectionModelFromJson(json);
  Map<String, dynamic> toJson() => _$SectionModelToJson(this);

  static getDefaultModel() {   
    return SectionModel("",0, true, []);
  }
}
