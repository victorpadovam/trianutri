import 'package:get/get.dart';
import 'package:trianutri_app/app/data/provider/api.dart';
import 'package:trianutri_app/app/data/repository/auth_repository.dart';
import 'package:trianutri_app/app/modules/login/Login_controller.dart';

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() {
      return LoginController(
          repository: AuthRepository(apiClient: MyApiClient()));
    });
  }
}
