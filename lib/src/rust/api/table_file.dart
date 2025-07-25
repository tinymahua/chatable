// This file is automatically generated, so please do not edit it.
// @generated by `flutter_rust_bridge`@ 2.9.0.

// ignore_for_file: invalid_use_of_internal_member, unused_import, unnecessary_import

import '../frb_generated.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';

// These function are ignored because they are on traits that is not defined in current crate (put an empty `#[frb]` on it to unignore): `fmt`

Future<TableFileMeta> metaTableFile({required String path}) =>
    RustLib.instance.api.crateApiTableFileMetaTableFile(path: path);

Future<(List<String>, List<List<String>>)> statsFile({required String path}) =>
    RustLib.instance.api.crateApiTableFileStatsFile(path: path);

class TableFileMeta {
  final String path;
  final BigInt rowsCount;
  final BigInt size;
  final List<String> titles;

  const TableFileMeta({
    required this.path,
    required this.rowsCount,
    required this.size,
    required this.titles,
  });

  @override
  int get hashCode =>
      path.hashCode ^ rowsCount.hashCode ^ size.hashCode ^ titles.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TableFileMeta &&
          runtimeType == other.runtimeType &&
          path == other.path &&
          rowsCount == other.rowsCount &&
          size == other.size &&
          titles == other.titles;
}
