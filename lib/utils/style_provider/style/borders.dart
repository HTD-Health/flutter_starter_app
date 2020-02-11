part of '../style.dart';

class _AppBorders {
  final _AppInputBorders input;
  final _AppBoxBorders box;
  _AppBorders(AppColors colors)
      : input = _AppInputBorders(colors),
        box = _AppBoxBorders(colors);
}

class _AppInputBorders {
  final InputBorder primary;
  final InputBorder noBorder;
  _AppInputBorders(AppColors colors)
      : primary = OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: colors.content,
            width: 1,
          ),
        ),
        noBorder = const OutlineInputBorder(
          borderSide: BorderSide.none,
        );
}

class _AppBoxBorders {
  final BoxBorder primary;
  _AppBoxBorders(AppColors colors)
      : primary = Border.all(
          color: colors.content,
          width: 1,
        );
}
