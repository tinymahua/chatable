import 'dart:async';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

Future<String> getAppTempDir()async{
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  var sysTempDir = await getTemporaryDirectory();
  return p.join(sysTempDir.path, packageInfo.packageName,);
}

Future<String> getAppDocDir()async{
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  var sysDocDir = await getApplicationDocumentsDirectory();
  return p.join(sysDocDir.path, packageInfo.packageName,);
}

