import '../../auth/dio/dio_client.dart';
import '../models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class UserRepository {
  Future<UserModel> getMyProfile() async {
    final response = await DioClient.dio.get('/users/me');
    var data = UserModel.fromJson(response.data);
    await saveUserToPrefs(data);
    return data;
  }

  Future<void> saveUserToPrefs(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = jsonEncode(user.toJson());
    await prefs.setString('user', userJson);
  }

  Future<UserModel?> getUserFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final userString = prefs.getString('user');

    if (userString == null) return null;

    final userJson = jsonDecode(userString);
    return UserModel.fromJson(userJson);
  }

  Future<String> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final userString = prefs.getString('user');
    if (userString == null) return '';
    final userJson = jsonDecode(userString);
    return userJson['id'];
  }

  Future<void> clearUserFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
  }

}
