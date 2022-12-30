import 'package:cama/backend/data/local/local_attendance_data_source.dart';
import 'package:cama/backend/data/remote/remote_attendance_data_source.dart';
import 'package:cama/backend/domain/attendance_repo.dart';
import 'package:cama/backend/presentation/model/attendance.dart';
import 'package:cama/backend/presentation/model/response.dart';

class AttendanceRepoImpl implements AttendanceRepo {
  final LocalAttendanceDataSource localSource;
  final RemoteAttendanceDataSource remoteSource;

  AttendanceRepoImpl({required this.localSource, required this.remoteSource});

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
