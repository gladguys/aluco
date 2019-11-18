import 'package:aluco/core/utils/jwt_utils.dart';
import 'package:aluco/enums/gender.dart';

import 'base_model.dart';

class Student implements BaseModel<Student> {
  int id;
  int teacherId;
  String registrationNumber;
  String name;
  String email;
  String photoUrl;
  String dateBirth;
  String phone;
  String responsibleName;
  String responsiblePhone;
  String address;
  String previousSchool;
  String observation;
  Gender gender;

  Student();

  @override
  int getId() => id;

  @override
  Student fromJson(Map<String, dynamic> json) {
    return Student()
      ..id = json['id']
      ..teacherId = JWTUtils.getTeacherId()
      ..registrationNumber = json['registrationNumber']
      ..name = json['name']
      ..email = json['email']
      ..photoUrl = json['photo_url']
      ..dateBirth = json['date_birth']
      ..phone = json['phone']
      ..responsibleName = json['responsibleName']
      ..responsiblePhone = json['responsiblePhone']
      ..address = json['address']
      ..previousSchool = json['previousSchool']
      ..observation = json['observation']
      ..gender = json['gender'] == 0 ? Gender.male : Gender.female;
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'teacherId': JWTUtils.getTeacherId(),
      'registrationNumber': registrationNumber,
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
      'dateBirth': dateBirth,
      'phone': phone,
      'responsibleName': responsibleName,
      'responsiblePhone': responsiblePhone,
      'address': address,
      'previousSchool': previousSchool,
      'observation': observation,
      'gender': gender.index,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Student &&
              runtimeType == other.runtimeType &&
              id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Student{id: $id, teacherId: $teacherId, registrationNumber: $registrationNumber, name: $name, email: $email, photoUrl: $photoUrl, dateBirth: $dateBirth, phone: $phone, responsibleName: $responsibleName, responsiblePhone: $responsiblePhone, address: $address, previousSchool: $previousSchool, observation: $observation, gender: $gender}';
  }
}