import 'package:isar/isar.dart';

part 'patient_registration_schema.g.dart';

@collection
class PatientRegistrationSchema {
  Id? id;
  late List<byte> image;
  late String firstName;
  late String? middleName;
  late String lastName;
  late String gender;
  late DateTime dob;
  late int mobile;
  
}
