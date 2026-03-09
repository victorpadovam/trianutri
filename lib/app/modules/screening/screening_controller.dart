import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:trianutri_app/app/data/model/screening.dart';
import 'package:trianutri_app/app/data/model/screening_response.dart';
import 'package:trianutri_app/app/data/model/screening_status_response.dart';
import 'package:trianutri_app/app/data/model/tratament.dart';
import 'package:trianutri_app/app/data/repository/screening_repository.dart';
import 'package:trianutri_app/app/modules/routes/app_routes.dart';

class ScreeningController extends GetxController {
  late final ScreeningRepository repository;

  ScreeningController({required this.repository});
  final _loading = false.obs;

  final _step = 0.obs;

  final _sum = 0.obs;
  final _createdAt = ''.obs;
  final _loadingStatus = true.obs;

  final List<Tratament> stepOne = [
    Tratament(code: "0", value: "Não"),
    Tratament(code: "2", value: "Não sabe"),
    Tratament(code: "3", value: "Sim"),
  ];

  final List<Tratament> stepTwo = [
    Tratament(code: "1", value: "1-5"),
    Tratament(code: "2", value: "6-10"),
    Tratament(code: "3", value: "11-15"),
    Tratament(code: "4", value: "Mais que 15"),
    Tratament(code: "0", value: "Não sabe"),
  ];

  final List<Tratament> stepThree = [
    Tratament(code: "1", value: "Sim"),
    Tratament(code: "0", value: "Não"),
  ];

  final Screening form = Screening();
  final _screening = ScreeningResponse().obs;
  final _screeningStatus = ScreeningStatusResponse().obs;

  set step(value) => _step.value = value;
  get step => _step.value;

  set loading(value) => _loading.value = value;
  get loading => _loading.value;

  set sum(value) => _sum.value = value;
  get sum => _sum.value;

  set createdAt(value) => _createdAt.value = value;
  get createdAt => _createdAt.value;

  set loadingStatus(value) => _loadingStatus.value = value;
  get loadingStatus => _loadingStatus.value;

  set screening(value) => _screening.value = value;
  ScreeningResponse get screening => _screening.value;

  set screeningStatus(value) => _screeningStatus.value = value;
  ScreeningStatusResponse get screeningStatus => _screeningStatus.value;

  loadStatus() async {
    loadingStatus = true;
    screeningStatus = await repository.getStatus();
    if (screeningStatus.isScreeningEnabled!) {
      step = 1;
    }
    loadingStatus = false;
  }

  nextStep(GlobalKey<FormState> formKey) async {
    if (formKey.currentState!.validate() && step < 4) {
      if (step == 1 && form.firstQuestionPoints == 0) {
        step = 3;
        form.secondQuestionPoints = -1;
      } else {
        step = step + 1;
      }
    } else {
      print("Formulario invalido");
    }
  }

  previousStep() {
    if (step == 3 && form.firstQuestionPoints == 0) {
      step = 1;
    } else {
      step = step - 1;
    }
  }

  save() async {
    loading = true;
    final screeningId = await repository.saveScreening(form);
    print(form.toJson());
    loading = false;
    if (screeningId != null) {
      screening = await repository.getScreening(screeningId);
      sum = screening.sum!;
      DateTime createdAtUtc = DateTime.parse(screening.createdAt.toString());
      DateTime createdAtLocal = createdAtUtc.toLocal();
      createdAt = DateFormat("dd/MM/y HH:mm:ss").format(createdAtLocal);
      step = 5;
    }
  }

  close() {
    step = 1;
    Get.toNamed(Routes.HOME);
  }
}
