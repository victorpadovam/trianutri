import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:trianutri_app/app/modules/forget/forget_controller.dart';
import 'package:trianutri_app/app/modules/routes/app_routes.dart';
import 'package:trianutri_app/app/modules/widgets/custom_buttom.dart';
import 'package:trianutri_app/app/modules/widgets/custom_rounded_buttom.dart';
import 'package:trianutri_app/app/theme/app_colors.dart';
import 'package:validatorless/validatorless.dart';

class ForgetPage extends GetView<ForgetController> {
  final _formKeyOne = GlobalKey<FormState>();
  final _formKeyTwo = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
          backgroundColor: AppColors.bege,
          body: Stack(
            children: [
              Container(
                height: 200,
                width: double.infinity,
                color: AppColors.blue,
              ),
              Align(
                alignment: Alignment(0.9, -0.9),
                child: CustomRoundedButtom(
                    callback: () => Get.toNamed(Routes.LOGIN),
                    icon: Icon(
                      FontAwesomeIcons.arrowLeft,
                      size: 15,
                    ),
                    padding: 15),
              ),
              const Align(
                alignment: Alignment(-0.8, -0.72),
                child: Text(
                  "Lembrar minha senha",
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
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
                    height: Get.height * 0.79,
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: SingleChildScrollView(
                      child: Obx(() => Column(
                            children: [
                              Visibility(
                                  visible: controller.step == 1,
                                  child: Form(
                                      key: _formKeyOne,
                                      child: Column(
                                        children: [
                                          const Text(
                                            "Informe o seu e-mail para ser enviado o código de recuperação de senha usado na próxima etapa.",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.black),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 20),
                                            child: FormBuilderTextField(
                                              autovalidateMode:
                                                  AutovalidateMode.always,
                                              name: 'E-mail',
                                              onChanged: (value) =>
                                                  controller.email = value,
                                              decoration: const InputDecoration(
                                                  labelText: "E-mail"),
                                              validator:
                                                  Validatorless.multiple([
                                                Validatorless.email(
                                                    'E-mail invalido'),
                                                Validatorless.required(
                                                    'Campo obrigatorio')
                                              ]),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 20),
                                            child: CustomButtom(
                                              backgroundColor: AppColors.blue,
                                              font_color: AppColors.bege,
                                              disabled: controller.loading,
                                              border_color: AppColors.blue,
                                              text: controller.loading
                                                  ? "Processando..."
                                                      .toUpperCase()
                                                  : "Recuperar senha"
                                                      .toUpperCase(),
                                              callback: () => controller
                                                  .sendMail(_formKeyOne),
                                            ),
                                          )
                                        ],
                                      ))),
                              Visibility(
                                  visible: controller.step == 2,
                                  child: Form(
                                      key: _formKeyTwo,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 20),
                                            child: FormBuilderTextField(
                                              autovalidateMode:
                                                  AutovalidateMode.always,
                                              name:
                                                  'Código de verificação (7 digitos)',
                                              onChanged: (value) =>
                                                  controller.code = value,
                                              decoration: const InputDecoration(
                                                  labelText:
                                                      "Código de verificação (7 digitos)"),
                                              validator:
                                                  Validatorless.multiple([
                                                Validatorless.min(7,
                                                    'O código precisa ter 7 digitos'),
                                                Validatorless.max(7,
                                                    'O código precisa ter 7 digitos'),
                                                Validatorless.required(
                                                    'Campo obrigatorio')
                                              ]),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 20),
                                            child: FormBuilderTextField(
                                              autovalidateMode:
                                                  AutovalidateMode.always,
                                              name: 'Senha',
                                              decoration: const InputDecoration(
                                                labelText: 'Senha',
                                              ),
                                              onChanged: (val) =>
                                                  controller.password = val,
                                              validator:
                                                  Validatorless.multiple([
                                                Validatorless.required(
                                                    'Campo obrigatorio'),
                                                Validatorless.min(6,
                                                    'É preciso ter no minimo 6 digitos')
                                              ]),
                                              initialValue: controller.password,
                                              textInputAction:
                                                  TextInputAction.next,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 20),
                                            child: FormBuilderTextField(
                                              autovalidateMode:
                                                  AutovalidateMode.always,
                                              name: 'Confirmação da Senha',
                                              decoration: const InputDecoration(
                                                labelText:
                                                    'Confirmação da Senha',
                                              ),
                                              onChanged: (val) => controller
                                                  .passwordConfirmation = val,
                                              validator:
                                                  Validatorless.multiple([
                                                Validatorless.required(
                                                    'Campo obrigatorio'),
                                                Validatorless.min(6,
                                                    'É preciso ter no minimo 6 digitos'),
                                                (value) {
                                                  if (value !=
                                                      controller.password) {
                                                    return "As duas senhas devem ser iguais!";
                                                  }
                                                }
                                              ]),
                                              initialValue: controller
                                                  .passwordConfirmation,
                                              textInputAction:
                                                  TextInputAction.next,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 20),
                                            child: CustomButtom(
                                              backgroundColor: AppColors.blue,
                                              font_color: AppColors.bege,
                                              disabled: controller.loading,
                                              border_color: AppColors.blue,
                                              text: controller.loading
                                                  ? "Processando..."
                                                      .toUpperCase()
                                                  : "Alterar senha"
                                                      .toUpperCase(),
                                              callback: () => controller
                                                  .updatePasswordWihtCode(
                                                      _formKeyTwo),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 20),
                                            child: CustomButtom(
                                              backgroundColor: AppColors.yellow,
                                              font_color: AppColors.bege,
                                              disabled: controller.loading,
                                              border_color: AppColors.yellow,
                                              text: controller.loading
                                                  ? "Processando..."
                                                      .toUpperCase()
                                                  : "Reenviar código"
                                                      .toUpperCase(),
                                              callback: () => controller
                                                  .sendMail(_formKeyTwo),
                                            ),
                                          )
                                        ],
                                      )))
                            ],
                          )),
                    )),
              )
            ],
          )),
    );
  }
}
