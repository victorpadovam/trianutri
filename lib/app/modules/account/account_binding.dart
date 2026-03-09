import 'package:get/get.dart';
import 'package:trianutri_app/app/data/provider/api.dart';
import 'package:trianutri_app/app/data/repository/auth_repository.dart';
import 'package:trianutri_app/app/data/repository/register_repository.dart';
import 'package:trianutri_app/app/modules/account/account_controller.dart';

class AccountBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AccountController>(() {
      return AccountController(
        repository: RegisterRepository(apiClient: MyApiClient()),
        authRepository: AuthRepository(apiClient: MyApiClient()),
      );
    });
  }
}
