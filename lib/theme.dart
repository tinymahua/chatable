import 'package:flutter/material.dart';

class ChatableColors extends ThemeExtension<ChatableColors> {
  static Color lightBorderColor = const Color(0xffe6e6e6);
  static Color darkBorderColor = const Color(0xff3b3b3b);

  final Color borderColor;

  ChatableColors({required this.borderColor});

  static ChatableColors get light {
    return ChatableColors(borderColor: lightBorderColor);
  }
  static ChatableColors get dark {
    return ChatableColors(borderColor: darkBorderColor);
  }

  @override
  ChatableColors copyWith({Color? withBorderColor}) {
    return ChatableColors(borderColor: withBorderColor ??  borderColor);
  }

  @override
  ChatableColors lerp(ThemeExtension<ChatableColors>? other, double t) {
    if (other is! ChatableColors) {
      return this;
    }
    return ChatableColors(
      borderColor: Color.lerp(borderColor, other.borderColor, t)?? borderColor,
    );
  }
}

class ChatableThemeData {
  static double dividerThickness = 6.0;
  static double iconSize = 21.0;

  static Color lightBorderColor = const Color(0xffe6e6e6);
  static Color lightSurfaceColor = const Color(0xffffffff);
  static Color lightOnSurfaceColor = Colors.black87;
  static Color lightCanvasColor = const Color(0xfff9f9f9);
  static Color lightOnCanvasColor = Colors.black26;
  static Color lightPrimaryColor = Colors.blueAccent[700]!;
  static Color lightOnPrimaryColor = Colors.white;
  static Color lightError = Colors.red;
  static Color lightOnError = Colors.white;
  static Brightness lightBrightness = Brightness.light;
  static Color lightToolIconColor = const Color(0xff878787);

  static Color darkBorderColor = const Color(0xff3b3b3b);
  static Color darkSurfaceColor = const Color(0xff262626);
  static Color darkOnSurfaceColor = Colors.white;
  static Color darkCanvasColor = const Color(0xff212121);
  static Color darkOnCanvasColor = Colors.white54;
  static Color darkPrimaryColor = Colors.blueAccent[700]!;
  static Color darkOnPrimaryColor = Colors.black;
  static Color darkError = Colors.red;
  static Color darkOnError = Colors.white;
  static Brightness darkBrightness = Brightness.dark;
  static Color darkToolIconColor = Colors.white60;

  static ThemeData get lightTheme {
    return ThemeData(
      fontFamily: 'NotoSansSC',
      appBarTheme: AppBarTheme(
        backgroundColor: lightCanvasColor,
        foregroundColor: lightOnCanvasColor,
        iconTheme: IconThemeData(color: lightToolIconColor, size: iconSize),
      ),
      bottomAppBarTheme: BottomAppBarTheme(
          color: lightCanvasColor
      ),
      dividerTheme: DividerThemeData(color: lightCanvasColor, thickness: dividerThickness),
      scaffoldBackgroundColor: lightSurfaceColor,
      colorScheme: ColorScheme(
        brightness: ChatableThemeData.lightBrightness,
        primary: ChatableThemeData.lightPrimaryColor,
        onPrimary: ChatableThemeData.lightOnPrimaryColor,
        secondary: ChatableThemeData.lightPrimaryColor,
        onSecondary: ChatableThemeData.lightOnPrimaryColor,
        error: ChatableThemeData.lightError,
        onError: ChatableThemeData.lightOnError,
        surface: ChatableThemeData.lightSurfaceColor,
        onSurface: lightOnSurfaceColor,
        surfaceContainer: lightSurfaceColor,
      ),
      extensions: <ThemeExtension<dynamic>>[
        ChatableColors.light,
      ],
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      fontFamily: 'NotoSansSC',
      appBarTheme: AppBarTheme(
        backgroundColor: darkCanvasColor,
        foregroundColor: darkOnCanvasColor,
        iconTheme: IconThemeData(color: darkToolIconColor, size: iconSize),
      ),
      bottomAppBarTheme: const BottomAppBarTheme(
        color: Color(0xff262626),
      ),
      dividerTheme: DividerThemeData(color: darkCanvasColor, thickness: dividerThickness),
      scaffoldBackgroundColor: darkSurfaceColor,
      colorScheme: ColorScheme(
        brightness: ChatableThemeData.darkBrightness,
        primary: ChatableThemeData.darkPrimaryColor,
        onPrimary: ChatableThemeData.darkOnPrimaryColor,
        secondary: ChatableThemeData.darkPrimaryColor,
        onSecondary: ChatableThemeData.darkOnPrimaryColor,
        error: ChatableThemeData.darkError,
        onError: ChatableThemeData.darkOnError,
        surface: ChatableThemeData.darkSurfaceColor,
        onSurface: darkOnSurfaceColor,
        surfaceContainer: darkSurfaceColor,
      ),
      extensions: <ThemeExtension<dynamic>>[
        ChatableColors.dark,
      ],
      // ...
    );
  }
}
