import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:trianutri_app/app/data/model/screening.dart';
import 'package:trianutri_app/app/data/model/screening_response.dart';
import 'package:trianutri_app/app/data/model/screening_status_response.dart';
import 'package:trianutri_app/app/data/repository/screening_repository.dart';
import 'package:trianutri_app/app/modules/routes/app_routes.dart';

class ScreeningResultController extends GetxController {
  late final ScreeningRepository repository;

  ScreeningResultController({required this.repository});
  final _loading = true.obs;

  final _sum = 0.obs;
  final _createdAt = ''.obs;

  final Screening form = Screening();
  final _screening = ScreeningResponse().obs;
  final _screeningStatus = ScreeningStatusResponse().obs;

  set loading(value) => _loading.value = value;
  get loading => _loading.value;

  set sum(value) => _sum.value = value;
  get sum => _sum.value;

  set createdAt(value) => _createdAt.value = value;
  get createdAt => _createdAt.value;

  set screening(value) => _screening.value = value;
  ScreeningResponse get screening => _screening.value;

  set screeningStatus(value) => _screeningStatus.value = value;
  ScreeningStatusResponse get screeningStatus => _screeningStatus.value;

  loadScreening() async {
    loading = true;
    screening = await repository.getScreening(Get.arguments['screeningId']);
    sum = screening.sum!;
    createdAt = DateFormat("dd/MM/y H:m:s").format(screening.createdAt!);
    loading = false;
  }

  close() {
    Get.toNamed(Routes.HOME);
  }

  @override
  void onInit() {
    super.onInit();
    loadScreening();
  }
}
