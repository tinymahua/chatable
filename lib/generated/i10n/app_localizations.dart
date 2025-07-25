import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'i10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('zh')
  ];

  /// A message with a single parameter
  ///
  /// In en, this message translates to:
  /// **'Hello {userName}.'**
  String hello(String userName);

  /// No description provided for @tableFileMetaRowsCount.
  ///
  /// In en, this message translates to:
  /// **'Rows'**
  String get tableFileMetaRowsCount;

  /// No description provided for @tableFileMetaSize.
  ///
  /// In en, this message translates to:
  /// **'Size'**
  String get tableFileMetaSize;

  /// No description provided for @tableFileMetaColumns.
  ///
  /// In en, this message translates to:
  /// **'Columns'**
  String get tableFileMetaColumns;

  /// No description provided for @tableColumnStatColIndex.
  ///
  /// In en, this message translates to:
  /// **'Index'**
  String get tableColumnStatColIndex;

  /// No description provided for @tableColumnStatColType.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get tableColumnStatColType;

  /// No description provided for @tableColumnStatColName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get tableColumnStatColName;

  /// No description provided for @tableColumnStatColMin.
  ///
  /// In en, this message translates to:
  /// **'Min'**
  String get tableColumnStatColMin;

  /// No description provided for @tableColumnStatColMax.
  ///
  /// In en, this message translates to:
  /// **'Max'**
  String get tableColumnStatColMax;

  /// No description provided for @tableColumnStatColMinStr.
  ///
  /// In en, this message translates to:
  /// **'Min(Str)'**
  String get tableColumnStatColMinStr;

  /// No description provided for @tableColumnStatColMaxStr.
  ///
  /// In en, this message translates to:
  /// **'Max(Str)'**
  String get tableColumnStatColMaxStr;

  /// No description provided for @tableColumnStatColMean.
  ///
  /// In en, this message translates to:
  /// **'Mean'**
  String get tableColumnStatColMean;

  /// No description provided for @tableColumnStatColUnique.
  ///
  /// In en, this message translates to:
  /// **'Unique'**
  String get tableColumnStatColUnique;

  /// No description provided for @tableColumnStatColNull.
  ///
  /// In en, this message translates to:
  /// **'Null'**
  String get tableColumnStatColNull;

  /// No description provided for @tableColumnStatColTotal.
  ///
  /// In en, this message translates to:
  /// **'Sum'**
  String get tableColumnStatColTotal;

  /// No description provided for @tableColumnStatColTypeInt.
  ///
  /// In en, this message translates to:
  /// **'Number'**
  String get tableColumnStatColTypeInt;

  /// No description provided for @tableColumnStatColTypeString.
  ///
  /// In en, this message translates to:
  /// **'Text'**
  String get tableColumnStatColTypeString;

  /// No description provided for @tableColumnStatColTypeFloat.
  ///
  /// In en, this message translates to:
  /// **'Decimal'**
  String get tableColumnStatColTypeFloat;

  /// No description provided for @tableColumnStatColTypeNull.
  ///
  /// In en, this message translates to:
  /// **'Empty Value'**
  String get tableColumnStatColTypeNull;

  /// No description provided for @tableDetailSummary.
  ///
  /// In en, this message translates to:
  /// **'Summary'**
  String get tableDetailSummary;

  /// No description provided for @tableDetailOperations.
  ///
  /// In en, this message translates to:
  /// **'Operate History'**
  String get tableDetailOperations;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'zh': return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
