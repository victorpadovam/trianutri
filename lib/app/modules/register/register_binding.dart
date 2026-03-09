import 'package:get/get.dart';
import 'package:trianutri_app/app/data/provider/api.dart';
import 'package:trianutri_app/app/data/repository/register_repository.dart';
import 'package:trianutri_app/app/modules/register/register_controller.dart';

class RegisterBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterController>(() {
      return RegisterController(
          repository: RegisterRepository(apiClient: MyApiClient()));
    });
  }
}
