// To parse this JSON data, do
//
//     final verifyOtpResponseModel = verifyOtpResponseModelFromJson(jsonString);

import 'dart:convert';

VerifyOtpResponseModel verifyOtpResponseModelFromJson(String str) => VerifyOtpResponseModel.fromJson(json.decode(str));

String verifyOtpResponseModelToJson(VerifyOtpResponseModel data) => json.encode(data.toJson());

class VerifyOtpResponseModel {
  String? accessToken;
  String? accessTokenExpiresIn;
  String? refreshToken;
  String? refreshTokenExpiresIn;
  String? status;
  int? statusCode;
  UserModel? user;

  VerifyOtpResponseModel({
    this.accessToken,
    this.accessTokenExpiresIn,
    this.refreshToken,
    this.refreshTokenExpiresIn,
    this.status,
    this.statusCode,
    this.user,
  });

  factory VerifyOtpResponseModel.fromJson(Map<String, dynamic> json) => VerifyOtpResponseModel(
        accessToken: json["accessToken"],
        accessTokenExpiresIn: json["accessTokenExpiresIn"],
        refreshToken: json["refreshToken"],
        refreshTokenExpiresIn: json["refreshTokenExpiresIn"],
        status: json["status"],
        statusCode: json["statusCode"],
        user: UserModel.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "accessToken": accessToken,
        "accessTokenExpiresIn": accessTokenExpiresIn,
        "refreshToken": refreshToken,
        "refreshTokenExpiresIn": refreshTokenExpiresIn,
        "status": status,
        "statusCode": statusCode,
        "user": user?.toJson(),
      };
}

class UserModel {
  String? userId;
  dynamic version;
  String? userName;
  String? salutation;
  String? firstName;
  String? middleName;
  String? lastName;
  String? email;
  String? gender;
  dynamic roles;
  dynamic organizations;
  dynamic locations;
  bool? isDeleted;
  String? createdBy;
  DateTime? createdOn;
  String? lastModifiedBy;
  DateTime? lastModifiedOn;
  String? profileName;
  String? fullNameSearchable;
  UserModel({
     this.userId,
    this.roles,
    this.createdBy,
    this.createdOn,
    this.lastModifiedBy,
    this.lastModifiedOn,
    this.profileName,
    this.fullNameSearchable,
    this.userName,
    this.firstName,
    this.lastName,
    this.email,
    this.gender,
    this.version,
    this.salutation,
    this.middleName,
    this.organizations,
    this.locations,
    this.isDeleted,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        userId: json["userId"],
        version: json["version"],
        userName: json["userName"],
        salutation: json["salutation"],
        firstName: json["firstName"],
        middleName: json["middleName"],
        lastName: json["lastName"],
        email: json["email"],
        gender: json["gender"],
        roles: json["roles"],
        organizations: json["organizations"],
        locations: json["locations"],
        isDeleted: json["isDeleted"],
        createdBy: json["createdBy"],
        createdOn: json["createdOn"] == null ? null : DateTime.parse(json["createdOn"]),
        lastModifiedBy: json["lastModifiedBy"],
        lastModifiedOn: json["lastModifiedOn"] == null ? null : DateTime.parse(json["lastModifiedOn"]),
        profileName: json["profileName"],
        fullNameSearchable: json["fullNameSearchable"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "version": version,
        "userName": userName,
        "salutation": salutation,
        "firstName": firstName,
        "middleName": middleName,
        "lastName": lastName,
        "email": email,
        "gender": gender,
        "roles": roles,
        "organizations": organizations,
        "locations": locations,
        "isDeleted": isDeleted,
        "createdBy": createdBy,
        "createdOn": createdOn?.toIso8601String(),
        "lastModifiedBy": lastModifiedBy,
        "lastModifiedOn": lastModifiedOn?.toIso8601String(),
        "profileName": profileName,
        "fullNameSearchable": fullNameSearchable,
      };
}
