import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomRoundedButtom extends StatelessWidget {
  Icon icon;
  double padding;
  VoidCallback callback;

  CustomRoundedButtom(
      {required this.icon, required this.padding, required this.callback});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: callback,
      child: icon,
      style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(padding), shape: const CircleBorder()),
    );
  }
}
