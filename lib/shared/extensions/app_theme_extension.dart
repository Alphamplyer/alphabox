
import 'package:alphabox/shared/configs/app_color.dart';
import 'package:alphabox/shared/configs/app_theme.dart';
import 'package:flutter/material.dart';

extension AppThemeExtension on ThemeData {
  AppColor get appColors => extension<AppColor>() ?? AppTheme.darkAppColors;
}