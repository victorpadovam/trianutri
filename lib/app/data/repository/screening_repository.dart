import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:trianutri_app/app/data/model/screening.dart';
import 'package:trianutri_app/app/data/model/screening_response.dart';
import 'package:trianutri_app/app/data/model/screening_status_response.dart';
import 'package:trianutri_app/app/data/provider/api.dart';
import 'package:trianutri_app/app/data/utils/config.dart';

class ScreeningRepository {
  final MyApiClient apiClient;
  ScreeningRepository({required this.apiClient});

  Future<dynamic> saveScreening(Screening form) async {
    try {
      final client = await apiClient.client();
      const String endpoint = "${Config.apiEndpoint}/api/v1/screenings";
      final response = await client.post(endpoint, data: form.toJson());
      return response.data['id'];
    } on DioException catch (e) {
      print("Erro na triagem ${e.response?.data}");
      print(e.response?.statusCode);
      if (e.response?.statusCode == 406) {
        Get.snackbar(
            'Triagem', 'A triagem não está habilitada para ser salva!');
        return null;
      }
      if (e.response?.statusCode == 422) {
        Get.snackbar('Triagem', 'Informações invalidas');
        return null;
      }
      if (e.response?.statusCode != 200) {
        Get.snackbar('Triagem', 'Erro interno, contate o suporte!');
        return null;
      }
      return null;
    }
  }

  Future<ScreeningResponse> getScreening(int id) async {
    try {
      final client = await apiClient.client();
      final String endpoint = "${Config.apiEndpoint}/api/v1/screenings/$id";
      final response = await client.get(endpoint);
      return ScreeningResponse.fromJson(response.data);
    } on DioException catch (e) {
      print("Erro na triagem ${e.response?.data}");
      print(e.response?.statusCode);
      if (e.response?.statusCode != 200) {
        Get.snackbar('Triagem', 'Erro interno, contate o suporte!');
        return ScreeningResponse();
      }
      return ScreeningResponse();
    }
  }

  Future<List<ScreeningResponse>> getScreenings() async {
    try {
      final client = await apiClient.client();

      const String endpoint = "${Config.apiEndpoint}/api/v1/screenings/";
      final response = await client.get(endpoint);

      final List data = response.data['data'];
      final List<ScreeningResponse> screenings = data
          .map<ScreeningResponse>((item) => ScreeningResponse.fromJson(item))
          .toList();

      return screenings;
    } on DioException catch (e) {
      print("Erro na triagem ${e.response?.data}");
      print(e.response?.statusCode);
      if (e.response?.statusCode != 200) {
        Get.snackbar('Triagem', 'Erro interno, contate o suporte!');
        return [];
      }
      return [];
    }
  }

  Future<ScreeningStatusResponse> getStatus() async {
    try {
      final client = await apiClient.client();
      const String endpoint =
          "${Config.apiEndpoint}/api/v1/profile/screening-status";
      final response = await client.get(endpoint);
      return ScreeningStatusResponse.fromJson(response.data);
    } on DioException catch (e) {
      print("Erro no status da triagem ${e.response?.data}");
      print(e.response?.statusCode);
      if (e.response?.statusCode != 200) {
        Get.snackbar('Status da triagem', 'Erro interno, contate o suporte!');
        return ScreeningStatusResponse();
      }
      return ScreeningStatusResponse();
    }
  }
}
