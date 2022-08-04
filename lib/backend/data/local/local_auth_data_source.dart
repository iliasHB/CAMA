import '../../presentation/model/response.dart';
import '../../presentation/model/user.dart';

abstract class LocalAuthDataSource {
  Future<Response<UserEntity>> getCurrentUser();
  Future<void> saveUser(UserEntity user);
  Future<void> deleteUserData();
}
