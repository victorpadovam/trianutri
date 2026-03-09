import 'package:get/get.dart';
import 'package:trianutri_app/app/data/provider/api.dart';
import 'package:trianutri_app/app/data/repository/screening_repository.dart';
import 'package:trianutri_app/app/modules/screening/screening_controller.dart';

class ScreeningBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ScreeningController>(() {
      return ScreeningController(
          repository: ScreeningRepository(apiClient: MyApiClient()));
    });
  }
}
