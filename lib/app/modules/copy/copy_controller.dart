import 'package:get/get.dart';
import 'package:trianutri_app/app/data/repository/screening_repository.dart';
import 'package:trianutri_app/app/modules/routes/app_routes.dart';

class CopyController extends GetxController {
  late final ScreeningRepository repository;

  CopyController({required this.repository});

  close() {
    Get.toNamed(Routes.HOME);
  }
}
