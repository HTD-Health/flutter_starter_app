part of '../style.dart';

class _AppFonts {
  final TextStyle thin;
  final TextStyle light;
  final TextStyle normal;
  final TextStyle bold;

  _AppFonts(AppColors colors)
      : thin = TextStyle(
          color: colors.content,
          fontWeight: FontWeight.w100,
          fontSize: 14,
        ),
        light = TextStyle(
          color: colors.content,
          fontWeight: FontWeight.w300,
          fontSize: 14,
        ),
        normal = TextStyle(
          color: colors.content,
          fontWeight: FontWeight.normal,
          fontSize: 14,
        ),
        bold = TextStyle(
          color: colors.content,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        );
}
