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
  String get tableColumnStatColIndex => '列编号';

  @override
  String get tableColumnStatColType => '类型';

  @override
  String get tableColumnStatColName => '列名';

  @override
  String get tableColumnStatColMin => '最小值';

  @override
  String get tableColumnStatColMax => '最大值';

  @override
  String get tableColumnStatColMinStr => '最小值(Str)';

  @override
  String get tableColumnStatColMaxStr => '最大值(Str)';

  @override
  String get tableColumnStatColMean => '平均值';

  @override
  String get tableColumnStatColUnique => '不重复值';

  @override
  String get tableColumnStatColNull => '空值';

  @override
  String get tableColumnStatColTotal => '总和';

  @override
  String get tableColumnStatColTypeInt => '数值';

  @override
  String get tableColumnStatColTypeString => '文本';

  @override
  String get tableColumnStatColTypeFloat => '浮点数';

  @override
  String get tableColumnStatColTypeNull => '空值';

  @override
  String get tableDetailSummary => '摘要';

  @override
  String get tableDetailOperations => '操作记录';
}
