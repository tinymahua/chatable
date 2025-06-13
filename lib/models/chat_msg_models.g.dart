// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_msg_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatMsgPartialFile _$ChatMsgPartialFileFromJson(Map<String, dynamic> json) =>
    ChatMsgPartialFile(
      name: json['name'] as String,
      path: json['path'] as String,
    );

Map<String, dynamic> _$ChatMsgPartialFileToJson(ChatMsgPartialFile instance) =>
    <String, dynamic>{'name': instance.name, 'path': instance.path};

ChatMsgPartialText _$ChatMsgPartialTextFromJson(Map<String, dynamic> json) =>
    ChatMsgPartialText(text: json['text'] as String);

Map<String, dynamic> _$ChatMsgPartialTextToJson(ChatMsgPartialText instance) =>
    <String, dynamic>{'text': instance.text};

ChatMsgRecord _$ChatMsgRecordFromJson(Map<String, dynamic> json) =>
    ChatMsgRecord(
      id: json['id'] as String,
      files:
          (json['files'] as List<dynamic>)
              .map(
                (e) => ChatMsgPartialFile.fromJson(e as Map<String, dynamic>),
              )
              .toList(),
      text: ChatMsgPartialText.fromJson(json['text'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ChatMsgRecordToJson(ChatMsgRecord instance) =>
    <String, dynamic>{
      'id': instance.id,
      'files': instance.files,
      'text': instance.text,
    };
