import 'package:chatable/events/events.dart';
import 'package:chatable/events/ui_events.dart';
import 'package:chatable/models/app_config_models.dart';
import 'package:chatable/models/language_config_model.dart';
import 'package:chatable/pages/home_page.dart';
import 'package:chatable/theme.dart';
import 'package:chatable/utils/db.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:window_manager/window_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluent_ui/fluent_ui.dart' as fui;

class ChatableApp extends StatefulWidget {
  const ChatableApp({super.key});

  @override
  State<ChatableApp> createState() => _ChatableAppState();
}

class _ChatableAppState extends State<ChatableApp> {
  ThemeMode themeMode = ThemeMode.dark;
  AppConfigDb appConfigDb = Get.find<AppConfigDb>();
  LanguageConfig? languageConfig;

@override
  void initState() {
    super.initState();
    setupEvents();
  }

  setupEvents()async{
    var appConfig = await appConfigDb.read<AppConfig>();
    setState(() {
      themeMode = appConfig.preferences.appearance.themeMode;
      languageConfig = appConfig.preferences.language;
    });

    eventBus.fire(InitThemeEvent(appConfig.preferences.appearance.themeMode));

    eventBus.on<ThemeChangedEvent>().listen((evt)async{
      setState(() {
        themeMode = evt.themeMode;
      });
      appConfig.preferences.appearance.themeMode = evt.themeMode;
      await appConfigDb.write(appConfig);
    });
  }

  @override
  Widget build(BuildContext context) {
    // 创建window_manager的窗口管理器组件，替代Flutter默认Scaffold窗口组件
    final virtualWindowFrameBuilder = VirtualWindowFrameInit();

    List<LocalizationsDelegate<dynamic>> localizationsDelegates = [];
    localizationsDelegates.addAll(AppLocalizations.localizationsDelegates);
    localizationsDelegates.addAll(fui.FluentLocalizations.localizationsDelegates);

    List<Locale> supportedLocales = [];
    supportedLocales.addAll(AppLocalizations.supportedLocales);
    supportedLocales.addAll(fui.FluentLocalizations.supportedLocales);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: languageConfig != null ? Locale(languageConfig!.languageCode, languageConfig!.countryCode) :const Locale('en', 'US'),
      localizationsDelegates: localizationsDelegates,
      supportedLocales: supportedLocales,
      theme: ChatableThemeData.lightTheme,
      darkTheme: ChatableThemeData.darkTheme,
      themeMode: themeMode,
      builder: (context, child) => virtualWindowFrameBuilder(context, child),
      home: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onPanStart: (details)async {
          if (!await windowManager.isMaximized()){
            windowManager.startDragging();
          }
        },
        child: HomePage(),
      ),
    );
  }
}
