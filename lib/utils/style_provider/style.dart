import 'package:flutter/material.dart';

part './style/shadows.dart';
part './style/borders.dart';
part './style/fonts.dart';
part './style/gradients.dart';
part './style/assets.dart';

/// Provides colors that are used to create app style by style provider
class AppColors {
  const AppColors({
    @required this.accent,
    @required this.accent2,
    @required this.content,
    @required this.content2,
    @required this.background,
    @required this.background2,
    @required this.shadow,
    @required this.shadow2,
  });

  final Color accent;
  final Color accent2;

  final Color content;
  final Color content2;

  final Color background;
  final Color background2;

  final Color shadow;
  final Color shadow2;

  /// Create [MaterialColor] from color
  MaterialColor getMaterialColorFrom(Color color) =>
      MaterialColor(color.value, {
        50: accent,
        for (int i = 100; i <= 900; i += 100) i: accent,
      });

  /// Create primary swatch color based on accent color
  MaterialColor get primarySwatch => getMaterialColorFrom(accent);

  /// Creates a copy of this [AppColors] but with the given
  /// fields replaced with the new values.
  AppColors copyWith(
    Color accent,
    Color accent2,
    Color content,
    Color content2,
    Color background,
    Color backgrond2,
    Color shadow,
    Color shadow2,
  ) =>
      AppColors(
        accent: accent ?? this.accent,
        accent2: accent2 ?? this.accent2,
        content: content ?? this.content,
        content2: content2 ?? this.content2,
        background: background ?? this.background,
        background2: backgrond2 ?? this.background2,
        shadow: shadow ?? this.shadow,
        shadow2: shadow2 ?? this.shadow2,
      );
}

/// Provides app style
class Style extends InheritedWidget {
  /// Keeps app colors
  final AppColors colors;

  /// Keeps assets names wich can be used like:
  /// ```dart
  ///  Image.asset(
  ///     StyleProvider.of(context).asset.facebookLogo,
  ///  );
  /// ```
  final _AppAssets asset;

  /// Keeps app gradients
  final _AppGradients gradient;

  /// Keeps app shadows
  final _AppShadows shadow;

  /// Keeps app borders
  final _AppBorders border;

  /// Keeps app fonts
  final _AppFonts font;

  Style({
    Widget child,
    @required this.colors,
  })  : gradient = _AppGradients(colors),
        border = _AppBorders(colors),
        font = _AppFonts(colors),
        shadow = _AppShadows(colors),
        asset = _AppAssets(),
        super(child: child);

  /// Always returns false because this InheritedWidget is not mutable
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;

  static Style of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<Style>();
}
