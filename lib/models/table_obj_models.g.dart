// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'table_obj_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TableColumn _$TableColumnFromJson(Map<String, dynamic> json) => TableColumn(
  name: json['name'] as String,
  columnType: json['columnType'] as String,
  columnAttrs: json['columnAttrs'] as Map<String, dynamic>,
  colIndex: (json['colIndex'] as num).toInt(),
);

Map<String, dynamic> _$TableColumnToJson(TableColumn instance) =>
    <String, dynamic>{
      'name': instance.name,
      'columnType': instance.columnType,
      'columnAttrs': instance.columnAttrs,
      'colIndex': instance.colIndex,
    };

TableStats _$TableStatsFromJson(Map<String, dynamic> json) => TableStats(
  columns:
      (json['columns'] as List<dynamic>)
          .map((e) => TableColumn.fromJson(e as Map<String, dynamic>))
          .toList(),
  attrKeys:
      (json['attrKeys'] as List<dynamic>).map((e) => e as String).toList(),
);

Map<String, dynamic> _$TableStatsToJson(TableStats instance) =>
    <String, dynamic>{
      'columns': instance.columns,
      'attrKeys': instance.attrKeys,
    };
