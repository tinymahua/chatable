import 'package:fluent_ui/fluent_ui.dart';
import 'package:json_annotation/json_annotation.dart';

part 'appearance_config_model.g.dart';

@JsonSerializable()
class AppearanceConfig {

  @JsonKey(name: 'theme_mode')
  ThemeMode themeMode;

  AppearanceConfig({
    this.themeMode = ThemeMode.light,
  });

  factory AppearanceConfig.fromJson(Map<String, dynamic> json) => _$AppearanceConfigFromJson(json);

  Map<String, dynamic> toJson() => _$AppearanceConfigToJson(this);

}