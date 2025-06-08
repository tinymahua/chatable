// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'language_config_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LanguageConfig _$LanguageConfigFromJson(Map<String, dynamic> json) =>
    LanguageConfig(
      languageCode: json['languageCode'] as String,
      countryCode: json['countryCode'] as String,
    );

Map<String, dynamic> _$LanguageConfigToJson(LanguageConfig instance) =>
    <String, dynamic>{
      'languageCode': instance.languageCode,
      'countryCode': instance.countryCode,
    };
