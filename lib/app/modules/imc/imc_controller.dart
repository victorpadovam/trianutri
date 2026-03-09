import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trianutri_app/app/modules/routes/app_routes.dart';

class ImcController extends GetxController {
  ImcController();

  final _weight = 0.0.obs;
  final _size = 0.0.obs;
  final _result = 0.0.obs;

  set weight(value) => _weight.value = value;
  get weight => _weight.value;

  set size(value) => _size.value = value;
  get size => _size.value;

  set result(value) => _result.value = value;
  get result => _result.value;

  calc(GlobalKey<FormState> formKey) {
    if (formKey.currentState!.validate()) {
      result = double.parse((weight / pow(size, 2)).toString()).toPrecision(2);
    }
  }

  close() {
    Get.toNamed(Routes.HOME);
  }
}
