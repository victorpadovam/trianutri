import 'package:get/get.dart';
import 'package:trianutri_app/app/data/provider/api.dart';
import 'package:trianutri_app/app/data/repository/screening_repository.dart';
import 'package:trianutri_app/app/modules/copy/copy_controller.dart';

class CopyBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyReplace<CopyController>(() {
      return CopyController(
          repository: ScreeningRepository(apiClient: MyApiClient()));
    });
  }
}
