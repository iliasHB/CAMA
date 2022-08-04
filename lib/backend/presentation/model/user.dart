import 'package:cloud_firestore/cloud_firestore.dart';

import '../../util/constants.dart';

class UserEntity {
  final String _email;
  String get email => _email;
  final String _stateCode;
  String get stateCode => _stateCode;
  final String _firstName;
  String get firstName => _firstName;
  final String _lastName;
  String get lastName => _lastName;
  final String _cdsGroup;
  String get cdsGroup => _cdsGroup;

  // initializer list
  const UserEntity({
    required String email,
    required String firstName,
    required String lastName,
    required String stateCode,
    required String cdsGroup,
  })  : _email = email,
        _stateCode = stateCode,
        _firstName = firstName,
        _lastName = lastName,
        _cdsGroup = cdsGroup;

  // forwarding constructor
  const UserEntity.anonymous()
      : this(
            email: "",
            firstName: "",
            lastName: "",
            stateCode: "",
            cdsGroup: "");

  // factory constructor
  factory UserEntity.fromDB(Map<String, Object> data) {
    final String email = data['email'] as String;
    final String firstName = data['firstName'] as String;
    final String lastName = data['lastName'] as String;
    final String stateCode = data['stateCode'] as String;
    final String cdsGroup = data['cdsGroup'] as String;
    return UserEntity(
        email: email,
        firstName: firstName,
        lastName: lastName,
        stateCode: stateCode,
        cdsGroup: cdsGroup);
  }

  factory UserEntity.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return UserEntity(
        email: data?[EMAIL],
        firstName: data?[FIRST_NAME],
        lastName: data?[LAST_NAME],
        stateCode: data?[STATE_CODE],
        cdsGroup: data?[CDS_GROUP]);
  }

  Map<String, dynamic> toFirestore() {
    return {
      EMAIL: email,
      FIRST_NAME: firstName,
      LAST_NAME: lastName,
      STATE_CODE: stateCode,
      CDS_GROUP: cdsGroup,
    };
  }

  @override
  String toString() {
    return '''
      email: $email, 
      firstName: $firstName,
      lastName: $lastName,
      stateCode: $stateCode,
      CDSGroup: $cdsGroup
    ''';
  }
}
