import 'package:isar/isar.dart';
import 'package:mhealth/isar_db_schema/attachment_db_schema.dart';
import 'package:mhealth/isar_db_schema/identity_proofs_schema.dart';
part 'patient_registration_schema.g.dart';

@collection
class PatientRegistration {
  Id? id;
  // List<AttachmentDb>? consent;
  late String isConsent;
  late DateTime visitDate;
  late String institutionCodeID;
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
  late IdentityProofDb? identityProofs;
  late DateTime consentDate;
  late String signedConsent;
  late String signedConsentNoReason;
  late String patientId;
  late String createdBy;

  // Add a toJson method to convert the object to JSON
  Map<String, dynamic> toJson() {
    return {
      'consent': isConsent,
      'visitDate': visitDate.toIso8601String(),
      'institutionCodeID': institutionCodeID,
      'studyCode': studyCode,
      'firstName': firstName,
      'lastName': lastName,
      'age': age,
      'gender': gender,
      'address': address,
      'district': district,
      'state': state,
      'pincode': pincode,
      'permanentAddress': permanentAddress,
      'occupation': occupation,
      'phoneNumber': phoneNumber,
      'alternatePhoneNumber': alternatePhoneNumber,
      'medicalRecordNumber': medicalRecordNumber,
      'identityProofs': identityProofs,
      'consentDate': consentDate.toIso8601String(),
      'signedConsent': signedConsent,
      'signedConsentNoReason': signedConsentNoReason,
      'patientId': patientId,
      'createdBy': createdBy
    };
  }
}
