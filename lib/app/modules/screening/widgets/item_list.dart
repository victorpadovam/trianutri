import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trianutri_app/app/theme/app_colors.dart';

class ItemList extends StatelessWidget {
  int sum;
  DateTime createdAt;
  VoidCallback onPressed;
  ItemList(
      {super.key,
      required this.createdAt,
      required this.sum,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat("dd/MM/y H:m:s").format(createdAt),
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.black),
                ),
                Text(
                  sum > 2 ? "Risco de desnutrição" : "Saudavel",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: sum > 2 ? AppColors.red : AppColors.green),
                ),
              ],
            ),
            IconButton(
                onPressed: onPressed,
                icon: const Icon(Icons.keyboard_arrow_right_outlined))
          ],
        ),
        const Divider()
      ],
    );
  }
}
