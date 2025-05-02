
import '../../auth/dio/dio_client.dart';
import '../models/user_model.dart';

class UserRepository {
  Future<UserModel> getMyProfile() async {
    final response = await DioClient.dio.get('/users/me');
    var data =  UserModel.fromJson(response.data);
    return data;
  }
}
