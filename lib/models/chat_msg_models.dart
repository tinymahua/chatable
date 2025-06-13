import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'chat_msg_models.g.dart';


@JsonSerializable()
class ChatMsgPartialFile {
  String name;
  String path;

  ChatMsgPartialFile({
    required this.name,
    required this.path,
  });

  factory ChatMsgPartialFile.fromJson(Map<String, dynamic> json) => _$ChatMsgPartialFileFromJson(json);
  Map<String, dynamic> toJson() => _$ChatMsgPartialFileToJson(this);
}


@JsonSerializable()
class ChatMsgPartialText {
  String text;

  ChatMsgPartialText({
    required this.text,
  });

  factory ChatMsgPartialText.fromJson(Map<String, dynamic> json) => _$ChatMsgPartialTextFromJson(json);
  Map<String, dynamic> toJson() => _$ChatMsgPartialTextToJson(this);

  factory ChatMsgPartialText.getDefault(){
    return ChatMsgPartialText(text: '');
  }

  bool get isEmpty{
    return text.isEmpty;
  }
}

@JsonSerializable()
class ChatMsgRecord {
  String id;
  List<ChatMsgPartialFile> files;
  ChatMsgPartialText text;

  ChatMsgRecord({
    required this.id,
    required this.files,
    required this.text,
  });

  factory ChatMsgRecord.fromJson(Map<String, dynamic> json) => _$ChatMsgRecordFromJson(json);
  Map<String, dynamic> toJson() => _$ChatMsgRecordToJson(this);

  bool get isEmpty{
    return files.isEmpty && text.isEmpty;
  }

  factory ChatMsgRecord.getDefault() {
    return ChatMsgRecord(
      id: const Uuid().v4(),
      files: [],
      text: ChatMsgPartialText.getDefault(),
    );
  }
}