import 'package:get/get.dart';
import 'package:trianutri_app/app/data/provider/api.dart';
import 'package:trianutri_app/app/data/repository/auth_repository.dart';
import 'package:trianutri_app/app/modules/forget/forget_controller.dart';

class ForgetBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgetController>(() {
      return ForgetController(
          repository: AuthRepository(apiClient: MyApiClient()));
    });
  }
}
