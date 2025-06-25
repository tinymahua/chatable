// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_session_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatSessionItemRecord _$ChatSessionItemRecordFromJson(
  Map<String, dynamic> json,
) => ChatSessionItemRecord(
  name: json['name'] as String,
  filePath: json['file_path'] as String,
  tableFileType: $enumDecode(_$TableFileTypeEnumMap, json['table_file_type']),
  blake3Hash: json['blake3_hash'] as String,
);

Map<String, dynamic> _$ChatSessionItemRecordToJson(
  ChatSessionItemRecord instance,
) => <String, dynamic>{
  'name': instance.name,
  'file_path': instance.filePath,
  'table_file_type': _$TableFileTypeEnumMap[instance.tableFileType]!,
  'blake3_hash': instance.blake3Hash,
};

const _$TableFileTypeEnumMap = {
  TableFileType.unexpected: 'unexpected',
  TableFileType.csv: 'csv',
  TableFileType.xlsx: 'xlsx',
};
