import 'package:flutter/material.dart';

class ThemeChangedEvent{
  ThemeMode themeMode;
  ThemeChangedEvent(this.themeMode);
}

class InitThemeEvent {
  ThemeMode themeMode;
  InitThemeEvent(this.themeMode);
}