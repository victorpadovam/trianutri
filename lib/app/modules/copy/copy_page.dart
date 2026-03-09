import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:trianutri_app/app/modules/copy/copy_controller.dart';
import 'package:trianutri_app/app/modules/widgets/custom_rounded_buttom.dart';
import 'package:trianutri_app/app/theme/app_colors.dart';

class CopyPage extends GetView<CopyController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.bege,
        body: Stack(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              color: AppColors.blue,
            ),
            Align(
              alignment: const Alignment(0.9, -0.9),
              child: CustomRoundedButtom(
                  callback: () => Get.back(),
                  icon: const Icon(
                    FontAwesomeIcons.arrowLeft,
                    size: 15,
                  ),
                  padding: 15),
            ),
            const Align(
              alignment: Alignment(-0.8, -0.72),
              child: Text(
                "Créditos do Aplicativo",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                    color: AppColors.bege),
              ),
            ),
            Positioned(
              top: 170,
              left: 10,
              right: 10,
              child: Container(
                  padding: const EdgeInsets.all(10),
                  width: double.infinity,
                  height: Get.height * 0.79,
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: const Text(
                      "Adaptado de Ferguson M, Capra S, Bauer J, Banks M. Development of a valid and reliable malnutrition screening tool for adult acute hospital patients. Nutrition. 1999;15(6):458-64")),
            )
          ],
        ));
  }
}
