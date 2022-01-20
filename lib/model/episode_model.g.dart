// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'episode_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EpisodeModel _$EpisodeModelFromJson(Map<String, dynamic> json) => EpisodeModel(
      json['num'] as int,
      json['title'] as String,
      json['isShow'] as bool,
      json['chatUrl'] as String,
    );

Map<String, dynamic> _$EpisodeModelToJson(EpisodeModel instance) =>
    <String, dynamic>{
      'num': instance.num,
      'title': instance.title,
      'isShow': instance.isShow,
      'chatUrl': instance.chatUrl,
    };
