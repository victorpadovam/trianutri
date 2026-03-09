import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:trianutri_app/app/data/model/auth.dart';
import 'package:trianutri_app/app/data/provider/api.dart';
import 'package:trianutri_app/app/data/utils/config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trianutri_app/app/modules/account/account_page.dart';
import 'package:trianutri_app/app/modules/routes/app_routes.dart';

class AuthRepository {
  final MyApiClient apiClient;
  AuthRepository({required this.apiClient});

  login(Auth form) async {
    try {
      final client = await apiClient.client();
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      const String endpoint = "${Config.apiEndpoint}/api/v1/login";
      print("Ola tudo bem? ${form.toJson()}");

      final response = await client.post(endpoint, data: form.toJson());

      final data = response.data;

      prefs.setString('token', data['token']);
      Get.snackbar('Autenticação', 'Bem vindo de volta!');
      return true;
    } on DioException catch (e) {
      print("Teste ${e.response?.data}");
      print(e.response?.statusCode);
      if (e.response?.statusCode == 422) {
        Get.snackbar('Autenticação', 'Usuario ou senha invalido');
        throw e;
      }
      if (e.response?.statusCode != 200) {
        Get.snackbar('Autenticação', e.response?.data['message']);
        throw e;
      }
    }
  }

  Future<dynamic> SendRecoveryMail(String email) async {
    try {
      final client = await apiClient.client();
      const String endpoint = "${Config.apiEndpoint}/api/v1/forgot-password";
      final dto = {"email": email};
      print(dto);
      final response = await client.post(endpoint, data: dto);

      final data = response.data;

      print(data);

      Get.snackbar(
        'Recuperação de senha',
        'Verifique o código de confirmação que enviamos para o seu e-mail.',
      );
    } on DioException catch (e) {
      print("Teste ${e.response?.data}");
      print(e.response?.statusCode);
      if (e.response?.statusCode == 422) {
        Get.snackbar('Recuperação de senha',
            'Não foi possivel enviar o código de recuperação!');
        throw e;
      }
      if (e.response?.statusCode != 200) {
        Get.snackbar(
            'Recuperação de senha', 'Erro interno, contate o suporte!');
        throw e;
      }
      throw e;
    }
  }

  Future<void> updatePasswordWihtCode(String email, String code,
      String password, String passwordConfirmation) async {
    try {
      final client = await apiClient.client();
      const String endpoint = "${Config.apiEndpoint}/api/v1/reset-password";
      final dto = {
        "email": email,
        "token": code,
        "password": password,
        "password_confirmation": passwordConfirmation
      };
      print(dto);
      final response = await client.post(endpoint, data: dto);

      final data = response.data;

      print(data);

      Get.snackbar('Recuperação de senha', data['message']);
    } on DioException catch (e) {
      print("Teste ${e.response?.data}");
      print(e.response?.statusCode);
      if (e.response?.statusCode == 422) {
        Get.snackbar('Recuperação de senha',
            'Não foi possivel enviar o código de recuperação!');
        throw e;
      }
      if (e.response?.statusCode != 200) {
        Get.snackbar(
            'Recuperação de senha', 'Erro interno, contate o suporte!');
        throw e;
      }
      throw e;
    }
  }

  Future<bool> update(AccountForm form) async {
    bool statusLoading = true;

    try {
      final client = await apiClient.client();
      const String endpoint = "${Config.apiEndpoint}/api/v1/profile/update";
      var dto = form.toJson();
      print(dto);

      final response = await client.post(endpoint, data: dto);
      if (response.statusCode == 200) {
        Get.snackbar('Sucesso', 'Dados alterados');
      } else {
        Get.snackbar('Erro', 'Dados alterados nao alterados');
      }

      return statusLoading;
    } on DioException catch (e) {
      print("${e.response?.data}");
      var result = e.response?.data;
      var errors = result['errors'] as Map<String, dynamic>?;
      String errorMessage = errors?.entries
              .map((entry) =>
                  "${entry.key}: ${entry.value is List ? (entry.value as List).join(', ') : entry.value}")
              .join('\n') ??
          result;
      Get.snackbar('Erro', errorMessage);

      return false;
    }
  }

  dynamic me() async {
    try {
      final client = await apiClient.client();

      const String endpoint = "${Config.apiEndpoint}/api/v1/profile/me";
      final response = await client.get(endpoint);
      final prefs = await SharedPreferences.getInstance();

      await prefs.setString('me', jsonEncode(response.data['me']));
      print('Dados salvos com sucesso no SharedPreferences.');

      return response.data;
    } catch (e) {
      return null;
    }
  }

  void logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    Get.toNamed(Routes.LOGIN);
  }
}
