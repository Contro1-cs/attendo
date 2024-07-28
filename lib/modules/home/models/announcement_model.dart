import 'package:freezed_annotation/freezed_annotation.dart';

part 'announcement_model.freezed.dart';
part 'announcement_model.g.dart';

@freezed
abstract class AnnouncementModel with _$AnnouncementModel {
  const factory AnnouncementModel({
    @Default("") String title,
    @Default("") String dateTime,
    @Default("") String content,
  }) = _AnnouncementModel;

  factory AnnouncementModel.fromJson(Map<String, dynamic> json) =>
      _$AnnouncementModelFromJson(json);
}