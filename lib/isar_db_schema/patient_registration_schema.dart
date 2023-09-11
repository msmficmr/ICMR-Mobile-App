import 'package:isar/isar.dart';
import 'package:mhealth/isar_db_schema/attachment_db_schema.dart';
part 'patient_registration_schema.g.dart';

@collection
class PatientRegistration {
  Id? id;
  AttachmentDb? consent;
  late DateTime consentDate;
  late String firstName;
  late String lastName;
  late String? gender;
  late String? dob;
  late String age;
  late String aadharId;
  late String medicalId;
  late String mobile;
  late String state;
  late String pincode;
  late String district;
  late String? signedConsent;
  late String? disclosedIncome;
  late String? income;
  late String? patientId;
}
