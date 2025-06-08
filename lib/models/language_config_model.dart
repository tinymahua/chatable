import 'package:json_annotation/json_annotation.dart';

part 'language_config_model.g.dart';

@JsonSerializable()
class LanguageConfig {

  String languageCode;
  String countryCode;

  LanguageConfig({required this.languageCode, required this.countryCode});

  factory LanguageConfig.fromJson(Map<String, dynamic> json) => _$LanguageConfigFromJson(json);

  Map<String, dynamic> toJson() => _$LanguageConfigToJson(this);
}
