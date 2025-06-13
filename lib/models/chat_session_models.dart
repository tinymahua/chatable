import 'package:json_annotation/json_annotation.dart';
import 'package:path/path.dart' as p;
part 'chat_session_models.g.dart';

enum TableFileType {
  unexpected,
  csv,
  xlsx,
}

const List<String> tableFileTypes = ['csv', 'xlsx', 'xls'];
const List<String> excelFileExts = ['.xlsx', '.xls'];

@JsonSerializable()
class ChatSessionItemRecord  {
  String name;
  @JsonKey(name: 'file_path')
  String filePath;
  @JsonKey(name: 'table_file_type')
  TableFileType  tableFileType;
  @JsonKey(name: 'blake3_hash')
  String blake3Hash;

  ChatSessionItemRecord({
    required this.name,
    required this.filePath,
    required this.tableFileType,
    required this.blake3Hash,
  });

  factory ChatSessionItemRecord.fromJson(Map<String, dynamic> json) => _$ChatSessionItemRecordFromJson(json);
  Map<String, dynamic> toJson() => _$ChatSessionItemRecordToJson(this);

  factory ChatSessionItemRecord.fromFilePath(String filePath){
    var name = p.basename(filePath);
    var ext = p.extension(filePath);
    ext = ext.toLowerCase();
    TableFileType tableFileType;
    if (ext == '.csv'){
      tableFileType = TableFileType.csv;
    }else if (excelFileExts.contains(ext) ){
      tableFileType = TableFileType.xlsx;
    }else{
      tableFileType = TableFileType.unexpected;
    }
    return ChatSessionItemRecord(
      name: name,
      filePath: filePath,
      tableFileType: tableFileType,
      blake3Hash: 'TODO',
    );
  }
}



class ChatSessions {
  List<ChatSessionItemRecord> sessions;

  ChatSessions({
    required this.sessions,
  });

  factory ChatSessions.fromJson(Map<String, dynamic> json) {
    var sessions = json['sessions'] as List;
    return ChatSessions(
      sessions: sessions.map((e) => ChatSessionItemRecord.fromJson(e)).toList(),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'sessions': sessions.map((e) => e.toJson()).toList(),
    };
  }
}