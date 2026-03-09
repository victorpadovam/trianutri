import 'package:get/get.dart';
import 'package:trianutri_app/app/data/provider/api.dart';
import 'package:trianutri_app/app/data/repository/screening_repository.dart';
import 'package:trianutri_app/app/modules/screening_result/screening_result_controller.dart';

class ScreeningResultBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyReplace<ScreeningResultController>(() {
      return ScreeningResultController(
          repository: ScreeningRepository(apiClient: MyApiClient()));
    });
  }
}
