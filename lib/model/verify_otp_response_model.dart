// To parse this JSON data, do
//
//     final verifyOtpResponseModel = verifyOtpResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:mhealth/model/user_model.dart';

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

