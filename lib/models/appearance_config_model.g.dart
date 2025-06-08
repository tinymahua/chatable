// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appearance_config_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppearanceConfig _$AppearanceConfigFromJson(Map<String, dynamic> json) =>
    AppearanceConfig(
      themeMode:
          $enumDecodeNullable(_$ThemeModeEnumMap, json['theme_mode']) ??
          ThemeMode.light,
    );

Map<String, dynamic> _$AppearanceConfigToJson(AppearanceConfig instance) =>
    <String, dynamic>{'theme_mode': _$ThemeModeEnumMap[instance.themeMode]!};

const _$ThemeModeEnumMap = {
  ThemeMode.system: 'system',
  ThemeMode.light: 'light',
  ThemeMode.dark: 'dark',
};
