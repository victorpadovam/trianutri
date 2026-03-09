import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:trianutri_app/app/data/model/tratament.dart';
import 'package:trianutri_app/app/modules/routes/app_routes.dart';
import 'package:trianutri_app/app/modules/screening/screening_controller.dart';
import 'package:trianutri_app/app/modules/widgets/custom_buttom.dart';
import 'package:trianutri_app/app/modules/widgets/custom_rounded_buttom.dart';
import 'package:trianutri_app/app/theme/app_colors.dart';

class ScreeningPage extends GetView<ScreeningController> {
  final _formKeyOne = GlobalKey<FormState>();
  final _formKeyTwo = GlobalKey<FormState>();
  final _formKeyThree = GlobalKey<FormState>();

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
                  SizedBox(height: 90),
                  Text(
                    "Formulário de Triagem",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      color: AppColors.bege,
                    ),
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
                  child: SingleChildScrollView(
                    child: Obx(() => Column(
                          children: [
                            Visibility(
                                visible: controller.loadingStatus,
                                child: const CircularProgressIndicator(
                                  backgroundColor: AppColors.white,
                                  color: AppColors.blue,
                                )),
                            Visibility(
                                visible: !controller.loadingStatus,
                                child: Column(
                                  children: [
                                    Visibility(
                                        visible: controller.screeningStatus
                                                    .isScreeningEnabled !=
                                                null &&
                                            controller.screeningStatus
                                                    .isScreeningEnabled ==
                                                false,
                                        child: Column(
                                          children: [
                                            const Text(
                                              "Próxima triagem a partir de:",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColors.black),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 20, bottom: 20),
                                              child: Text(
                                                controller.screeningStatus
                                                            .nextScreeningAt !=
                                                        null
                                                    ? DateFormat("dd/MM/y")
                                                        .format(controller
                                                            .screeningStatus
                                                            .nextScreeningAt!)
                                                    : '',
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColors.black),
                                              ),
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.only(
                                                  top: 20, bottom: 20),
                                              child: Text(
                                                "Você já respondeu o questionário de triagem desse mês, fique atento e aguarde até a próxima data.",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColors.black),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 20),
                                              child: CustomButtom(
                                                  backgroundColor:
                                                      AppColors.blue,
                                                  font_color: AppColors.bege,
                                                  text: "Histórico de triagens"
                                                      .toUpperCase(),
                                                  border_color: AppColors.blue,
                                                  disabled: controller.loading,
                                                  callback: () => Get.toNamed(
                                                      Routes.SCREENINGS)),
                                            )
                                          ],
                                        )),
                                    Visibility(
                                        visible: controller.step == 1,
                                        child: Form(
                                            key: _formKeyOne,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  "1) Você teve perda recente e não intencional de peso?",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: AppColors.black),
                                                ),
                                                FormBuilderRadioGroup<String>(
                                                  initialValue: controller
                                                      .form.firstQuestionPoints
                                                      .toString(),
                                                  name: '',
                                                  onChanged: (value) => controller
                                                          .form
                                                          .firstQuestionPoints =
                                                      int.parse(value!),
                                                  options: controller.stepOne
                                                      .map((Tratament
                                                              tratament) =>
                                                          FormBuilderFieldOption(
                                                            value:
                                                                tratament.code,
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(tratament
                                                                    .value),
                                                                Divider(),
                                                              ],
                                                            ),
                                                          ))
                                                      .toList(growable: false),
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return "Campo obrigatório!";
                                                    }
                                                    return null;
                                                  },
                                                  controlAffinity:
                                                      ControlAffinity.leading,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 20),
                                                  child: CustomButtom(
                                                      backgroundColor:
                                                          AppColors.blue,
                                                      font_color:
                                                          AppColors.bege,
                                                      text: "Próxima etapa"
                                                          .toUpperCase(),
                                                      border_color:
                                                          AppColors.blue,
                                                      callback: () =>
                                                          controller.nextStep(
                                                              _formKeyOne)),
                                                )
                                              ],
                                            ))),
                                    Visibility(
                                        visible: controller.step == 2,
                                        child: Form(
                                            key: _formKeyTwo,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                CustomRoundedButtom(
                                                    callback: () => controller
                                                        .previousStep(),
                                                    icon: const Icon(
                                                      FontAwesomeIcons
                                                          .arrowLeft,
                                                      size: 15,
                                                    ),
                                                    padding: 15),
                                                const Text(
                                                  "2) Se sim, de quanto (em kg) foi a sua perda de peso?",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: AppColors.black),
                                                ),
                                                FormBuilderRadioGroup<String>(
                                                  initialValue: controller
                                                      .form.secondQuestionPoints
                                                      .toString(),
                                                  name: '',
                                                  onChanged: (value) => controller
                                                          .form
                                                          .secondQuestionPoints =
                                                      int.parse(value!),
                                                  options: controller.stepTwo
                                                      .map((Tratament
                                                              tratament) =>
                                                          FormBuilderFieldOption(
                                                            value:
                                                                tratament.code,
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(tratament
                                                                    .value),
                                                                Divider(),
                                                              ],
                                                            ),
                                                          ))
                                                      .toList(growable: false),
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return "Campo obrigatório!";
                                                    }
                                                    return null;
                                                  },
                                                  controlAffinity:
                                                      ControlAffinity.leading,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 20),
                                                  child: CustomButtom(
                                                      backgroundColor:
                                                          AppColors.blue,
                                                      font_color:
                                                          AppColors.bege,
                                                      text: "Próxima etapa"
                                                          .toUpperCase(),
                                                      border_color:
                                                          AppColors.blue,
                                                      callback: () =>
                                                          controller.nextStep(
                                                              _formKeyTwo)),
                                                )
                                              ],
                                            ))),
                                    Visibility(
                                        visible: controller.step == 3,
                                        child: Form(
                                            key: _formKeyThree,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                CustomRoundedButtom(
                                                    callback: () => controller
                                                        .previousStep(),
                                                    icon: const Icon(
                                                      FontAwesomeIcons
                                                          .arrowLeft,
                                                      size: 15,
                                                    ),
                                                    padding: 15),
                                                const Text(
                                                  "3) Você tem se alimentado mal devido á redução de apetite?",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: AppColors.black),
                                                ),
                                                FormBuilderRadioGroup<String>(
                                                  initialValue: controller
                                                      .form.thirdQuestionPoints
                                                      .toString(),
                                                  name: '',
                                                  onChanged: (value) => controller
                                                          .form
                                                          .thirdQuestionPoints =
                                                      int.parse(value!),
                                                  options: controller.stepThree
                                                      .map((Tratament
                                                              tratament) =>
                                                          FormBuilderFieldOption(
                                                            value:
                                                                tratament.code,
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(tratament
                                                                    .value),
                                                                Divider(),
                                                              ],
                                                            ),
                                                          ))
                                                      .toList(growable: false),
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return "Campo obrigatório!";
                                                    }
                                                    return null;
                                                  },
                                                  controlAffinity:
                                                      ControlAffinity.leading,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 20),
                                                  child: CustomButtom(
                                                      backgroundColor:
                                                          AppColors.blue,
                                                      font_color:
                                                          AppColors.bege,
                                                      text: "Próxima etapa"
                                                          .toUpperCase(),
                                                      border_color:
                                                          AppColors.blue,
                                                      callback: () =>
                                                          controller.nextStep(
                                                              _formKeyThree)),
                                                )
                                              ],
                                            ))),
                                    Visibility(
                                        visible: controller.step == 4,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            CustomRoundedButtom(
                                                callback: () =>
                                                    controller.previousStep(),
                                                icon: const Icon(
                                                  FontAwesomeIcons.arrowLeft,
                                                  size: 15,
                                                ),
                                                padding: 15),
                                            const Text(
                                              "O resultado do seu questionário será gerado após a sua confirmação. Tenha certeza de ter respondido de forma correta as perguntas anterirores",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                  color: AppColors.black),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 20),
                                              child: CustomButtom(
                                                  backgroundColor:
                                                      AppColors.yellow,
                                                  font_color: AppColors.black,
                                                  text: controller.loading
                                                      ? "Salvando..."
                                                          .toUpperCase()
                                                      : "Revisar respostas"
                                                          .toUpperCase(),
                                                  disabled: controller.loading,
                                                  border_color:
                                                      AppColors.yellow,
                                                  callback: () =>
                                                      controller.step = 1),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 20),
                                              child: CustomButtom(
                                                  backgroundColor:
                                                      AppColors.blue,
                                                  font_color: AppColors.bege,
                                                  text: controller.loading
                                                      ? "Salvando..."
                                                          .toUpperCase()
                                                      : "Completar questionário"
                                                          .toUpperCase(),
                                                  border_color: AppColors.blue,
                                                  disabled: controller.loading,
                                                  callback: () =>
                                                      controller.save()),
                                            )
                                          ],
                                        )),
                                    Visibility(
                                        visible: controller.step == 5,
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
                                              padding: const EdgeInsets.only(
                                                  top: 20),
                                              child: CustomButtom(
                                                  backgroundColor:
                                                      AppColors.blue,
                                                  font_color: AppColors.bege,
                                                  text: "Fechar".toUpperCase(),
                                                  border_color: AppColors.blue,
                                                  disabled: controller.loading,
                                                  callback: () =>
                                                      controller.close()),
                                            )
                                          ],
                                        ))
                                  ],
                                )),
                          ],
                        )),
                  )),
            )
          ],
        ));
  }
}
