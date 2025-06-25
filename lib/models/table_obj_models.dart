import 'dart:math';

import 'package:json_annotation/json_annotation.dart';

part 'table_obj_models.g.dart';

const String columnTypeInt = "int";
const String columnTypeFloat = "float";
const String columnTypeString = "string";
const String columnTypeNull = "null";

const List<String> numberAttrKeys = ["min", "max", "mean", "total"];

bool columnIsNumber(String columnType){
  return columnType == columnTypeInt || columnType == columnTypeFloat;
}

@JsonSerializable()
class TableColumn {
  final String name;
  final String columnType;
  final Map<String, dynamic> columnAttrs;
  final int colIndex;

  TableColumn({required this.name, required this.columnType, required this.columnAttrs, required this.colIndex});
  factory TableColumn.fromJson(Map<String, dynamic> json) => _$TableColumnFromJson(json);
  Map<String, dynamic> toJson() => _$TableColumnToJson(this);

  cleanAttrs(){
    var minV = columnAttrs['min'] as String;
    var maxV = columnAttrs['max'] as String;
    var totalV = columnAttrs['total'] as String;
    var meanV = columnAttrs['mean'] as String;
    var minScale = minV.contains('.')? minV.split('.').last.length : 0;
    var maxScale = maxV.contains('.')? maxV.split('.').last.length : 0;
    var totalScale = totalV.contains('.')? totalV.split('.').last.length : 0;
    var meanScale = meanV.contains('.')? meanV.split('.').last.length : 0;
    var setScale = max(minScale, maxScale);
    var newTotalV = totalV;
    var newMeanV = meanV;
    if (totalScale > setScale) {
      newTotalV = "${totalV.split('.')[0]}.${totalV.split('.')[1].substring(
          0, setScale)}";
    }
    if (meanScale > setScale) {
      newMeanV = "${meanV.split('.')[0]}.${meanV.split('.')[1].substring(0, setScale)}";
    }
    columnAttrs['total'] = newTotalV;
    columnAttrs['mean'] = newMeanV;
  }
}

@JsonSerializable()
class TableStats {
  final List<TableColumn> columns;
  final List<String> attrKeys;

  TableStats({required this.columns, required this.attrKeys});
  factory TableStats.fromJson(Map<String, dynamic> json) => _$TableStatsFromJson(json);
  factory TableStats.fromStatsInfo(List<String> fieldAttrs, List<List<String>> columnStatList) {
    List<TableColumn> columns = [];
    for (int i=0; i<columnStatList.length; i++){
      Map<String, dynamic> attrMap = {};
      for (var j=0; j<fieldAttrs.length; j++){
        attrMap[fieldAttrs[j]] = columnStatList[i][j];
      }
      columns.add(TableColumn(name: attrMap['name'], columnType: attrMap['col_type'], columnAttrs: attrMap, colIndex: i));
    }
    return TableStats(columns: columns, attrKeys: fieldAttrs);
  }
  Map<String, dynamic> toJson() => _$TableStatsToJson(this);

}