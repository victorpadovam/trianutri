import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trianutri_app/app/data/repository/auth_repository.dart';
import 'package:trianutri_app/app/modules/routes/app_routes.dart';

class ForgetController extends GetxController {
  late final AuthRepository repository;

  ForgetController({required this.repository});

  final _step = 1.obs;

  final _email = ''.obs;
  final _code = ''.obs;
  final _password = ''.obs;
  final _passwordConfirmation = ''.obs;
  final _loading = false.obs;

  get loading => _loading.value;
  set loading(value) => _loading.value = value;

  get step => _step.value;
  set step(value) => _step.value = value;

  get email => _email.value;
  set email(value) => _email.value = value;

  get password => _password.value;
  set password(value) => _password.value = value;

  get passwordConfirmation => _passwordConfirmation.value;
  set passwordConfirmation(value) => _passwordConfirmation.value = value;

  get code => _code.value;
  set code(value) => _code.value = value;

  void nextStep() {
    step = 2;
  }

  void sendMail(GlobalKey<FormState> formKey) async {
    if (email != null || formKey.currentState!.validate()) {
      try {
        loading = true;
        await repository.SendRecoveryMail(email);
        step = 2;
      } catch (e) {
      } finally {
        loading = false;
      }
    }
  }

  void updatePasswordWihtCode(GlobalKey<FormState> formKey) async {
    if (formKey.currentState!.validate()) {
      try {
        loading = true;
        await repository.updatePasswordWihtCode(
            email, code, password, passwordConfirmation);
        step = 1;
        Get.toNamed(Routes.LOGIN);
      } catch (e) {
      } finally {
        loading = false;
      }
    }
  }
}
