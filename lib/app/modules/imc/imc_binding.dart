import 'package:get/get.dart';
import 'package:trianutri_app/app/modules/imc/imc_controller.dart';

class ImcBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyReplace<ImcController>(() {
      return ImcController();
    });
  }
}
