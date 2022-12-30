import 'package:cama/backend/domain/attendance_repo.dart';

import '../../presentation/model/attendance.dart';
import '../../presentation/model/response.dart';

class AttendanceTask {
  final AttendanceRepo _attendanceRepo;

  AttendanceTask({required AttendanceRepo attendanceRepo})
      : _attendanceRepo = attendanceRepo;

  Future<Response<Attendance>> getUserAttendance() =>
      _attendanceRepo.getUserAttendance();
  Future<Response<void>> markAttendance(Attendance attendance) =>
      _attendanceRepo.markAttendance(attendance);
  Future<Response<void>> activateAttendance() =>
      _attendanceRepo.activateAttendance();
  Future<Response<void>> deactivateAttendance() =>
      _attendanceRepo.deactivateAttendance();
}
