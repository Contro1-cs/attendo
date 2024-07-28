// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'income_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$IncomeModelImpl _$$IncomeModelImplFromJson(Map<String, dynamic> json) =>
    _$IncomeModelImpl(
      type: json['type'] as String? ?? "",
      amount: (json['amount'] as num?)?.toInt() ?? 0,
      label: json['label'] as String? ?? "",
    );

Map<String, dynamic> _$$IncomeModelImplToJson(_$IncomeModelImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'amount': instance.amount,
      'label': instance.label,
    };
