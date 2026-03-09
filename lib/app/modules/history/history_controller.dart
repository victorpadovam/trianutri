import 'package:get/get.dart';
import 'package:trianutri_app/app/data/model/screening_response.dart';
import 'package:trianutri_app/app/data/repository/screening_repository.dart';

class HistoryController extends GetxController {
  late final ScreeningRepository repository;

  HistoryController({required this.repository});

  final _screenings = <ScreeningResponse>[].obs;

  List<ScreeningResponse> get screenings => _screenings.value;
  set screenings(value) => _screenings.value = value;

  loadScreenings() async {
    screenings = await repository.getScreenings();
  }

  @override
  void onInit() {
    super.onInit();
    loadScreenings();
  }
}
