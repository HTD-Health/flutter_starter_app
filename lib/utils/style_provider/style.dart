import 'package:flutter/material.dart';

part './style/shadows.dart';
part './style/borders.dart';
part './style/fonts.dart';
part './style/assets.dart';
part './style/colors.dart';

/// Provides app style
class Style {
  /// Keeps app colors
  final AppColors colors;

  /// Keeps assets names wich can be used like:
  /// ```dart
  ///  Image.asset(
  ///     context.watch<Style>.assets.facebookLogo,
  ///  );
  /// ```
  final _AppAssets assets;

  /// Keeps app shadows
  final _AppShadows shadows;

  /// Keeps app borders
  final _AppBorders borders;

  /// Keeps app fonts
  final _AppFonts fonts;

  Style({
    required this.colors,
  })  : borders = _AppBorders(colors),
        fonts = _AppFonts(colors),
        shadows = _AppShadows(colors),
        assets = _AppAssets();
}
