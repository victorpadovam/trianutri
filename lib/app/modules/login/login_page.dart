import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trianutri_app/app/data/provider/api.dart';
import 'package:trianutri_app/app/data/repository/auth_repository.dart';
import 'package:trianutri_app/app/modules/login/Login_controller.dart';
import 'package:trianutri_app/app/modules/login/components/password_field.dart';
import 'package:trianutri_app/app/modules/routes/app_routes.dart';
import 'package:trianutri_app/app/modules/widgets/custom_buttom.dart';
import 'package:trianutri_app/app/theme/app_colors.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
        LoginController(repository: AuthRepository(apiClient: MyApiClient())));

    return Scaffold(
        backgroundColor: AppColors.bege,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(width: 150, 'images/logo.png'),
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      color: AppColors.bege,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "ACESSO",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            TextFormField(
                              initialValue: controller.authDto.email,
                              onChanged: (value) =>
                                  controller.authDto.email = value,
                              decoration: InputDecoration(labelText: "E-mail"),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "O campo email é obrigatório!";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const PasswordField(),
                            const SizedBox(
                              height: 20,
                            ),
                            // CustomButtom(
                            //   backgroundColor: AppColors.blue,
                            //   font_color: AppColors.bege,
                            //   text: "Entrar",
                            //   border_color: AppColors.blue,
                            //   callback: () => controller.login(_formKey),
                            // ),
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () => login(_formKey, controller),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.blue,
                                  disabledBackgroundColor: Colors.grey,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: loading
                                    ? const SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : Text(
                                        'Entrar'.toUpperCase(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomButtom(
                              backgroundColor: AppColors.bege,
                              font_color: AppColors.blue,
                              text: "LEMBRAR MINHA SENHA",
                              border_color: AppColors.blue,
                              callback: () {
                                Get.offAllNamed(Routes.FORGET);
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomButtom(
                                backgroundColor: AppColors.bege,
                                font_color: AppColors.blue,
                                text: "CRIAR MEU ACESSO",
                                border_color: AppColors.blue,
                                callback: () => Get.toNamed(Routes.REGISTER)),
                          ],
                        ),
                      ),
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
                        padding:
                            const EdgeInsets.only(right: 16, left: 16, top: 5),
                        child: TextButton(
                          onPressed: () => Get.toNamed(Routes.COPY),
                          child: const Text(
                            'Créditos do Aplicativo',
                            style: TextStyle(color: AppColors.blue),
                            textAlign: TextAlign.center,
                          ),
                        ))
                  ],
                )
              ],
            ),
          ),
        ));
  }

  Future<void> login(
    GlobalKey<FormState> formKey,
    controller,
  ) async {
    AuthRepository repository = AuthRepository(apiClient: MyApiClient());
    if (!formKey.currentState!.validate()) {
      setState(() {
        loading = false;
      });
      Get.snackbar(
        "Atenção",
        "Por favor, preencha todos os campos corretamente.",
        backgroundColor: Colors.orange,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );
      return;
    }

    try {
      setState(() {
        loading = true;
      });
      Get.snackbar(
        "Aguarde um momento",
        "Carregando...",
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );

      print(controller.authDto);

      final auth = await repository
          .login(controller.authDto)
          .timeout(const Duration(seconds: 10));

      if (auth) {
        Get.toNamed(Routes.HOME);
      } else {
        setState(() {
          loading = false;
        });

        Get.snackbar(
          "Erro",
          "Usuário ou senha inválidos.",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 3),
        );
      }
    } on DioException catch (e) {
      setState(() {
        loading = false;
      });
      print("DioException: ${e.message}");
      Get.snackbar(
        "Erro",
        "Falha ao realizar login",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );
    } on TimeoutException {
      setState(() {
        loading = false;
      });
      print("Erro: Tempo limite da requisição excedido.");
      Get.snackbar(
        "Tempo limite da requisição excedido",
        "O servidor pode estar indisponível ou sua conexão pode estar instável.",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );
    } catch (e, stackTrace) {
      setState(() {
        loading = false;
      });
      print("Erro inesperado");
      Get.snackbar(
        "Erro",
        "Ocorreu um erro inesperado. Tente novamente mais tarde.",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );
    } finally {
      setState(() {
        loading = false;
      });
    }
  }
}
