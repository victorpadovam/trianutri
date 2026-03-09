import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyApiClient {
  Future<Dio> client() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return Dio(BaseOptions(headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer ${prefs.getString('token')}"
    }));
  }
}
