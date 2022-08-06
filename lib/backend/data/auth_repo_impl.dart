import 'package:cama/backend/data/local/local_auth_data_source.dart';
import 'package:cama/backend/data/remote/remote_auth_data_source.dart';
import 'package:cama/backend/domain/auth_repo.dart';
import 'package:cama/backend/presentation/model/response.dart';
import 'package:cama/backend/presentation/model/user.dart';
import 'package:cama/backend/util/status.dart';

class AuthRepoImpl implements AuthRepo {
  final LocalAuthDataSource localSource;
  final RemoteAuthDataSource remoteSource;

  AuthRepoImpl({required this.localSource, required this.remoteSource});

  @override
  Future<Response<UserEntity>> getCurrentUser() async {
    var response = remoteSource.getCurrentUser();
    if (response.getState() == TaskState.SUCCESS) {
      // get user data from local storage
      response = await localSource.getCurrentUser();
    }
    return response;
  }

  @override
  Future<Response<UserEntity>> signInUser(
      {required String email, required String password}) async {
    final response =
        await remoteSource.signInUser(email: email, password: password);
    if (response.getState() == TaskState.SUCCESS) {
      await localSource.saveUser(response.getData() ?? UserEntity.anonymous());
    }
    return response;
  }

  @override
  Future<Response<UserEntity>> createUser(
      UserEntity user, String password) async {
    final response = await remoteSource.createUser(user, password);
    if (response.getState() == TaskState.SUCCESS) {
      await localSource.saveUser(user);
    }
    return response;
  }

  @override
  Future<Response<void>> confirmPasswordReset(
          {required String code, required String newPassword}) =>
      remoteSource.confirmPasswordReset(code: code, newPassword: newPassword);

  @override
  Future<Response<void>> sendPasswordResetEmail() =>
      remoteSource.sendPasswordResetEmail();

  @override
  Future<Response<void>> signOutUser() async {
    final response = await remoteSource.signOutUser();
    if (response.getState() == TaskState.SUCCESS) {
      await localSource.deleteUserData();
    }
    return response;
  }
}
