// To parse this JSON data, do
//
//     final offlineSyncResponseModel = offlineSyncResponseModelFromJson(jsonString);

import 'dart:convert';

OfflineSyncResponseModel offlineSyncResponseModelFromJson(String str) => OfflineSyncResponseModel.fromJson(json.decode(str));

String offlineSyncResponseModelToJson(OfflineSyncResponseModel data) => json.encode(data.toJson());

class OfflineSyncResponseModel {
    int status;
    String message;

    OfflineSyncResponseModel({
        required this.status,
        required this.message,
    });

    factory OfflineSyncResponseModel.fromJson(Map<String, dynamic> json) => OfflineSyncResponseModel(
        status: json["status"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
    };
}
