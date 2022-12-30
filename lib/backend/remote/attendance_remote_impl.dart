import 'package:cama/backend/data/remote/remote_attendance_data_source.dart';
import 'package:cama/backend/presentation/model/attendance.dart';
import 'package:cama/backend/presentation/model/response.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AttendanceRemoteImpl implements RemoteAttendanceDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  AttendanceRemoteImpl({required this.firestore, required this.auth});

  @override
  Future<Response<void>> activateAttendance() {
    // TODO: implement activateAttendance
    throw UnimplementedError();
  }

  @override
  Future<Response<void>> deactivateAttendance() {
    // TODO: implement deactivateAttendance
    throw UnimplementedError();
  }

  @override
  Future<Response<Attendance>> getUserAttendance() {
    // TODO: implement getUserAttendance
    throw UnimplementedError();
  }

  @override
  Future<Response<void>> markAttendance(Attendance attendance) {
    // TODO: implement markAttendance
    throw UnimplementedError();
  }
}
