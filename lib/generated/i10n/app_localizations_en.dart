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
  String get tableDetailSummary => 'Summary';

  @override
  String get tableDetailOperations => 'Operate History';
}
