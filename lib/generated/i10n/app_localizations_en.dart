// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String hello(String userName) {
    return 'Hello $userName.';
  }

  @override
  String get tableFileMetaRowsCount => 'Rows';

  @override
  String get tableFileMetaSize => 'Size';

  @override
  String get tableFileMetaColumns => 'Columns';

  @override
  String get tableColumnStatColIndex => 'Index';

  @override
  String get tableColumnStatColType => 'Type';

  @override
  String get tableColumnStatColName => 'Name';

  @override
  String get tableColumnStatColMin => 'Min';

  @override
  String get tableColumnStatColMax => 'Max';

  @override
  String get tableColumnStatColMinStr => 'Min(Str)';

  @override
  String get tableColumnStatColMaxStr => 'Max(Str)';

  @override
  String get tableColumnStatColMean => 'Mean';

  @override
  String get tableColumnStatColUnique => 'Unique';

  @override
  String get tableColumnStatColNull => 'Null';

  @override
  String get tableColumnStatColTotal => 'Sum';

  @override
  String get tableColumnStatColTypeInt => 'Number';

  @override
  String get tableColumnStatColTypeString => 'Text';

  @override
  String get tableColumnStatColTypeFloat => 'Decimal';

  @override
  String get tableColumnStatColTypeNull => 'Empty Value';

  @override
  String get tableDetailSummary => 'Summary';

  @override
  String get tableDetailOperations => 'Operate History';
}
