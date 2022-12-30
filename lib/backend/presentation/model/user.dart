import 'package:cama/backend/util/status.dart';
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
  final String _phoneNumber;
  String get phoneNumber => _phoneNumber;
  final String _state;
  String get state => _state;
  final String _profileImage;
  String get profileImage => _profileImage;
  final Privilege _privilege;
  Privilege get privilege => _privilege;

  // initializer list
  UserEntity({
    required String email,
    required String firstName,
    required String lastName,
    required String stateCode,
    required String cdsGroup,
    required String phoneNumber,
    required String state,
    String profileImage = '',
    Privilege privilege = Privilege.MEMBER,
  })  : _email = email,
        _stateCode = stateCode,
        _firstName = firstName,
        _lastName = lastName,
        _cdsGroup = cdsGroup,
        _phoneNumber = phoneNumber,
        _state = state,
        _profileImage = profileImage,
        _privilege = privilege;

  // forwarding constructor
  UserEntity.anonymous()
      : this(
          email: "",
          firstName: "",
          lastName: "",
          stateCode: "",
          cdsGroup: "",
          phoneNumber: "",
          state: "",
          profileImage: "",
        );

  // factory constructor
  factory UserEntity.fromDB(Map<String, Object> data) {
    final String email = data['email'] as String;
    final String firstName = data['firstName'] as String;
    final String lastName = data['lastName'] as String;
    final String stateCode = data['stateCode'] as String;
    final String cdsGroup = data['cdsGroup'] as String;
    final String phoneNumber = data['phoneNumber'] as String;
    final String state = data['state'] as String;
    final String profileImage = data['profileImage'] as String;
    return UserEntity(
      email: email,
      firstName: firstName,
      lastName: lastName,
      stateCode: stateCode,
      cdsGroup: cdsGroup,
      phoneNumber: phoneNumber,
      state: state,
      profileImage: profileImage,
    );
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
      cdsGroup: data?[CDS_GROUP],
      phoneNumber: data?[PHONE_NUMBER],
      state: data?[STATE],
      profileImage: data?[PROFILE_IMAGE],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      EMAIL: email,
      FIRST_NAME: firstName,
      LAST_NAME: lastName,
      STATE_CODE: stateCode,
      CDS_GROUP: cdsGroup,
      PHONE_NUMBER: phoneNumber,
      STATE: state,
      PROFILE_IMAGE: profileImage,
    };
  }

  @override
  String toString() {
    return '''
      email: $email, 
      firstName: $firstName,
      lastName: $lastName,
      stateCode: $stateCode,
      CDSGroup: $cdsGroup,
      phoneNumber: $phoneNumber,
      state: $state,
      profileImage: $profileImage,
    ''';
  }
}
