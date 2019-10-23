import 'package:aluco/enums/gender.dart';
import 'package:aluco/utils/jwt_utils.dart';

class Student {
  int id;
  int teacherId;
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

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student()
      ..id = json['id']
      ..teacherId = JWTUtils.getTeacherId()
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

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'teacherId': JWTUtils.getTeacherId(),
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
  String toString() {
    return 'Student{id: $id, teacherId: $teacherId, name: $name, email: $email, photoUrl: $photoUrl, dateBirth: $dateBirth, phone: $phone, responsibleName: $responsibleName, responsiblePhone: $responsiblePhone, address: $address, previousSchool: $previousSchool, observation: $observation, gender: $gender}';
  }
}