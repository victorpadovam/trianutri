import 'package:flutter/material.dart';
import 'package:trianutri_app/app/theme/app_colors.dart';

class HomeButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final Color blue = AppColors.blue;

  const HomeButton(
      {Key? super.key,
      required this.icon,
      required this.label,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.blue,
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
                side: const BorderSide(color: AppColors.bege),
                borderRadius: BorderRadius.circular(10))),
        child: SizedBox(
            width: 150,
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  icon,
                  color: AppColors.bege,
                  size: 48,
                ),
                Text(
                  label.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 15, color: AppColors.bege),
                )
              ],
            )));
  }
}
