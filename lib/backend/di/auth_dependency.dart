import 'package:cama/backend/data/auth_repo_impl.dart';
import 'package:cama/backend/domain/usecases/auth_task.dart';
import 'package:cama/backend/local/auth_local_impl.dart';
import 'package:cama/backend/presentation/viewmodel/auth_viewmodel.dart';
import 'package:cama/backend/remote/auth_remote_impl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthDependency {
  const AuthDependency();
  static final AuthViewModel authViewModel = AuthViewModel(
      authTask: AuthTask(
          authRepo: AuthRepoImpl(
              localSource: AuthLocalImpl(),
              remoteSource: AuthRemoteImpl(
                  firestore: FirebaseFirestore.instance,
                  auth: FirebaseAuth.instance))));
}
