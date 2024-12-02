
import 'package:flutter/material.dart';

class AppColor extends ThemeExtension<AppColor> {
  final Color primaryColor;
  final Color onPrimaryColor;

  final Color secondaryColor;
  final Color onSecondaryColor;

  final Color primaryBackgroundColor;
  final Color onPrimaryBackgroundColor;

  final Color secondaryBackgroundColor;
  final Color onSecondaryBackgroundColor;

  final Color tertiaryBackgroundColor;
  final Color onTertiaryBackgroundColor;

  AppColor({
    required this.primaryColor,
    required this.onPrimaryColor,
    required this.secondaryColor,
    required this.onSecondaryColor,
    required this.primaryBackgroundColor,
    required this.onPrimaryBackgroundColor,
    required this.secondaryBackgroundColor,
    required this.onSecondaryBackgroundColor,
    required this.tertiaryBackgroundColor,
    required this.onTertiaryBackgroundColor,
  });

  @override
  ThemeExtension<AppColor> copyWith({
    Color? primaryColor,
    Color? onPrimaryColor,
    Color? secondaryColor,
    Color? onSecondaryColor,
    Color? primaryBackgroundColor,
    Color? onPrimaryBackgroundColor,
    Color? secondaryBackgroundColor,
    Color? onSecondaryBackgroundColor,
    Color? tertiaryBackgroundColor,
    Color? onTertiaryBackgroundColor,
  }) {
    return AppColor(
      primaryColor: primaryColor ?? this.primaryColor,
      onPrimaryColor: onPrimaryColor ?? this.onPrimaryColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      onSecondaryColor: onSecondaryColor ?? this.onSecondaryColor,
      primaryBackgroundColor: primaryBackgroundColor ?? this.primaryBackgroundColor,
      onPrimaryBackgroundColor: onPrimaryBackgroundColor ?? this.onPrimaryBackgroundColor,
      secondaryBackgroundColor: secondaryBackgroundColor ?? this.secondaryBackgroundColor,
      onSecondaryBackgroundColor: onSecondaryBackgroundColor ?? this.onSecondaryBackgroundColor,
      tertiaryBackgroundColor: tertiaryBackgroundColor ?? this.tertiaryBackgroundColor,
      onTertiaryBackgroundColor: onTertiaryBackgroundColor ?? this.onTertiaryBackgroundColor,
    );
  }

  @override
  ThemeExtension<AppColor> lerp(covariant ThemeExtension<AppColor>? other, double t) {
    if (other == null) return this;
    if (other is! AppColor) return this;
    return AppColor(
      primaryColor: Color.lerp(primaryColor, other.primaryColor, t)!,
      onPrimaryColor: Color.lerp(onPrimaryColor, other.onPrimaryColor, t)!,
      secondaryColor: Color.lerp(secondaryColor, other.secondaryColor, t)!,
      onSecondaryColor: Color.lerp(onSecondaryColor, other.onSecondaryColor, t)!,
      primaryBackgroundColor: Color.lerp(primaryBackgroundColor, other.primaryBackgroundColor, t)!,
      onPrimaryBackgroundColor: Color.lerp(onPrimaryBackgroundColor, other.onPrimaryBackgroundColor, t)!,
      secondaryBackgroundColor: Color.lerp(secondaryBackgroundColor, other.secondaryBackgroundColor, t)!,
      onSecondaryBackgroundColor: Color.lerp(onSecondaryBackgroundColor, other.onSecondaryBackgroundColor, t)!,
      tertiaryBackgroundColor: Color.lerp(tertiaryBackgroundColor, other.tertiaryBackgroundColor, t)!,
      onTertiaryBackgroundColor: Color.lerp(onTertiaryBackgroundColor, other.onTertiaryBackgroundColor, t)!,
    );
  }
}