import 'package:cama/backend/presentation/model/response.dart';
import 'package:cama/backend/presentation/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../data/remote/remote_auth_data_source.dart';
import '../util/constants.dart';
import '../util/status.dart';

class AuthRemoteImpl implements RemoteAuthDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  AuthRemoteImpl({required this.firestore, required this.auth});

  @override
  Response<UserEntity> getCurrentUser() {
    final user = auth.currentUser;
    if (user == null) {
      return AuthResponse(
          state: TaskState.FAILED, errorMessage: Error.NO_USER.message());
    }
    final data = AuthResponse(state: TaskState.SUCCESS);
    return data;
  }

  @override
  Future<Response<UserEntity>> signInUser(
      {required String email, required String password}) async {
    AuthResponse response = AuthResponse();
    try {
      final credentials = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (credentials.user != null) {
        // retrieve user details from remote DB
        final docSnapshot = await firestore
            .collection(CORP_COLL)
            .where(EMAIL, isEqualTo: credentials.user?.email)
            .withConverter(
                fromFirestore: UserEntity.fromFirestore,
                toFirestore: (UserEntity user, _) => user.toFirestore())
            .get();
        if (docSnapshot.docs.isNotEmpty) {
          // proceed to return user details for local storage
          final user = docSnapshot.docs.first.data();
          response = AuthResponse(state: TaskState.SUCCESS, user: user);
        } else {
          response = AuthResponse(
              state: TaskState.FAILED,
              errorMessage: 'Login successful! User does not exist in DB.');
        }
      } else {
        response = AuthResponse(
            state: TaskState.FAILED,
            errorMessage: 'Login failed. User does not exist.');
      }
    } on FirebaseAuthException catch (e) {
      response = AuthResponse(
          state: TaskState.FAILED,
          errorMessage: e.message ?? Error.UNKNOWN.message());
      print(
          'FirebaseAuth: Sign in failed with message: ${e.message} and code: ${e.code}');
    } on Exception catch (e) {
      response = AuthResponse(
          state: TaskState.FAILED, errorMessage: Error.UNKNOWN.message());
      print('Signing in user failed: ${e.toString()}');
    }
    return response;
  }

  @override
  Future<Response<UserEntity>> createUser(
    UserEntity user,
    String password,
  ) async {
    AuthResponse response = AuthResponse();
    try {
      final credentials = await auth.createUserWithEmailAndPassword(
          email: user.email, password: password);
      if (credentials.user != null) {
        // save user data in remote database
        final docRef = await firestore
            .collection(CORP_COLL)
            .withConverter(
                fromFirestore: UserEntity.fromFirestore,
                toFirestore: (UserEntity user, options) => user.toFirestore())
            .add(user);
        print('Doc added with ID: ${docRef.id}');
        // return user data for local storage
        response = AuthResponse(state: TaskState.SUCCESS, user: user);
      } else {
        response = AuthResponse(
            state: TaskState.FAILED, errorMessage: 'Registration failed.');
      }
    } on FirebaseAuthException catch (e) {
      response = AuthResponse(
          state: TaskState.FAILED, errorMessage: e.message ?? e.code);
      print(
          'FirebaseAuth: Create user failed with message: ${e.message} and code: ${e.code}');
    } on Exception catch (e) {
      response = AuthResponse(
          state: TaskState.FAILED, errorMessage: Error.UNKNOWN.message());
      print('Create user failed: ${e.toString()}');
    }
    return response;
  }

  @override
  Future<Response<void>> confirmPasswordReset(
      {required String code, required String newPassword}) async {
    Response response = AuthResponse();
    try {
      await auth.confirmPasswordReset(code: code, newPassword: newPassword);
      response = AuthResponse(
          state: TaskState.SUCCESS,
          successMessage: 'Password reset completed successfully!');
      print('Password reset completed successfully!');
    } on FirebaseAuthException catch (e) {
      response = AuthResponse(
          state: TaskState.FAILED,
          errorMessage: e.message ?? Error.UNKNOWN.message());
      print(
          'FirebaseAuth: confirming password reset failed with message: ${e.message} and code: ${e.code}');
    } on Exception catch (e) {
      response = AuthResponse(
          state: TaskState.FAILED, errorMessage: Error.UNKNOWN.message());
      print('confirmPasswordReset failed: ${e.toString()}');
    }
    return response;
  }

  @override
  Future<Response<void>> sendPasswordResetEmail() async {
    Response response = AuthResponse();
    final String email = auth.currentUser?.email ?? '';
    if (email.isNotEmpty) {
      try {
        await auth.sendPasswordResetEmail(email: email);
        response = AuthResponse(
            state: TaskState.SUCCESS,
            successMessage: 'Password reset email has been sent successfully!');
        print('Reset email sent successfully!');
      } on FirebaseAuthException catch (e) {
        response = AuthResponse(
            state: TaskState.FAILED,
            errorMessage: e.message ?? Error.UNKNOWN.message());
        print(
            'FirebaseAuth: sending password reset email failed with message: ${e.message} and code: ${e.code}');
      } on Exception catch (e) {
        response = AuthResponse(
            state: TaskState.FAILED, errorMessage: Error.UNKNOWN.message());
        print('sendPasswordResetEmail failed: ${e.toString()}');
      }
    } else {
      response = AuthResponse(
          state: TaskState.FAILED, errorMessage: Error.NO_USER.message());
    }
    return response;
  }

  @override
  Future<Response<void>> signOutUser() async {
    await auth.signOut();
    return AuthResponse(
        state: TaskState.SUCCESS, successMessage: 'You have been logged out.');
  }
}

/*@override
  UserEntity getCurrentUser() {
    final user = auth.currentUser;
    if (user == null) {
      throw NoUserException(message: "No user exists");
    }
    String email = "user.email";
    String firstName = '';
    String lastName = '';
    String stateCode = '';
    String cdsGroup = '';
    return UserEntity(
        email: email,
        firstName: firstName,
        lastName: lastName,
        stateCode: stateCode,
        cdsGroup: cdsGroup);
  }

  Future<UserEntity> _getUserDetails(String email, [String? id]) async {
    try {
      final snapshot = await firestore
          .collection(CORP_COLL)
          .where(EMAIL, isEqualTo: email)
          .limit(1)
          .get();
      if (snapshot.docs.isEmpty) {
        throw NoDocumentFoundException(message: 'User document does not exist');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<UserEntity> signInUser(String email, String password) async {
    try {
      final credentials = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (credentials.user.)
    } on FirebaseAuthException catch (e) {
      print('Failed with error code:${e.code}');
      print(e.message);
    }
  }*/

class AuthResponse implements Response<UserEntity> {
  final TaskState state;
  final UserEntity? user;
  final String errorMessage;
  final String successMessage;

  AuthResponse({
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
