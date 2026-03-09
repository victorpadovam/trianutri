import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:trianutri_app/app/data/model/City.dart';
import 'package:trianutri_app/app/data/model/State.dart';
import 'package:trianutri_app/app/data/model/register.dart';
import 'package:trianutri_app/app/data/provider/api.dart';
import 'package:trianutri_app/app/data/utils/config.dart';

class RegisterRepository {
  final MyApiClient apiClient;
  RegisterRepository({required this.apiClient});

  Future<List<StateModel>> states() async {
    try {
      final client = await apiClient.client();

      const String endpoint = "${Config.apiEndpoint}/api/v1/states";
      final response = await client.get(endpoint);
      final List data = response.data;
      final List<StateModel> states =
          data.map<StateModel>((state) => StateModel.fromJson(state)).toList();
      return states;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<CityModel>> cities(String stateId) async {
    try {
      final client = await apiClient.client();

      final String endpoint =
          "${Config.apiEndpoint}/api/v1/states/$stateId/cities";
      final response = await client.get(endpoint);
      final List data = response.data;
      final List<CityModel> cities =
          data.map<CityModel>((city) => CityModel.fromJson(city)).toList();
      return cities;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<bool> register(Register form) async {
    try {
      final client = await apiClient.client();
      const String endpoint = "${Config.apiEndpoint}/api/v1/register";
      print(form.toJson());
      var response = await client.post(endpoint, data: form.toJson());

      print(response);

      Get.snackbar('Registro', 'A sua conta foi criada com sucesso!');
      return true;
    } on DioException catch (e) {
      print("Erro no cadastro ${e.response?.data}");
      print(e.response?.statusCode);
      if (e.response?.statusCode == 422) {
        Get.snackbar('Registro', 'O E-mail já está sendo utilizado.');
      } else {
        Get.snackbar('Erro', "${e.response?.data}");
      }

      return false;
    }
  }
}
