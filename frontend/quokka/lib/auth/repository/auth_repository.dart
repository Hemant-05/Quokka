import 'package:dio/dio.dart';
import 'package:quokka/auth/dio/dio_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  final Dio _dio = DioClient.dio;

  Future<void> login(String email, String password) async {

    final response = await _dio.post(
      '/auth/login',
      data: {'email': email, 'password': password},
    );

    final token = response.data['token'];
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future<void> register(String name, String email, String password) async {

    final response = await _dio.post(
      '/auth/register',
      data: {'username': name, 'email': email, 'password': password},
    );

    final token = response.data['token'];
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  Future<Map<String, dynamic>> getMe() async {
    final response = await _dio.get('/auth/me');
    return response.data;
  }
}
