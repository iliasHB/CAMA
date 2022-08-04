import '../../util/status.dart';

abstract class Response<T> {
  T? getData();
  TaskState getState();
  String getErrorMessage();
  String getSuccessMessage();
}
