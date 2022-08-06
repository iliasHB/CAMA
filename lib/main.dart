import 'package:cama/backend/di/auth_dependency.dart';
import 'package:cama/backend/presentation/model/user.dart';
import 'package:cama/backend/util/status.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final _viewModel = AuthDependency.authViewModel;

  final user = UserEntity(
    email: 'adebc007@gmail.com',
    firstName: 'Adebisi',
    lastName: 'Yusuf',
    stateCode: 'FC/21C/6462',
    cdsGroup: 'Drug Free',
    phoneNumber: '08060713589',
    state: 'FCT Abuja',
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        TextButton(
          child: const Text(
            "Sign In",
            style: TextStyle(color: Colors.red),
          ),
          onPressed: () async {
            final result = await _viewModel.signInUser(
                email: "adebc007@gmail.com", password: "password");
            if (result.getState() == TaskState.SUCCESS) {
              print('sign in successful with data: ${result.getData()}');
            } else if (result.getState() == TaskState.FAILED) {
              print(result.getErrorMessage());
            }
          },
        ),
        TextButton(
          child: const Text("Create User"),
          onPressed: () async {
            final result =
                await _viewModel.createUser(user: user, password: "password");
            if (result.getState() == TaskState.SUCCESS) {
              print('Create User: ${result.getData().toString()}');
            } else {
              print('Create User: ${result.getErrorMessage()}');
            }
          },
        ),
        TextButton(
            child: const Text("Get user"),
            onPressed: () async {
              final result = await _viewModel.getCurrentUser();
              if (result.getState() == TaskState.SUCCESS) {
                print('Get user: ${result.getData().toString()}');
              } else {
                print(result.getErrorMessage());
              }
            }),
        TextButton(
            child: const Text("Sign out user"),
            onPressed: () async {
              final result = await _viewModel.signOutUser();
              if (result.getState() == TaskState.FAILED) {
                print(result.getErrorMessage());
              } else {
                print('Sign out successful! ${result.getSuccessMessage()}');
              }
            }),
        TextButton(
            child: const Text("sendPasswordResetEmail"),
            onPressed: () async {
              final result = await _viewModel.sendPasswordResetEmail();
              if (result.getState() == TaskState.FAILED) {
                print(result.getErrorMessage());
              } else {
                print('sendPasswordResetEmail! ${result.getSuccessMessage()}');
              }
            }),
        TextButton(
            child: const Text("confirmPasswordReset"),
            onPressed: () async {
              final result = await _viewModel.confirmPasswordReset(
                  code: 'code', newPassword: 'password');
              if (result.getState() == TaskState.FAILED) {
                print(result.getErrorMessage());
              } else {
                print('confirmPasswordReset! ${result.getSuccessMessage()}');
              }
            }),
      ]),
    );
  }

  /*Future<String> insertUser(Map<String, dynamic> data) async {
    String result = "None";
    await firestore.collection("user").add(data).then((docRef) {
      result = docRef.id.toString();
    });
    return result;
  }

  Future<String> createUser(
      {required String email, required String password}) async {
    String result = "no user";
    try {
      final UserCredential credential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      result = credential.user?.email ?? result;
    } catch (e) {
      result = e.toString();
    }
    return result;
  }

  Future<String> signInUser(
      {required String email, required String password}) async {
    String result = 'None';
    try {
      final credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      result = credential.user?.email ?? result;
    } catch (e) {}
    return result;
  }

  String getCurrentUser() => _auth.currentUser?.email ?? "No user";*/
}
