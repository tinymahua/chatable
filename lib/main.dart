import 'package:chatable/app.dart';
import 'package:chatable/utils/db.dart';
import 'package:flutter/material.dart';
import 'package:chatable/src/rust/frb_generated.dart';
import 'package:get/get.dart';
import 'package:window_manager/window_manager.dart';

initGetxInstances(){
  Get.put(AppConfigDb());
  Get.put(ChatSessionsDb());
}

Future<void> main() async {
  await RustLib.init();

  WidgetsFlutterBinding.ensureInitialized();

  // 初始化windowManager插件功能
  await windowManager.ensureInitialized();

  // windows_manager接管窗口渲染参数，可以按需要参照文档调整
  WindowOptions windowOptions = const WindowOptions(
    center: false,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.hidden,
    windowButtonVisibility: false,
  );

  // 窗口显示之前将上边的显示参数应用到组件
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.setAsFrameless();
  });

  initGetxInstances();

  runApp(ChatableApp());
}
