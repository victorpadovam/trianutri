import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:trianutri_app/app/theme/app_colors.dart';

class CustomButtom extends StatelessWidget {
  Color backgroundColor;
  Color font_color;
  Color border_color;
  String text;
  VoidCallback callback;
  bool disabled;

  CustomButtom(
      {required this.backgroundColor,
      required this.font_color,
      required this.text,
      required this.border_color,
      required this.callback,
      this.disabled = false});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: !disabled ? callback : null,
        style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            disabledBackgroundColor: backgroundColor,
            shape: RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                side: BorderSide(color: border_color))),
        child: Container(
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(fontSize: 16, color: font_color),
          ),
        ));
  }
}
