import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:trianutri_app/app/data/utils/mask.dart';
import 'package:trianutri_app/app/modules/imc/imc_controller.dart';
import 'package:trianutri_app/app/modules/routes/app_routes.dart';
import 'package:trianutri_app/app/modules/widgets/custom_buttom.dart';
import 'package:trianutri_app/app/modules/widgets/custom_rounded_buttom.dart';
import 'package:trianutri_app/app/theme/app_colors.dart';
import 'package:validatorless/validatorless.dart';

class ImcPage extends GetView<ImcController> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
        backgroundColor: AppColors.bege,
        body: Stack(
          children: [
            Container(
              height: 240,
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 70),
                  Text(
                    "Calcula IMC",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      color: AppColors.bege,
                    ),
                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      // launchUrl(Uri.parse(
                      //   "https://www.gov.br/saude/pt-br/assuntos/saude-brasil/eu-quero-ter-peso-saudavel/noticias/2017/imc-voce-sabe-calcular-seu-peso-adequado",
                      // ));
                    },
                    child: Container(
                      child: Text.rich(
                        TextSpan(
                          text:
                              "Índice de Massa Corporal é um parâmetro utilizado para saber se o peso está de acordo com a altura. \n",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColors.bege,
                          ),
                          children: [
                            TextSpan(
                              text: "Fonte: Ministério da Saúde",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: AppColors.bege,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 200,
              left: 10,
              right: 10,
              child: Container(
                  padding: const EdgeInsets.all(10),
                  width: double.infinity,
                  height: Get.height * 0.75,
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: SingleChildScrollView(
                    child: Obx(() => Column(
                          children: [
                            Visibility(
                              visible: controller.result >= 0,
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: FormBuilderTextField(
                                        autovalidateMode:
                                            AutovalidateMode.always,
                                        name: '',
                                        inputFormatters: [Mask.floatMask],
                                        decoration: const InputDecoration(
                                            labelText: "Altura (m)",
                                            hintText: "Exemplo: 1.79"),
                                        keyboardType: TextInputType.number,
                                        onChanged: (val) => controller.size =
                                            double.parse(val!),
                                        validator: Validatorless.multiple([
                                          Validatorless.required(
                                            'Campo obrigatorio',
                                          )
                                        ]),
                                        textInputAction: TextInputAction.next,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: FormBuilderTextField(
                                        autovalidateMode:
                                            AutovalidateMode.always,
                                        name: '',
                                        inputFormatters: [Mask.floatMask],
                                        decoration: const InputDecoration(
                                            labelText: "Peso (kg)",
                                            hintText: "Exemplo: 90.0"),
                                        keyboardType: TextInputType.number,
                                        onChanged: (val) => controller.weight =
                                            double.parse(val!),
                                        validator: Validatorless.multiple([
                                          Validatorless.required(
                                            'Campo obrigatorio',
                                          ),
                                        ]),
                                        textInputAction: TextInputAction.next,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: CustomButtom(
                                        backgroundColor: AppColors.blue,
                                        font_color: AppColors.bege,
                                        text: "Calcular".toUpperCase(),
                                        border_color: AppColors.blue,
                                        callback: () =>
                                            controller.calc(_formKey),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Visibility(
                                visible: controller.result > 0,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: Container(
                                        alignment: Alignment.center,
                                        color: AppColors.blue,
                                        height: 40,
                                        width: double.infinity,
                                        child: Text(
                                          "Seu IMC é de ${controller.result} kg/m2.",
                                          style:
                                              TextStyle(color: AppColors.white),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                        padding:
                                            EdgeInsets.only(left: 5, right: 5),
                                        child: Column(
                                          children: [
                                            Container(
                                                child: const Padding(
                                              padding: EdgeInsets.all(10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(''),
                                                  Text('IMC'),
                                                ],
                                              ),
                                            )),
                                            Container(
                                                color: controller.result > 0 &&
                                                        controller.result < 18.5
                                                    ? AppColors.yellow
                                                    : null,
                                                child: const Padding(
                                                  padding: EdgeInsets.all(10),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text('Magreza'),
                                                      Text('< 18.5'),
                                                    ],
                                                  ),
                                                )),
                                            Container(
                                                color: controller.result >=
                                                            18.5 &&
                                                        controller.result < 24.9
                                                    ? AppColors.green
                                                    : null,
                                                child: const Padding(
                                                  padding: EdgeInsets.all(10),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text('Normal'),
                                                      Text('18.5 a 24.9'),
                                                    ],
                                                  ),
                                                )),
                                            Container(
                                                color: controller.result >=
                                                            24.9 &&
                                                        controller.result <= 30
                                                    ? AppColors.yellow
                                                    : null,
                                                child: const Padding(
                                                  padding: EdgeInsets.all(10),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text('Sobrepeso'),
                                                      Text('24.9 a 30'),
                                                    ],
                                                  ),
                                                )),
                                            Container(
                                                color: controller.result > 30
                                                    ? AppColors.red
                                                    : null,
                                                child: const Padding(
                                                  padding: EdgeInsets.all(10),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text('Obesidade'),
                                                      Text('> 30'),
                                                    ],
                                                  ),
                                                ))
                                          ],
                                        ))
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
