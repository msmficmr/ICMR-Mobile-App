import 'package:isar/isar.dart';
import 'package:mhealth/isar_db_schema/identity_proofs_schema.dart';
import 'package:mhealth/utils/app_values.dart';
import 'package:mhealth/utils/common_functions.dart';
import 'package:mhealth/utils/exceptions/app_exception.dart';
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
  int visitCount = 0;
  PatientRegistration();

  static bool areAllFieldsPresent(Map<String, dynamic> json) {
    final requiredFields = [
      "address",
      "age",
      "alternatePhoneNumber",
      "caseId",
      "consentDate",
      "createdBy",
      "district",
      "firstName",
      "gender",
      "id",
      "identityProofs",
      "institutionCodeID",
      "isCompleted",
      "isConsent",
      "lastName",
      "medicalRecordNumber",
      "occupation",
      "patientId",
      "permanentAddress",
      "phoneNumber",
      "pincode",
      "place",
      "primaryId",
      "secondaryId",
      "signedConsent",
      "signedConsentNoReason",
      "state",
      "studyCode",
      "totalCompletedSections",
      "visitDate",
      "visitMonth",
      "visitNo",
      "isSynced",
      "visitCount"
    ];

    for (String field in requiredFields) {
      if (!json.containsKey(field)) {
        return false; // Missing or null field
      }
    }
    return true; // All fields are present and not null
  }

  factory PatientRegistration.fromJson(Map<String, dynamic> data) {
    bool isValid = areAllFieldsPresent(data);
    if (!isValid) {
      throw ServerException(response: null, message: "Some fields are missing", statusCode: null);
    }

    String primaryId = data["primaryId"];
    bool hasMatch = AppValues.primaryIdPattern.hasMatch(primaryId);
    if (!hasMatch) {
      throw ServerException(response: null, message: "Invalid Primary Id", statusCode: null);
    }

    String secondaryId = data["secondaryId"];
    hasMatch = AppValues.primaryIdPattern.hasMatch(secondaryId);
    if (!hasMatch) {
      throw ServerException(response: null, message: "Invalid Secondary Id", statusCode: null);
    }
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
    registration.identityProofs = data["identityProofs"] == null ? null : IdentityProofDb.fromJson(data["identityProofs"]);
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
    registration.visitCount = data["visitCount"];
    return registration;
  }

  Map<String, dynamic> objectToJson() {
    Map<String, dynamic> json = {
      "address": address,
      "age": age,
      "alternatePhoneNumber": alternatePhoneNumber,
      "caseId": caseId,
      "consentDate": consentDate.millisecondsSinceEpoch,
      "createdBy": createdBy,
      "district": district,
      "firstName": firstName,
      "gender": gender,
      "id": id,
      "identityProofs": identityProofs?.toJson(),
      "institutionCodeID": institutionCodeID,
      "isCompleted": isCompleted,
      "isConsent": isConsent,
      "lastName": lastName,
      "medicalRecordNumber": medicalRecordNumber,
      "occupation": occupation,
      "patientId": patientId,
      "permanentAddress": permanentAddress,
      "phoneNumber": phoneNumber,
      "pincode": pincode,
      "place": place,
      "primaryId": primaryId,
      "secondaryId": secondaryId,
      "signedConsent": signedConsent,
      "signedConsentNoReason": signedConsentNoReason,
      "state": state,
      "studyCode": studyCode,
      "totalCompletedSections": totalCompletedSections,
      "visitDate": visitDate.millisecondsSinceEpoch,
      "visitMonth": visitMonth,
      "visitNo": visitNo,
      "isSynced": isSynced,
      "visitCount": visitCount
    };

    return json;
  }

  // Add a toJson method to convert the object to JSON
  Map<String, dynamic> toJson() {
    return {
      'consent': isConsent,
      'visitDate': visitDate.toIso8601String(),
      'institutionCodeID': institutionCodeID,
      'studyCode': studyCode,
      'firstName': '', //firstName,
      'lastName': '', //lastName,
      'age': age,
      'gender': gender,
      'address': '', //address,
      'district': '', //district,
      'state': '', //state,
      'pincode': '', //pincode,
      'permanentAddress': '', //permanentAddress,
      'occupation': occupation,
      'phoneNumber': '', //phoneNumber,
      'alternatePhoneNumber': '', //alternatePhoneNumber,
      'medicalRecordNumber': '', //medicalRecordNumber,
      'identityProofs': null, //identityProofs,
      'consentDate': consentDate.toIso8601String(),
      'signedConsent': signedConsent,
      'signedConsentNoReason': signedConsentNoReason,
      'patientId': CommonFunctions.randomNumber(6),
      'createdBy': createdBy,
      "place": place,
      "visitNo": visitNo,
      "visitMonth": visitMonth,
      "primaryId": primaryId,
      "secondaryId": secondaryId,
    };
  }
}
