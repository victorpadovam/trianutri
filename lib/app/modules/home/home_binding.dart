import 'package:get/get.dart';
import 'package:trianutri_app/app/data/provider/api.dart';
import 'package:trianutri_app/app/data/repository/auth_repository.dart';
import 'package:trianutri_app/app/data/repository/screening_repository.dart';
import 'package:trianutri_app/app/modules/home/home_controller.dart';
import 'package:trianutri_app/app/modules/screening/screening_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ScreeningController>(() {
      return ScreeningController(
          repository: ScreeningRepository(apiClient: MyApiClient()));
    });
    Get.lazyPut<HomeController>(() {
      return HomeController(
          repository: AuthRepository(apiClient: MyApiClient()));
    });
  }
}
