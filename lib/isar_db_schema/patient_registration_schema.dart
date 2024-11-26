import 'dart:developer';

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
  late String place;
  String? visitNo;
  String? visitMonth;
  late String primaryId;
  late String secondaryId;
  bool isCompleted = false;
  String? caseId;
  int totalCompletedSections = 0;
  bool isSynced = false;
  PatientRegistration();
  factory PatientRegistration.fromJson(Map<String, dynamic> data) {
    //
    PatientRegistration registration = PatientRegistration();
    registration.address = data["address"];
    registration.age = data["age"];
    registration.alternatePhoneNumber = data["alternatePhoneNumber"];
    registration.caseId = data["caseId"];
    registration.consentDate = DateTime.fromMillisecondsSinceEpoch(data["consentDate"]);
    registration.createdBy = data["createdBy"];
    registration.district = data["district"];
    registration.firstName = data["firstName"];
    registration.gender = data["gender"];
    registration.id = data["id"];
    registration.identityProofs = data["identityProofs"];
    registration.institutionCodeID = data["institutionCodeID"];
    registration.isCompleted = data["isCompleted"];
    registration.isConsent = data["isConsent"];
    registration.lastName = data["lastName"];
    registration.medicalRecordNumber = data["medicalRecordNumber"];
    registration.occupation = data["occupation"];
    registration.patientId = data["patientId"];
    registration.permanentAddress = data["permanentAddress"];
    registration.phoneNumber = data["phoneNumber"];
    registration.pincode = data["pincode"];
    registration.place = data["place"];
    registration.primaryId = data["primaryId"];
    registration.secondaryId = data["secondaryId"];
    registration.signedConsent = data["signedConsent"];
    registration.signedConsentNoReason = data["signedConsentNoReason"];
    registration.state = data["state"];
    registration.studyCode = data["studyCode"];
    registration.totalCompletedSections = data["totalCompletedSections"];
    registration.visitDate = DateTime.fromMillisecondsSinceEpoch(data["visitDate"]);
    registration.visitMonth = data["visitMonth"];
    registration.visitNo = data["visitNo"];
    registration.isSynced = data["isSynced"];
    return registration;
  }

  // Add a toJson method to convert the object to JSON
  Map<String, dynamic> toJson() {
    return {
      'consent': isConsent,
      'visitDate': visitDate.toIso8601String(),
      'institutionCodeID': institutionCodeID,
      'studyCode': studyCode,
      'firstName': "", //firstName,
      'lastName': "", //lastName,
      'age': age,
      'gender': gender,
      'address': "", //address,
      'district': "", //district,
      'state': "", //state,
      'pincode': "", //pincode,
      'permanentAddress': "", //permanentAddress,
      'occupation': occupation,
      'phoneNumber': "", //phoneNumber,
      'alternatePhoneNumber': "", //alternatePhoneNumber,
      'medicalRecordNumber': "", //medicalRecordNumber,
      'identityProofs': null, //identityProofs,
      'consentDate': consentDate.toIso8601String(),
      'signedConsent': signedConsent,
      'signedConsentNoReason': signedConsentNoReason,
      'patientId': patientId,
      'createdBy': createdBy,
      "place": place,
      "visitNo": visitNo,
      "visitMonth": visitMonth,
      "primaryId": primaryId,
      "secondaryId": secondaryId,
    };
  }
}
