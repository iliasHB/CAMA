enum TaskState { SUCCESS, FAILED, LOADING }

enum Privilege { MEMBER, OFFICER }

extension PrivilegeExt on String {
  Privilege getPrivilege() {
    var privilege = Privilege.MEMBER;
    if (toLowerCase() == Privilege.OFFICER.name.toLowerCase()) {
      privilege = Privilege.OFFICER;
    }
    return privilege;
  }
}

enum Error { NO_USER, NO_DOCUMENT, UNKNOWN }

extension ErrorExtension on Error {
  String message() {
    String result = '';
    switch (this) {
      case Error.NO_USER:
        result = 'No user exists';
        break;
      case Error.NO_DOCUMENT:
        result = 'No document found';
        break;
      case Error.UNKNOWN:
        result = "Ooops! an error occurred. Try again.";
        break;
    }
    return result;
  }
}
