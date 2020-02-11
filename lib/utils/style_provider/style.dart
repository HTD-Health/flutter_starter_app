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
    @required this.secondaryAccent,
    @required this.content,
    @required this.secondaryContent,
    @required this.background,
    @required this.secondaryBackground,
    @required this.shadow,
    @required this.secondaryShadow,
  });

  final Color accent;
  final Color secondaryAccent;

  final Color content;
  final Color secondaryContent;

  final Color background;
  final Color secondaryBackground;

  final Color shadow;
  final Color secondaryShadow;

  /// Creates a copy of this [AppColors] but with the given
  /// fields replaced with the new values.
  AppColors copyWith(
    Color accent,
    Color secondaryAccent,
    Color content,
    Color secondaryContent,
    Color background,
    Color secondaryBackground,
    Color shadow,
    Color secondaryShadow,
  ) =>
      AppColors(
        accent: accent ?? this.accent,
        secondaryAccent: secondaryAccent ?? this.secondaryAccent,
        content: content ?? this.content,
        secondaryContent: secondaryContent ?? this.secondaryContent,
        background: background ?? this.background,
        secondaryBackground: secondaryBackground ?? this.secondaryBackground,
        shadow: shadow ?? this.shadow,
        secondaryShadow: secondaryShadow ?? this.secondaryShadow,
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
