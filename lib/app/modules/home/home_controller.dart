import 'package:get/get.dart';
import 'package:trianutri_app/app/data/repository/auth_repository.dart';
import 'package:trianutri_app/app/modules/routes/app_routes.dart';
import 'package:trianutri_app/app/modules/screening/screening_controller.dart';

class HomeController extends GetxController {
  late final AuthRepository repository;

  HomeController({required this.repository});

  void logout() {
    repository.logout();
  }

  void toScreening() async {
    Get.find<ScreeningController>().loadStatus();
    Get.toNamed(Routes.SCREENING);
  }
}
