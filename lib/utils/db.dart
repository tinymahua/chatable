import 'dart:convert';
import 'dart:io';
import 'package:chatable/models/app_config_models.dart';
import 'package:chatable/models/appearance_config_model.dart';
import 'package:chatable/models/chat_session_models.dart';
import 'package:chatable/models/language_config_model.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';


abstract class Db {
  Db._(this.dbName);

  String dbName;

  Future<String> getDbPath() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    final docDir = await getApplicationDocumentsDirectory();
    var dbPath = p.join(docDir.path, packageInfo.appName, dbName);
    return dbPath;
  }

  Future<M> read<M>() async {
    var file = File(await getDbPath());

    if (!file.parent.existsSync()) {
      file.parent.createSync(recursive: true);
    }

    if (!file.existsSync()) {
      await initDb();
      file = File(await getDbPath());
    }

    var content = await file.readAsString();
    // print("Got content: ${content}");
    Map<String, dynamic> json = jsonDecode(content);
    return deserialize(json);
  }

  write<M>(M value) async {
    Map<String, dynamic> json = serialize(value);
    var file = File(await getDbPath());
    await file.writeAsString(jsonEncode(json));
  }

  // This method must be override
  Future<String> initDb() {
    throw UnimplementedError();
  }

  dynamic deserialize(Map<String, dynamic> json) {
    throw UnimplementedError();
  }

  dynamic serialize(dynamic value) {
    throw UnimplementedError();
  }
}

class AppConfigDb extends Db {
  static const String _dbName = 'app_config.json';

  AppConfigDb() : super._(_dbName);

  @override
  Future<String> initDb() async {
    var dbPath = await getDbPath();

    if (!File(dbPath).existsSync()) {
      await File(dbPath).create(recursive: true);

      write(AppConfig(
          preferences: PreferencesConfig(
            appearance: AppearanceConfig(themeMode: ThemeMode.light),
            language: LanguageConfig(languageCode: 'zh', countryCode: 'CN'),
          ),
      ));
    }
    return dbPath;
  }

  @override
  AppConfig deserialize(Map<String, dynamic> json) {
    return AppConfig.fromJson(json);
  }

  @override
  Map<String, dynamic> serialize(dynamic value) {
    return value.toJson();
  }
}


enum ChatSessionCreateStatus {
  success,
  exists,
}


class ChatSessionsDb extends Db {
  static const String _dbName = 'chat_sessions.json';

  ChatSessionsDb() : super._(_dbName);

  @override
  Future<String> initDb() async {
    var dbPath = await getDbPath();

    if (!File(dbPath).existsSync()) {
      await File(dbPath).create(recursive: true);
      write(ChatSessions(sessions: []));
    }
    return dbPath;
  }

  @override
  ChatSessions deserialize(Map<String, dynamic> json) {
    return ChatSessions.fromJson(json);
  }

  @override
  Map<String, dynamic> serialize(dynamic value) {
    return value.toJson();
  }

  Future<(ChatSessionItemRecord?, ChatSessionCreateStatus)> createSession(ChatSessionItemRecord record)async{
    var sessions = await read<ChatSessions>();
    if (sessions.sessions.indexWhere((e)=>e.filePath == record.filePath) > -1){
      return (null, ChatSessionCreateStatus.exists);
    }else{
      sessions.sessions.add(record);
      write(sessions);
      return (record, ChatSessionCreateStatus.success);
    }
  }
}