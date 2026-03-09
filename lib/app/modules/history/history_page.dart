import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:trianutri_app/app/modules/history/history_controller.dart';
import 'package:trianutri_app/app/modules/routes/app_routes.dart';
import 'package:trianutri_app/app/modules/screening/widgets/item_list.dart';
import 'package:trianutri_app/app/modules/widgets/custom_rounded_buttom.dart';
import 'package:trianutri_app/app/theme/app_colors.dart';

class HistoryPage extends GetView<HistoryController> {
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
          Positioned(
            top: 45,
            right: 20,
            child: CustomRoundedButtom(
              callback: () => Get.toNamed(Routes.HOME),
              icon: const Icon(
                FontAwesomeIcons.arrowLeft,
                size: 15,
              ),
              padding: 15,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 70),
                Text(
                  "Histórico de Triagem",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                    color: AppColors.bege,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Lista com todas as suas triagens realizadas pelo aplicativo.",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.bege),
                ),
              ],
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
              child: Obx(
                () => Visibility(
                  visible: controller.screenings.isNotEmpty,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.screenings.length,
                    itemBuilder: (context, index) {
                      final screening = controller.screenings[index];
                      return ItemList(
                        createdAt: screening.createdAt!,
                        sum: screening.sum!,
                        onPressed: () {
                          Get.toNamed(Routes.SCREENING_RESULT,
                              arguments: {"screeningId": screening.id!});
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
