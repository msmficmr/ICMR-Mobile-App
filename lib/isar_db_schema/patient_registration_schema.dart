import 'package:isar/isar.dart';
import 'package:mhealth/isar_db_schema/attachment_db_schema.dart';
part 'patient_registration_schema.g.dart';

@collection
class PatientRegistration {
  Id? id;
  AttachmentDb? consent;
  late DateTime dateOfVisit;
  late String institutionCode;
  late String studyCode;
  late String firstName;
  late String lastName;
  late String age;
  late String? gender;
  late String? address;
  late String? district;
  late String? state;
  late String? pincode;
  late String? permanentAddress;
  late String occupation;
  late String phoneNumber;
  late String? alternatePhoneNumber;
  late String? medicalRecordNumber;
  late String? aadharId;
  late DateTime consentDate;
  late String signedConsent;
  late String signedConsentNoReason;
  late String patientId;
}
