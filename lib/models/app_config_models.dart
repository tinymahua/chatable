import 'package:chatable/models/appearance_config_model.dart';
import 'package:chatable/models/language_config_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'app_config_models.g.dart';

@JsonSerializable()
class PreferencesConfig {

  AppearanceConfig appearance;
  LanguageConfig language;

  PreferencesConfig({required this.appearance, required this.language});

  factory PreferencesConfig.fromJson(Map<String, dynamic> json) => _$PreferencesConfigFromJson(json);

  Map<String, dynamic> toJson() => _$PreferencesConfigToJson(this);
}


@JsonSerializable()
class AppConfig {
  PreferencesConfig preferences;

  AppConfig({
    required this.preferences,
  });

  factory AppConfig.fromJson(Map<String, dynamic> json) => _$AppConfigFromJson(json);

  Map<String, dynamic> toJson() => _$AppConfigToJson(this);
}