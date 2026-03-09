import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trianutri_app/app/data/model/auth.dart';
import 'package:trianutri_app/app/data/repository/auth_repository.dart';
import 'package:trianutri_app/app/modules/routes/app_routes.dart';

class LoginController extends GetxController {
  late final AuthRepository repository;
  bool obscureText = true;

  final Auth authDto = Auth(email: '', password: '');

  LoginController({required this.repository});

// Define _loading como RxBool para reatividade
  final RxBool _loading = false.obs;

  // Getters e Setters para acessar corretamente o estado reativo
  bool get loading => _loading.value;
  set loading(bool value) => _loading.value = value;
  final bool teste123333 = false;

  teste123() {}

  __initialize() async {
    dynamic user = await repository.me();
    if (user != null) {
      Get.toNamed(Routes.HOME);
    }
  }

  changeIcon() {
    obscureText = !obscureText;
    update();
  }

  Future<void> login(GlobalKey<FormState> formKey) async {
    if (!formKey.currentState!.validate()) {
      print("Formulário inválido");
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
      Get.snackbar(
        "Aguarde um momento",
        "Carregando...",
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );

      loading = true;

      final auth =
          await repository.login(authDto).timeout(const Duration(seconds: 10));

      if (auth) {
        Get.toNamed(Routes.HOME);
      } else {
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
      print("DioException: ${e.message}");
      Get.snackbar(
        "Erro",
        "Falha ao realizar login: ${e.message}",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );
    } on TimeoutException {
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
      print("Erro inesperado: $e\nStackTrace: $stackTrace");
      Get.snackbar(
        "Erro",
        "Ocorreu um erro inesperado. Tente novamente mais tarde.",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );
    } finally {
      loading = false;
    }
  }

  @override
  void onInit() {
    __initialize();
    super.onInit();
  }
}
