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
    await preferences.setString(PHONE_NUMBER, user.phoneNumber);
    await preferences.setString(STATE, user.state);
    await preferences.setString(PROFILE_IMAGE, user.profileImage);
    await preferences.setString(PRIVILEGE, user.privilege.name);
  }

  UserEntity _getUserData(
    SharedPreferences preferences,
  ) {
    String email = preferences.getString(EMAIL) ?? '';
    String firstName = preferences.getString(FIRST_NAME) ?? '';
    String lastName = preferences.getString(LAST_NAME) ?? '';
    String stateCode = preferences.getString(STATE_CODE) ?? '';
    String cdsGroup = preferences.getString(CDS_GROUP) ?? '';
    String phoneNumber = preferences.getString(PHONE_NUMBER) ?? '';
    String state = preferences.getString(STATE) ?? '';
    String profileImage = preferences.getString(PROFILE_IMAGE) ?? '';
    String privilege = preferences.getString(PRIVILEGE) ?? '';
    return UserEntity(
      email: email,
      firstName: firstName,
      lastName: lastName,
      stateCode: stateCode,
      cdsGroup: cdsGroup,
      phoneNumber: phoneNumber,
      state: state,
      profileImage: profileImage,
      privilege: privilege.getPrivilege(),
    );
  }

  Future<void> _deleteUserData(
    SharedPreferences preferences,
  ) async {
    await preferences.remove(EMAIL);
    await preferences.remove(FIRST_NAME);
    await preferences.remove(LAST_NAME);
    await preferences.remove(STATE_CODE);
    await preferences.remove(CDS_GROUP);
    await preferences.remove(PHONE_NUMBER);
    await preferences.remove(STATE);
    await preferences.remove(PROFILE_IMAGE);
    await preferences.remove(PRIVILEGE);
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
