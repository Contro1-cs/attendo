// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'announcement_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AnnouncementModelImpl _$$AnnouncementModelImplFromJson(
        Map<String, dynamic> json) =>
    _$AnnouncementModelImpl(
      title: json['title'] as String? ?? "",
      dateTime: json['dateTime'] as String? ?? "",
      content: json['content'] as String? ?? "",
    );

Map<String, dynamic> _$$AnnouncementModelImplToJson(
        _$AnnouncementModelImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'dateTime': instance.dateTime,
      'content': instance.content,
    };
