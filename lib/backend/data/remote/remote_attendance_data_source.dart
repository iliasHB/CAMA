import '../../presentation/model/attendance.dart';
import '../../presentation/model/response.dart';

abstract class RemoteAttendanceDataSource {
  Future<Response<Attendance>> getUserAttendance();
  Future<Response<void>> markAttendance(Attendance attendance);
  Future<Response<void>> activateAttendance();
  Future<Response<void>> deactivateAttendance();
}