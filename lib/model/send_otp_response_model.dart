// To parse this JSON data, do
//
//     final sendOtpResponseModel = sendOtpResponseModelFromJson(jsonString);

import 'dart:convert';

SendOtpResponseModel sendOtpResponseModelFromJson(String str) => SendOtpResponseModel.fromJson(json.decode(str));

String sendOtpResponseModelToJson(SendOtpResponseModel data) => json.encode(data.toJson());

class SendOtpResponseModel {
  int? statusCode;
  String? message;

  SendOtpResponseModel({
    this.statusCode,
    this.message,
  });

  factory SendOtpResponseModel.fromJson(Map<String, dynamic> json) => SendOtpResponseModel(
        statusCode: json["statusCode"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
      };
}
