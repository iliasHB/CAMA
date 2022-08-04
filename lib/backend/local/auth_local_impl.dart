import 'package:cama/backend/data/local/local_auth_data_source.dart';
import 'package:cama/backend/presentation/model/response.dart';
import 'package:cama/backend/presentation/model/user.dart';
import 'package:cama/backend/util/constants.dart';
import 'package:cama/backend/util/status.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalImpl implements LocalAuthDataSource {
  @override
  Future<Response<UserEntity>> getCurrentUser() async {
    final preferences = await SharedPreferences.getInstance();
    final user = _getUserData(preferences);
    return _LocalResponse(state: TaskState.SUCCESS, user: user);
  }

  @override
  Future<void> saveUser(UserEntity user) async {
    final preferences = await SharedPreferences.getInstance();
    await _saveUserData(preferences, user);
  }

  @override
  Future<void> deleteUserData() async {
    final preferences = await SharedPreferences.getInstance();
    await _deleteUserData(preferences);
  }

  Future<void> _saveUserData(
    SharedPreferences preferences,
    UserEntity user,
  ) async {
    await preferences.setString(EMAIL, user.email);
    await preferences.setString(FIRST_NAME, user.firstName);
    await preferences.setString(LAST_NAME, user.lastName);
    await preferences.setString(STATE_CODE, user.stateCode);
    await preferences.setString(CDS_GROUP, user.cdsGroup);
  }

  UserEntity _getUserData(
    SharedPreferences preferences,
  ) {
    String email = preferences.getString(EMAIL) ?? '';
    String firstName = preferences.getString(FIRST_NAME) ?? '';
    String lastName = preferences.getString(LAST_NAME) ?? '';
    String stateCode = preferences.getString(STATE_CODE) ?? '';
    String cdsGroup = preferences.getString(CDS_GROUP) ?? '';
    return UserEntity(
        email: email,
        firstName: firstName,
        lastName: lastName,
        stateCode: stateCode,
        cdsGroup: cdsGroup);
  }

  Future<void> _deleteUserData(
    SharedPreferences preferences,
  ) async {
    await preferences.remove(EMAIL);
    await preferences.remove(FIRST_NAME);
    await preferences.remove(LAST_NAME);
    await preferences.remove(STATE_CODE);
    await preferences.remove(CDS_GROUP);
  }
}

class _LocalResponse implements Response<UserEntity> {
  final TaskState state;
  final UserEntity? user;
  final String errorMessage;
  final String successMessage;

  _LocalResponse({
    this.state = TaskState.LOADING,
    this.user,
    this.errorMessage = 'Ooops! an error occurred. Try again.',
    this.successMessage = 'Operation successful!',
  });

  @override
  UserEntity? getData() => user;

  @override
  String getErrorMessage() => errorMessage;

  @override
  TaskState getState() => state;

  @override
  String getSuccessMessage() => successMessage;
}
