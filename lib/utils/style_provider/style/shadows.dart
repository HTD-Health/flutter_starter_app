part of '../style.dart';

class _AppShadows {
  final BoxShadow shadow;
  final BoxShadow shadow2;
  _AppShadows(AppColors colors)
      : shadow = BoxShadow(
          color: colors.shadow,
          offset: const Offset(0, 0),
          blurRadius: 5,
        ),
        shadow2 = BoxShadow(
          color: colors.shadow2,
          offset: const Offset(0, 0),
          blurRadius: 5,
        );
}
