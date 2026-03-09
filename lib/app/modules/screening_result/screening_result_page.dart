import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:trianutri_app/app/data/model/tratament.dart';
import 'package:trianutri_app/app/modules/routes/app_routes.dart';
import 'package:trianutri_app/app/modules/screening_result/screening_result_controller.dart';
import 'package:trianutri_app/app/modules/widgets/custom_buttom.dart';
import 'package:trianutri_app/app/modules/widgets/custom_rounded_buttom.dart';
import 'package:trianutri_app/app/theme/app_colors.dart';

class ScreeningResultPage extends GetView<ScreeningResultController> {
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
            Padding(
              padding: const EdgeInsets.only(top: 45, left: 300),
              child: CustomRoundedButtom(
                  callback: () => Get.toNamed(Routes.SCREENINGS),
                  icon: const Icon(
                    FontAwesomeIcons.arrowLeft,
                    size: 15,
                  ),
                  padding: 15),
            ),
            const Align(
              alignment: Alignment(-0.8, -0.72),
              child: Text(
                "Detalhes da Triagem",
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
                  child: SingleChildScrollView(
                    child: Obx(() => Column(
                          children: [
                            Visibility(
                                visible: controller.loading,
                                child: const CircularProgressIndicator(
                                  backgroundColor: AppColors.white,
                                  color: AppColors.blue,
                                )),
                            Visibility(
                                visible: !controller.loading,
                                child: Column(
                                  children: [
                                    Text(
                                      controller.sum > 2
                                          ? "Você está em RISCO NUTRICIONAL"
                                          : "Saudável",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: controller.sum > 2
                                              ? AppColors.red
                                              : AppColors.green),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 20, bottom: 20),
                                      child: Text(
                                        controller.sum > 2
                                            ? "Procure o mais breve possóvel um nutricionista ou um médico para avaliação!"
                                            : "Parabéns, você não apresenta risco nutricional. Continue se alimentando bem e realizando a triagem todo mês!",
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.black),
                                      ),
                                    ),
                                    Text(
                                      "Respondido em ${controller.createdAt}",
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.black),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: CustomButtom(
                                          backgroundColor: AppColors.blue,
                                          font_color: AppColors.bege,
                                          text: "Fechar".toUpperCase(),
                                          border_color: AppColors.blue,
                                          disabled: controller.loading,
                                          callback: () => controller.close()),
                                    )
                                  ],
                                ))
                          ],
                        )),
                  )),
            )
          ],
        ));
  }
}
