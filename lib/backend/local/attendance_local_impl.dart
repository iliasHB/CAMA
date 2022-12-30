import 'package:cama/backend/data/local/local_attendance_data_source.dart';
import 'package:cama/backend/presentation/model/attendance.dart';
import 'package:cama/backend/presentation/model/response.dart';

class AttendanceLocalImpl implements LocalAttendanceDataSource {
  @override
  Future<Response<Attendance>> getUserAttendance() {
    // TODO: implement getUserAttendance
    throw UnimplementedError();
  }
}
