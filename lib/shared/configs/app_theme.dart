
import 'package:alphabox/shared/configs/app_color.dart';
import 'package:flutter/material.dart';

class AppTheme with ChangeNotifier {
  static AppColor get lightAppColors => _lightAppColors;
  static AppColor get darkAppColors => _darkAppColors;

  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;

  void setThemeMode(ThemeMode themeMode) {
    _themeMode = themeMode;
    notifyListeners();
  }

  static ThemeData get dark {
    return updateMaterialTheme(ThemeData.dark(useMaterial3: true), _darkAppColors);
  }

  static final _darkAppColors = AppColor(
    primaryColor: const Color(0xFF9290C3),
    onPrimaryColor: const Color(0xFF070F2B),
    secondaryColor: const Color(0xFF535C91),
    onSecondaryColor: const Color(0xFF070F2B),
    primaryBackgroundColor: const Color(0xFF070F2B),
    onPrimaryBackgroundColor: const Color(0xFFBBBADA),
    secondaryBackgroundColor: const Color(0xFF1B1A55),
    onSecondaryBackgroundColor: const Color(0xFFB9B8E1),
    tertiaryBackgroundColor: const Color(0xFF3C4178),
    onTertiaryBackgroundColor: const Color(0xFFB9B8E1),
  );

  static ThemeData get light {
    return updateMaterialTheme(ThemeData.light(useMaterial3: true), _lightAppColors);
  }

  static final _lightAppColors = AppColor(
    primaryColor: const Color(0xFF9290C3),
    onPrimaryColor: const Color(0xFF070F2B),
    secondaryColor: const Color(0xFF535C91),
    onSecondaryColor: const Color(0xFF070F2B),
    primaryBackgroundColor: const Color(0xFF070F2B),
    onPrimaryBackgroundColor: const Color(0xFFBBBADA),
    secondaryBackgroundColor: const Color(0xFF1B1A55),
    onSecondaryBackgroundColor: const Color(0xFFB9B8E1),
    tertiaryBackgroundColor: const Color(0xFF3C4178),
    onTertiaryBackgroundColor: const Color(0xFFB9B8E1),
  );

  static ThemeData updateMaterialTheme(ThemeData materialTheme, AppColor appColors) {
    return materialTheme.copyWith(
      scaffoldBackgroundColor: appColors.primaryBackgroundColor,
      appBarTheme: AppBarTheme(
        backgroundColor: appColors.secondaryBackgroundColor,
        foregroundColor: appColors.onSecondaryBackgroundColor,
      ),
      extensions: [
        appColors,
      ]
    );
  }
}