import 'package:freezed_annotation/freezed_annotation.dart';

part 'income_model.freezed.dart';
part 'income_model.g.dart';

@freezed
abstract class IncomeModel with _$IncomeModel {
  const factory IncomeModel({
    @Default("") String type,
    @Default(0) int amount,
    @Default("") String label,
  }) = _IncomeModel;

  factory IncomeModel.fromJson(Map<String, dynamic> json) =>
      _$IncomeModelFromJson(json);
}