import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trianutri_app/app/data/model/City.dart';
import 'package:trianutri_app/app/data/model/Gender.dart';
import 'package:trianutri_app/app/data/model/State.dart';
import 'package:trianutri_app/app/data/model/register.dart';
import 'package:trianutri_app/app/data/model/tratament.dart';
import 'package:trianutri_app/app/data/repository/register_repository.dart';
import 'package:trianutri_app/app/modules/routes/app_routes.dart';

class RegisterController extends GetxController {
  late final RegisterRepository repository;

  RegisterController({required this.repository});

  late FocusNode focusNode;

  final RxList<StateModel> _states = <StateModel>[].obs;
  final RxList<CityModel> _cities = <CityModel>[].obs;

  final _gender = ''.obs;
  final _state = ''.obs;
  final _city = ''.obs;
  final _loading = false.obs;

  final _stateSelected = 0.obs;
  final _step = 1.obs;
  FocusNode cityFocusNode = FocusNode();

  final List<Gender> geners = [
    Gender(id: 1, value: "Masculino"),
    Gender(id: 2, value: "Feminino"),
    Gender(id: 3, value: "Não quero informar"),
  ];

  final List<Tratament> trataments = [
    Tratament(code: "do_hemodialysis", value: "Realizo hemodiálise"),
    Tratament(code: "do_not_hemodialysis", value: "Não realizo hemodiálise"),
    Tratament(code: "peritoneal_dialysis", value: "Realizo diálise peritonea"),
    Tratament(code: "transplanted", value: "Sou transplantado"),
  ];

  final List<Tratament> illnesses = [
    Tratament(
        code: "arterial_hypertension",
        value: "Hipertensão Arterial (pressão alta)"),
    Tratament(code: "diabetes", value: "Diabetes"),
    Tratament(code: "others", value: "Outras"),
  ];

  final Register form = Register();
  var isLoadingCities = false;

  List<StateModel> get states => _states.value;

  List<CityModel> get cities => _cities.value;

  set step(value) => _step.value = value;
  get step => _step.value;

  set stateSelected(value) => _stateSelected.value = value;
  get stateSelected => _stateSelected.value;

  set gender(value) => _gender.value = value;
  get gender => _gender.value;

  set state(value) => _state.value = value;
  get state => _state.value;

  set city(value) => _city.value = value;
  get city => _city.value;

  set loading(value) => _loading.value = value;
  get loading => _loading.value;

  loadStates() async {
    _states.value = await repository.states();
  }

  updateStateTrue() {
    isLoadingCities = true;
    update();
  }

  updateStateFalse() {
    isLoadingCities = false;
    update();
  }

// Função para carregar as cidades
  Future<void> loadCities(String stateId) async {
    try {
      updateStateFalse();
      await Future.delayed(Duration(seconds: 2));
      _cities.value = await repository.cities(stateId);
      updateStateTrue();
    } catch (e) {
      print("Erro ao carregar cidades: $e");
    } finally {
      updateStateTrue();
    }
  }

  nextStep(GlobalKey<FormState> formKey) async {
    if (formKey.currentState!.validate()) {
      step = step + 1;
    } else {
      print("Formulario invalido");
    }
  }

  Future<void> register() async {
    if (form.email == null ||
        form.password == null ||
        form.passwordConfirmation == null) {
      Get.snackbar(
        "Atenção",
        "Preencha todos os campos obrigatórios!",
        backgroundColor: Colors.orange,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );
      loading = false;
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

      // Adicionando timeout para evitar requisição pendente
      final status =
          await repository.register(form).timeout(const Duration(seconds: 10));

      print("Status do registro: $status");

      if (status) {
        Get.toNamed(Routes.LOGIN);
      } else {
        loading = false;
        Get.snackbar(
          "Erro",
          "Ocorreu um erro inesperado tente novamente",
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
        "Falha ao registrar: ${e.message}",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );
      loading = false;
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
      loading = false;
    } catch (e, stackTrace) {
      loading = false;
      print("Erro inesperado: $e\nStackTrace: $stackTrace");
      Get.snackbar(
        "Erro",
        "Ocorreu um erro inesperado. $e",
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
    loadStates();
    focusNode = FocusNode();

    ever(_stateSelected, (state) {
      loadCities(state.toString());
    });

    super.onInit();
  }

  @override
  void onClose() {
    focusNode.dispose();
    cityFocusNode.dispose(); // Dispose do FocusNode ao encerrar o controller

    super.onClose();
  }
}
