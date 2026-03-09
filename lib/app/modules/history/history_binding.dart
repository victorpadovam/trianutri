import 'package:get/get.dart';
import 'package:trianutri_app/app/data/provider/api.dart';
import 'package:trianutri_app/app/data/repository/screening_repository.dart';
import 'package:trianutri_app/app/modules/history/history_controller.dart';

class HistoryBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HistoryController>(() {
      return HistoryController(
          repository: ScreeningRepository(apiClient: MyApiClient()));
    });
  }
}
