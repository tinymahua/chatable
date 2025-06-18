// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String hello(String userName) {
    return '你好， $userName。';
  }

  @override
  String get tableFileMetaRowsCount => '行数';

  @override
  String get tableFileMetaSize => '大小';

  @override
  String get tableFileMetaColumns => '包含列';

  @override
  String get tableDetailSummary => '摘要';

  @override
  String get tableDetailOperations => '操作记录';
}
