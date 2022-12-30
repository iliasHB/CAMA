import '../../presentation/model/attendance.dart';
import '../../presentation/model/response.dart';

abstract class LocalAttendanceDataSource {
  Future<Response<Attendance>> getUserAttendance();
}
