import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:trianutri_app/app/data/provider/api.dart';
import 'package:trianutri_app/app/data/repository/auth_repository.dart';
import 'package:trianutri_app/app/data/repository/register_repository.dart';
import 'package:trianutri_app/app/modules/account/account_controller.dart';
import 'package:trianutri_app/app/modules/home/home_controller.dart';
import 'package:trianutri_app/app/modules/home/widgets/home_button.dart';
import 'package:trianutri_app/app/modules/routes/app_routes.dart';
import 'package:trianutri_app/app/theme/app_colors.dart';

class HomePage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bege,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 35),
            Center(
              child: Image.asset(width: 150, 'images/logo.png'),
            ),
            Container(
              width: double.infinity,
              color: AppColors.blue,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Olá, tudo bem?",
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w400,
                                color: Colors.white),
                          ),
                          Text(
                            "Vamos facilitar suas triagens para garantir sua saúde!",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    // GridView para exibir botões
                    GridView.count(
                      crossAxisCount: 2, 
                      shrinkWrap:
                          true,
                      crossAxisSpacing: 20, 
                      mainAxisSpacing: 20, 
                      physics:
                          const NeverScrollableScrollPhysics(),
                      children: [
                        HomeButton(
                            icon: FontAwesomeIcons.fileSignature,
                            label: "triagem",
                            onPressed: () => controller.toScreening()),
                        HomeButton(
                            icon: FontAwesomeIcons.restroom,
                            label: "Calcular imc",
                            onPressed: () => Get.toNamed(Routes.IMC)),
                        HomeButton(
                            icon: FontAwesomeIcons.calendarDays,
                            label: "Histórico",
                            onPressed: () => Get.toNamed(Routes.SCREENINGS)),
                        HomeButton(
                            icon: FontAwesomeIcons.user,
                            label: "Minha conta",
                            onPressed: () async {
                              Get.put(AccountController(
                                repository: RegisterRepository(
                                    apiClient: MyApiClient()),
                                authRepository:
                                    AuthRepository(apiClient: MyApiClient()),
                              ));
                              final AccountController accountController =
                                  Get.find<AccountController>();
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    accountController.buscaDadosDoPerfil(),
                              ));
                            }),
                        HomeButton(
                            icon: FontAwesomeIcons.arrowRightFromBracket,
                            label: "Sair",
                            onPressed: () => controller.logout()),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(right: 16, left: 16, top: 20),
                  child: Text(
                    'Adaptado de Ferguson et al. Nutrition. 1999 jun; 15(6):458-64',
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16, left: 16, top: 5),
                  child: TextButton(
                    onPressed: () => Get.toNamed(Routes.COPY),
                    child: const Text(
                      'Créditos do Aplicativo',
                      style: TextStyle(color: AppColors.blue),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
