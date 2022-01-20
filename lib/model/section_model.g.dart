// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'section_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SectionModel _$SectionModelFromJson(Map<String, dynamic> json) => SectionModel(
      json['title'] as String,
      json['num'] as int,
      json['isShow'] as bool,
      (json['storys'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$SectionModelToJson(SectionModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'num': instance.num,
      'isShow': instance.isShow,
      'storys': instance.storys,
    };
