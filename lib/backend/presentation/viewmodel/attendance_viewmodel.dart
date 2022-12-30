import 'package:cama/backend/domain/usecases/attendance_task.dart';

import '../model/attendance.dart';
import '../model/response.dart';

class AttendanceViewModel {
  final AttendanceTask _attendanceTask;

  AttendanceViewModel({required AttendanceTask attendanceTask})
      : _attendanceTask = attendanceTask;

  Future<Response<Attendance>> getUserAttendance() =>
      _attendanceTask.getUserAttendance();
  Future<Response<void>> markAttendance(Attendance attendance) =>
      _attendanceTask.markAttendance(attendance);
  Future<Response<void>> activateAttendance() =>
      _attendanceTask.activateAttendance();
  Future<Response<void>> deactivateAttendance() =>
      _attendanceTask.deactivateAttendance();
}
