// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoryModel _$StoryModelFromJson(Map<String, dynamic> json) => StoryModel(
      json['id'] as String,
      json['num'] as int,
      json['title'] as String,
      json['isShow'] as bool,
      (json['episodes'] as List<dynamic>)
          .map((e) => EpisodeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['description'] as String,
      json['cast'] as String,
      json['category'] as String,
      json['difficulty'] as String,
      (json['hashTag'] as List<dynamic>).map((e) => e as String).toList(),
      json['urlThumbnail'] as String,
      json['urlPoster'] as String,
    );

Map<String, dynamic> _$StoryModelToJson(StoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'num': instance.num,
      'title': instance.title,
      'isShow': instance.isShow,
      'episodes': instance.episodes,
      'description': instance.description,
      'cast': instance.cast,
      'category': instance.category,
      'difficulty': instance.difficulty,
      'hashTag': instance.hashTag,
      'urlThumbnail': instance.urlThumbnail,
      'urlPoster': instance.urlPoster,
    };
