import 'package:cama/backend/domain/auth_repo.dart';
import 'package:cama/backend/presentation/model/response.dart';
import 'package:cama/backend/presentation/model/user.dart';

class AuthTask {
  final AuthRepo _authRepo;

  AuthTask({required AuthRepo authRepo}) : _authRepo = authRepo;

  Future<Response<UserEntity>> getCurrentUser() => _authRepo.getCurrentUser();

  Future<Response<UserEntity>> signInUser({
    required String email,
    required String password,
  }) =>
      _authRepo.signInUser(email: email, password: password);

  Future<Response<UserEntity>> createUser({
    required UserEntity user,
    required String password,
  }) =>
      _authRepo.createUser(user, password);

  Future<Response<void>> sendPasswordResetEmail() =>
      _authRepo.sendPasswordResetEmail();

  Future<Response<void>> confirmPasswordReset({
    required String code,
    required String newPassword,
  }) =>
      _authRepo.confirmPasswordReset(
        code: code,
        newPassword: newPassword,
      );

  Future<Response<void>> signOutUser() => _authRepo.signOutUser();
}
