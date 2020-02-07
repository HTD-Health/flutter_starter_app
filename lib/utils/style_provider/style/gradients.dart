part of '../style_provider.dart';

class _AppGradients {
  LinearGradient primary;

  _AppGradients(AppColors colors)
      : primary = LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colors.accent,
            colors.secondaryAccent,
          ],
        );
}
