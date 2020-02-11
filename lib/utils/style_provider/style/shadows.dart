part of '../style.dart';

class _AppShadows {
  final BoxShadow shadow;
  final BoxShadow secondaryShadow;
  _AppShadows(AppColors colors)
      : shadow = BoxShadow(
          color: colors.shadow,
          offset: const Offset(0, 0),
          blurRadius: 5,
        ),
        secondaryShadow = BoxShadow(
          color: colors.secondaryShadow,
          offset: const Offset(0, 0),
          blurRadius: 5,
        );
}
