import '../../presentation/model/response.dart';
import '../../presentation/model/user.dart';

abstract class RemoteAuthDataSource {
  Response<UserEntity> getCurrentUser();
  Future<Response<UserEntity>> signInUser(
      {required String email, required String password});
  Future<Response<UserEntity>> createUser(UserEntity user, String password);
  Future<Response<void>> sendPasswordResetEmail();
  Future<Response<void>> confirmPasswordReset(
      {required String code, required String newPassword});
  Future<Response<void>> signOutUser();
}
