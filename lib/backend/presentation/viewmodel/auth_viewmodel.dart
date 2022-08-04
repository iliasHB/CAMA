import 'package:cama/backend/domain/usecases/auth_task.dart';
import 'package:cama/backend/presentation/model/response.dart';

import '../model/user.dart';

class AuthViewModel {
  AuthViewModel({required AuthTask authTask}) : _authTask = authTask;

  final AuthTask _authTask;

  Future<Response<UserEntity>> getCurrentUser() => _authTask.getCurrentUser();

  Future<Response<UserEntity>> signInUser({
    required String email,
    required String password,
  }) =>
      _authTask.signInUser(email: email, password: password);

  Future<Response<UserEntity>> createUser({
    required UserEntity user,
    required String password,
  }) =>
      _authTask.createUser(user: user, password: password);

  Future<Response<void>> sendPasswordResetEmail() =>
      _authTask.sendPasswordResetEmail();

  Future<Response<void>> confirmPasswordReset({
    required String code,
    required String newPassword,
  }) =>
      _authTask.confirmPasswordReset(
        code: code,
        newPassword: newPassword,
      );

  Future<Response<void>> signOutUser() => _authTask.signOutUser();
}
