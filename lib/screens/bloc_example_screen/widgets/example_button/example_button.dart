import 'package:flutter/material.dart';
import 'package:flutter_starter_app/utils/style_provider/style.dart';
import 'package:provider/provider.dart';

class ExampleButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color color;
  final String label;

  const ExampleButton({
    required this.onPressed,
    required this.color,
    required this.label,
  });

  Color get fontColor =>
      (color.red * 0.299 + color.green * 0.587 + color.blue * 0.114) > 186
          ? Colors.black
          : Colors.white;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      child: Container(
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          border: context.watch<Style>().borders.box.primary,
        ),
        child: Text(
          label,
          style: context.watch<Style>().fonts.normal.copyWith(color: fontColor),
        ),
      ),
    );
  }
}
