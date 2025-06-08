// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_config_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PreferencesConfig _$PreferencesConfigFromJson(Map<String, dynamic> json) =>
    PreferencesConfig(
      appearance: AppearanceConfig.fromJson(
        json['appearance'] as Map<String, dynamic>,
      ),
      language: LanguageConfig.fromJson(
        json['language'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$PreferencesConfigToJson(PreferencesConfig instance) =>
    <String, dynamic>{
      'appearance': instance.appearance,
      'language': instance.language,
    };

AppConfig _$AppConfigFromJson(Map<String, dynamic> json) => AppConfig(
  preferences: PreferencesConfig.fromJson(
    json['preferences'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$AppConfigToJson(AppConfig instance) => <String, dynamic>{
  'preferences': instance.preferences,
};
